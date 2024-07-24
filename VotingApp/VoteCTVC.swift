
import UIKit

class VoteCTVC: UITableViewCell {
    @IBOutlet weak var VoteImage: UIImageView!
    
    @IBOutlet weak var SelectCandidate: UILabel!
    
    var isCheck = false
    override func awakeFromNib() {
        super.awakeFromNib()

     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }

}
