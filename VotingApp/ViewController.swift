
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func LogInBtn(_ sender: UIButton) {
        guard let enteredUsername = emailTextField.text, !enteredUsername.isEmpty,
              let enteredPassword = passwordTextField.text, !enteredPassword.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let savedUsername = UserDefaults.standard.string(forKey: "username") ?? ""
        let savedPassword = UserDefaults.standard.string(forKey: "password") ?? ""
        
        if enteredUsername == savedUsername && enteredPassword == savedPassword {
            let vc = storyboard?.instantiateViewController(withIdentifier: "VotingPage") as! VotingPage
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Invalid username or password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResisterPage") as! ResisterPage
        navigationController?.pushViewController(vc, animated: true)
    }
}
