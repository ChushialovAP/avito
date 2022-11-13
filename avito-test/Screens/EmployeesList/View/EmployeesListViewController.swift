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
