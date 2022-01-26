
//  APIExample
//
//  Created by Jagadeesh on 06/12/21.
//
//
//  PersonDetails.swift
import Foundation

protocol EmployeeManagerDelegate {
    func dataReceived(employeeList: [EmployeeModel])
    func errorReceived(error: String)
}

struct EmployeeManager  {
    let personURL = "http://dummy.restapiexample.com/api/v1/employees"
    let employeeURL = "http://dummy.restapiexample.com/api/v1/employee"
     var delegate: EmployeeManagerDelegate?
    
    func employeeListDetails(id: String) {
        let urlString = "\(personURL)"
        getListOfEmployees(with: urlString)
    }
    
    func employeeDetails(id: String) {
        let urlString = "\(employeeURL)/\(id)"
        getEmployeeDetails(with: urlString)
    }
    
    func getListOfEmployees(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                    self.delegate?.errorReceived(error: error!.localizedDescription)
                    }
                      return
                }
                if let safeData = data {
                    if let employee = self.parseEmployeesListJSON(person: safeData)   {
                        DispatchQueue.main.async {
                            self.delegate?.dataReceived(employeeList: employee.data)
                            print(employee)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseEmployeesListJSON(person: Data) -> Employee?  {
        let decoder = JSONDecoder()
        do {
            let employeeModel = try decoder.decode(Employee.self, from: person)
            
            return employeeModel
            
        } catch let error as NSError  {
            print(error.localizedDescription)
            DispatchQueue.main.async  {
            self.delegate?.errorReceived(error: error.localizedDescription)
            }
            return  nil
        }
    }
    
    func getEmployeeDetails(with urlString: String) {
           if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async  {
                    self.delegate?.errorReceived(error: error!.localizedDescription)
                    }
                       return
                }
            if let safeData = data {
                if let employee = self.parseEmployeeIdJSON(person: safeData)   {
                    DispatchQueue.main.async {
                        self.delegate?.dataReceived(employeeList: [employee.data])
                            print(employee)
                        }
                    }
                }
            }
            task.resume()
        }
    }
   
    func parseEmployeeIdJSON(person: Data) -> EmployeeData? {
        let decoder = JSONDecoder()
        do {
            let employeeModel = try decoder.decode(EmployeeData.self, from: person)
            
            return employeeModel
            
        } catch let error as NSError  {
            print(error.localizedDescription)
            self.delegate?.errorReceived(error: error.localizedDescription)
            return  nil
        }
        
    }
    
    
}
