
import UIKit

class PostEventWork: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var arr1 = ["6hrs 42 min","9hrs 44 min","2hrs 63 min","6hrs 88 min","Appointment"]
    var arr2 = ["Here","There","Here","Here","Late"]
    var arr3 = ["SSGT Fox,D1234567890","SSGT Fox,D1234567890","SSGT Fox,D1234567890","SSGT Fox,D1234567890","SSGT Fox,D1234567890"]
    var arrimage = [#imageLiteral(resourceName: "location"),#imageLiteral(resourceName: "location"),#imageLiteral(resourceName: "location"),#imageLiteral(resourceName: "location"),#imageLiteral(resourceName: "location")]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.rowHeight = 60
    }

}
extension PostEventWork:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.pwork_imageview.image  =  arrimage[indexPath.row]
        cell.pwork_name.text  =  arr2[indexPath.row]
        cell.pwork_detail.text  =  arr3[indexPath.row]
        cell.pwork_hour.text = arr1[indexPath.row]
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    
    
}
