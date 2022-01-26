//
//  ViewController.swift
//  APIExample
//
//  Created by Jagadeesh on 06/12/21.
//

import UIKit

class EmployeeListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var manager: EmployeeManager = EmployeeManager()
    var listOfPeople = [EmployeeModel]()
    var id: String = ""
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.dataSource = self
        manager.delegate = self
        if id.count > 0 {
            manager.employeeDetails(id: id)
        } else {
        manager.getListOfEmployees(with: manager.personURL)
        }
        
        indicator.frame = CGRect(x: 200, y: 450, width: 50, height: 50)
        indicator.center = view.center
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        self.showLoader()
        
    
    }
    
    func showLoader() {
        indicator.startAnimating()
    }
    
    func hideLoader() {
        indicator.stopAnimating()
    }
    
    @IBAction func DoneTapped(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func RefreshTapped(_ sender: Any) {
        if id.count > 0 {
            manager.employeeDetails(id: id)
        } else {
        manager.getListOfEmployees(with: manager.personURL)
        }
    }

    
}


extension EmployeeListViewController: EmployeeManagerDelegate {
    func errorReceived(error: String)   {
        self.hideLoader()
        let alert = UIAlertController(title: "Alert", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
       // self.present(alert, animated: true, completion: nil)
        self.show(alert, sender: nil)
    }
    
    
    func dataReceived(employeeList: [EmployeeModel]) {
        self.listOfPeople = employeeList
        self.hideLoader()
        tableView.reloadData()
    }
}


extension EmployeeListViewController: UITableViewDataSource   {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  listOfPeople.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!
        EmployeeCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemBlue.cgColor
    
        
        let person = listOfPeople[indexPath.row]
        cell.idLabel?.text = "employeeId:     \(String(person.id))"
        cell.nameLabel?.text = "employeeName:  \(person.employee_name)"
        cell.salaryLabel?.text = "employeeSalary:  \("\(person.employee_salary)")"
        cell.ageLabel?.text = "employeeAge:      \("\(person.employee_age)")"
       // cell.Label5?.text = person.profile_image
        
        return cell
    }
    
}


