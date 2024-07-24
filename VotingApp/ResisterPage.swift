
import UIKit

class ResisterPage: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        
        if isUsernameUnique(username: username) {
           
            UserDefaults.standard.set(username, forKey: "username")
            UserDefaults.standard.set(password, forKey: "password")
            
            let alert = UIAlertController(title: "Success", message: "Registration successful!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Username already taken. Please choose a different username.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func isUsernameUnique(username: String) -> Bool {
        let savedUsername = UserDefaults.standard.string(forKey: "username")
        return savedUsername != username
    }

@IBAction func loginBtnPressed(_ sender: Any) {
        guard let username = usernameTextField.text, !username.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please enter a username.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        let savedUsername = UserDefaults.standard.string(forKey: "username")
        if savedUsername == username {
            let alert = UIAlertController(title: "Error", message: "Username already taken. Please choose a different username.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
            dismiss(animated: true)
        }
    }
}
