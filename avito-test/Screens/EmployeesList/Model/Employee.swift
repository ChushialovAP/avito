import Foundation

/* {
 "company": {
     "name":"Avito",
     "employees": [{
             "name": "John",
             "phone_number": "769453",
             "skills": ["Swift", "iOS"]
         }, {
             "name": "Diego",
             "phone_number": "987924",
             "skills": ["Kotlin", "Android"]
         }, {
             "name": "Alfred",
             "phone_number": "452533",
             "skills": ["Objective-C", "Android", "Photoshop"]
         }, {
             "name": "John",
             "phone_number": "212456",
             "skills": ["Java", "Python"]
         }, {
             "name": "Mat",
             "phone_number": "778975",
             "skills": ["Android", "MovieMaker"]
         }, {
             "name": "Bob",
             "phone_number": "456468",
             "skills": ["Groovy", "Kotlin"]
         }, {
             "name": "Marty",
             "phone_number": "321789",
             "skills": ["Android", "PHP", "C#"]
         }]
     }
}*/

struct DataModel: Codable {
    let company: Company
}

// MARK: - Company
struct Company: Codable {
    let employees: [Employee]
}

// MARK: - Employee
struct Employee: Codable {
    let name, phoneNumber: String
    let skills: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}
