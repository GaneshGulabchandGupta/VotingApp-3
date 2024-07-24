

import UIKit
import Foundation

struct Candidate: Codable {
    var name: String
    var votes: Int
}

class AdminVC: UIViewController {

    @IBOutlet weak var CandidateResult1: UILabel!
    @IBOutlet weak var CandidateResult2: UILabel!
    @IBOutlet weak var CandidateResult3: UILabel!
    @IBOutlet weak var CandidateResult4: UILabel!
    
    var selectedCandidate: String?
    var candidates: [Candidate] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCandidates()
        
        if let candidateName = selectedCandidate {
            addCandidate(name: candidateName)
        }

        updateVoteCountLabels()
    }
    
    func addCandidate(name: String) {
        if let index = candidates.firstIndex(where: { $0.name == name }) {
            candidates[index].votes += 1
        } else {
            let candidate = Candidate(name: name, votes: 1)
            candidates.append(candidate)
        }
        saveCandidates()
        updateVoteCountLabels()
    }
    
    func saveCandidates() {
        if let data = try? JSONEncoder().encode(candidates) {
            UserDefaults.standard.set(data, forKey: "candidates")
        }
    }
    
    func loadCandidates() {
        if let data = UserDefaults.standard.data(forKey: "candidates"),
           let savedCandidates = try? JSONDecoder().decode([Candidate].self, from: data) {
            candidates = savedCandidates
        }
    }

    func updateVoteCountLabels() {
        let topCandidates = candidates.sorted(by: { $0.votes > $1.votes }).prefix(4)
        
        let candidateResults = [CandidateResult1, CandidateResult2, CandidateResult3, CandidateResult4]
        
        for (index, label) in candidateResults.enumerated() {
            if index < topCandidates.count {
                label?.text = "\(topCandidates[index].name): \(topCandidates[index].votes) votes"
            } else {
                label?.text = ""
            }
        }
    }
}
