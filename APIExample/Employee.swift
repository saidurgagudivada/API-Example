//
//  Person.swift
//  APIExample
//
//  Created by Jagadeesh on 06/12/21.
//

/* first line commit */
import Foundation
/* nothing to commit*/
struct Employee : Codable {
    let data : [EmployeeModel]
}

struct EmployeeData : Codable {
    let data : EmployeeModel
}

struct EmployeeModel: Codable  {
    var id: Int
    var employee_name: String
    var employee_salary: Int
    var employee_age: Int
    var profile_image: String = ""
}




