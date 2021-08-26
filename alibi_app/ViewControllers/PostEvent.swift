

import UIKit

class PostEvent: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var arr1 = ["42 min","44 min","63 min","88 min","Appointment"]
    var arr2 = ["Here","There","Here","Here","Late"]
    var arr3 = ["SSGT Fox,D1234567890","SSGT Fox,D1234567890","SSGT Fox,D1234567890","SSGT Fox,D1234567890","SSGT Fox,D1234567890"]
    var arrimage = [#imageLiteral(resourceName: "location"),#imageLiteral(resourceName: "location"),#imageLiteral(resourceName: "location"),#imageLiteral(resourceName: "location"),#imageLiteral(resourceName: "location")]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.rowHeight = 60
    }

}
extension PostEvent:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.imageview.image  =  arrimage[indexPath.row]
        cell.name1.text  =  arr2[indexPath.row]
        cell.detail1.text  =  arr3[indexPath.row]
        cell.timelbl.text = arr1[indexPath.row]
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    
    
}
