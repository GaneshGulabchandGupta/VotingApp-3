//
//  AdminLogInVC.swift
//  VotingApp
//
//  Created by Ganesh on 26/07/24.
//
import UIKit

class AdminLogInVC: UIViewController {
    
    @IBOutlet weak var AdminPassword: UITextField!
    @IBOutlet weak var AdminName: UITextField!
   
    let predefinedUsername = "ganesh"
    let predefinedPassword = "123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        clearTextFields()
    }
    
    @IBAction func AdminLoginbtn(_ sender: Any) {
     
        let adminUsername = AdminName.text
        let adminPassword = AdminPassword.text
        
  
        clearTextFields()
        
    
        guard let adminUsername = adminUsername, !adminUsername.isEmpty,
              let adminPassword = adminPassword, !adminPassword.isEmpty else {
       
            showAlert(message: "Please enter both admin username and admin password.")
            return
        }
        
     
        if validateCredentials(adminUsername: adminUsername, adminPassword: adminPassword) {
        
            saveCredentials(adminUsername: adminUsername, adminPassword: adminPassword)
      
            let vc = storyboard?.instantiateViewController(withIdentifier: "AdminVC") as! AdminVC
            navigationController?.pushViewController(vc, animated: true)
        } else {
          
            showAlert(message: "Invalid admin username or password.")
        }
    }
    
  
    func saveCredentials(adminUsername: String, adminPassword: String) {
        UserDefaults.standard.set(adminUsername, forKey: "adminUsername")
        UserDefaults.standard.set(adminPassword, forKey: "adminPassword")
        UserDefaults.standard.synchronize()
    }
    
  
    func loadCredentials() {
        if let adminUsername = UserDefaults.standard.string(forKey: "adminUsername"),
           let adminPassword = UserDefaults.standard.string(forKey: "adminPassword") {
            AdminName.text = adminUsername
            AdminPassword.text = adminPassword
        }
    }
    
   
    func validateCredentials(adminUsername: String, adminPassword: String) -> Bool {
        return adminUsername == predefinedUsername && adminPassword == predefinedPassword
    }
    
   
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Sorry!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func clearTextFields() {
        AdminName.text = ""
        AdminPassword.text = ""
    }
}
