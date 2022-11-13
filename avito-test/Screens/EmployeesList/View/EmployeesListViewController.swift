import UIKit

class EmployeesListViewController: UIViewController {
    
    lazy var viewModel = {
        EmployeesViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func initViewModel() {
        viewModel.getEmployees()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

}
