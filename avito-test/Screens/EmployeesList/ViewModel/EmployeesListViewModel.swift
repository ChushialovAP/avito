import Foundation

class EmployeesViewModel: NSObject {
    private var employeeService: EmployeesServiceProtocol

    init(employeeService: EmployeesServiceProtocol = EmployeesService()) {
        self.employeeService = employeeService
    }

    func getEmployees() {
        employeeService.getEmployees { success, model, error in
            if success, let employees = model {
                self.fetchData(employees: employees)
            } else {
                print(error!)
            }
        }
    }
    
    var reloadTableView: (() -> Void)?
    
    var employeeCellViewModels = [EmployeeCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    func fetchData(employees: [Employee]) {
        var vms = [EmployeeCellViewModel]()
        for employee in employees {
            vms.append(createCellModel(employee: employee))
        }
        employeeCellViewModels = vms
    }
    
    func createCellModel(employee: Employee) -> EmployeeCellViewModel {
        let name = employee.name
        let phoneNumber = employee.phoneNumber
        let skills = employee.skills
        
        return EmployeeCellViewModel(name: name, phoneNumber: phoneNumber, skills: skills)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> EmployeeCellViewModel {
        return employeeCellViewModels[indexPath.row]
    }
}
