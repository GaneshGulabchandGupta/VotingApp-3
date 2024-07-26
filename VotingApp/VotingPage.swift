
import UIKit

class VotingPage: UIViewController {

    var Canlist = ["CANDIDATE 1", "CANDIDATE 2", "CANDIDATE 3", "CANDIDATE 4"]
    var selectedIndexPath: IndexPath?
    
    @IBOutlet weak var Tablev: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tablev.reloadData()
    }
    
    @IBAction func logoutbtn(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Do you want to logout?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Yes", style: .default) { _ in
            UserDefaults.standard.removeObject(forKey: "username")
            UserDefaults.standard.removeObject(forKey: "password")
            UserDefaults.standard.removeObject(forKey: "hasVoted")
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        
        let cancel = UIAlertAction(title: "No", style: .destructive) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @IBAction func AdminBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AdminLogInVC") as! AdminLogInVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleVote(for candidate: String) {
        if UserDefaults.standard.bool(forKey: "hasVoted") {
            showAlert(title: "Sorry!", message: "You have already voted.")
            return
        }
        
        let voteSuccessful = saveVote(for: candidate)
        if voteSuccessful {
            UserDefaults.standard.set(true, forKey: "hasVoted")
            showAlert(title: "Success", message: "Coongrates! Your vote has been successfully .")
        } else {
            showAlert(title: "Failure", message: " Please try again.")
        }
    }
    
    func saveVote(for candidate: String) -> Bool {
        var candidates: [Candidate] = loadCandidates()
        
        if let index = candidates.firstIndex(where: { $0.name == candidate }) {
            candidates[index].votes += 1
        } else {
            let newCandidate = Candidate(name: candidate, votes: 1)
            candidates.append(newCandidate)
        }
        
        if let data = try? JSONEncoder().encode(candidates) {
            UserDefaults.standard.set(data, forKey: "candidates")
            return true
        }
        
        return false
    }
    
    func loadCandidates() -> [Candidate] {
        if let data = UserDefaults.standard.data(forKey: "candidates"),
           let savedCandidates = try? JSONDecoder().decode([Candidate].self, from: data) {
            return savedCandidates
        }
        return []
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension VotingPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Canlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VoteCTVC
        cell.textLabel?.text = Canlist[indexPath.row]
        cell.selectionStyle = .none
        
        if indexPath == selectedIndexPath {
            cell.isCheck = true
            cell.VoteImage.image = UIImage(named: "check")
        } else {
            cell.isCheck = false
            cell.VoteImage.image = UIImage(named: "uncheck")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UserDefaults.standard.bool(forKey: "hasVoted") {
            showAlert(title: "Error", message: "You have already voted.")
            return
        }
        
        if let previousIndexPath = selectedIndexPath, previousIndexPath != indexPath {
            let previousCell = tableView.cellForRow(at: previousIndexPath) as? VoteCTVC
            previousCell?.isCheck = false
            previousCell?.VoteImage.image = UIImage(named: "uncheck")
        }
        
        selectedIndexPath = indexPath
        let selectedCandidate = Canlist[indexPath.row]
        print("Selected candidate: \(selectedCandidate)")
        
        handleVote(for: selectedCandidate)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let selectedIndexPath = selectedIndexPath, selectedIndexPath == indexPath {
            let previousCell = tableView.cellForRow(at: selectedIndexPath) as? VoteCTVC
            previousCell?.isCheck = false
            previousCell?.VoteImage.image = UIImage(named: "uncheck")
        }
    }
}
