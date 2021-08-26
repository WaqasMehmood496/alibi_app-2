
import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    
    
    
    // rosters outlets
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var detaillbl: UILabel!
    @IBOutlet weak var PublicBtn: UIButton!
    
    
    // currentEvent outlets
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var detail1: UILabel!
    
    // PostEvent outlets
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var imgpost: UIImageView!
    @IBOutlet weak var namepost: UILabel!
    @IBOutlet weak var detailpost: UILabel!
    
    // postEventWork
    @IBOutlet weak var pwork_imageview: UIImageView!
    @IBOutlet weak var pwork_name: UILabel!
    @IBOutlet weak var pwork_detail: UILabel!
    @IBOutlet weak var pwork_hour: UILabel!
    
    
    // CurrentEvent1 Outlets
    @IBOutlet weak var img23: UIImageView!
    @IBOutlet weak var lbl23: UILabel!
    @IBOutlet weak var detallbl23: UILabel!
    
    // Active Event outlet
    @IBOutlet weak var M_oppointment_label: UILabel!
    @IBOutlet weak var public_btn: UIButton!
    @IBOutlet weak var time_label: UILabel!
    @IBOutlet weak var event_detail: UILabel!
    
    // Current Event Medicle
    @IBOutlet weak var EventNAme: UILabel!
    @IBOutlet weak var EventDaTe: UILabel!
    @IBOutlet weak var EventDeTAIL: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


