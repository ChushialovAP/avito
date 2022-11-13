import Foundation

protocol EmployeesServiceProtocol {
    func getEmployees(completion: @escaping (_ success: Bool, _ results: [Employee]?, _ error: String?) -> ())
}

class EmployeesService: EmployeesServiceProtocol {
    let url = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"

    private let cache = Cache<String, [Employee]>()
    
    func getEmployees(completion: @escaping (Bool, [Employee]?, String?) -> ()) {
        if let cached = cache[url] {
            print("from cache")
            return completion(true, cached, nil)
        }

        HttpRequestHelper().GET(url: url, params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let companyData = try JSONDecoder().decode(DataModel.self, from: data!)
                    let employeesData = companyData.company.employees.sorted(by: {
                        return $0.name < $1.name
                    })
                    self.cache[self.url] = employeesData
                    completion(true, employeesData, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Company to model")
                }
            } else {
                completion(false, nil, "Error: Employees GET Request failed")
            }
        }
    }
}
