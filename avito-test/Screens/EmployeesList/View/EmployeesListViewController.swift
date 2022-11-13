import UIKit

class EmployeesListViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var employeesListTableView: UITableView!
    
    lazy var viewModel = {
        EmployeesViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        employeesListTableView.dataSource = self
        employeesListTableView.delegate = self
        employeesListTableView.register(EmployeeTableViewCell.nib, forCellReuseIdentifier: EmployeeTableViewCell.identifier)
        // Do any additional setup after loading the view.
        initViewModel()
    }

    func initViewModel() {
        viewModel.getEmployees()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.employeesListTableView.reloadData()
            }
        }
        viewModel.showError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showError(error: error)
            }
        }
    }
    
    func showError(error: String) {
        let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { _ in
            self.viewModel.getEmployees()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension EmployeesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employeeCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.identifier, for: indexPath) as? EmployeeTableViewCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}
