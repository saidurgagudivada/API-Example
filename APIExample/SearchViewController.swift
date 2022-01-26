//
//  SearchViewController.swift
//  APIExample
//
//  Created by Jagadeesh on 06/12/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var viewAllButton: UIButton!
    
    @IBOutlet weak var searchButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = UIColor.blue.cgColor
        searchButton.backgroundColor = UIColor.blue
        
        viewAllButton.layer.borderWidth = 1
        viewAllButton.layer.borderColor = UIColor.black.cgColor
       
        self.navigationController?.navigationBar.isHidden = true
 }
    
    
    @IBAction func viewAllButtonTapped(_ sender: Any) {
        let VC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ViewController") as! EmployeeListViewController
       // present(VC,animated: true)
       self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        let Vc =  UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ViewController") as! EmployeeListViewController
        Vc.id = idTextField.text!
      //  present(Vc,animated: true)
        self.navigationController?.pushViewController(Vc, animated: true)
        
    }

}




