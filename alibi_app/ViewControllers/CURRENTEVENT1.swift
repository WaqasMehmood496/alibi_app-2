
import UIKit
import CoreLocation
import GoogleMaps
import MapKit
import Firebase
import FirebaseStorage
class CURRENTEVENT1: UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    var ref = DatabaseReference.init()
    @IBOutlet weak var S_mapView: GMSMapView!
    @IBOutlet weak var back_btn: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    var arr1 = ["Here!","There!"]
    var imagearr = [UIImage]()
    var btnColor:[UIColor] = [#colorLiteral(red: 0.9098039216, green: 0.9803921569, blue: 0.9529411765, alpha: 0.7),#colorLiteral(red: 0.9098039216, green: 0.9803921569, blue: 0.9529411765, alpha: 0.7),#colorLiteral(red: 1, green: 0.9294117647, blue: 0.9215686275, alpha: 1),#colorLiteral(red: 1, green: 0.9294117647, blue: 0.9215686275, alpha: 1),#colorLiteral(red: 0.9098039216, green: 0.9803921569, blue: 0.9529411765, alpha: 0.7),#colorLiteral(red: 0.9098039216, green: 0.9803921569, blue: 0.9529411765, alpha: 0.7)]
    var tittleColor:[UIColor] = [#colorLiteral(red: 0.2732034624, green: 0.608477354, blue: 0.3968070745, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),#colorLiteral(red: 0.2732034624, green: 0.608477354, blue: 0.3968070745, alpha: 1),#colorLiteral(red: 0.968627451, green: 0.3098039216, blue: 0.231372549, alpha: 1),#colorLiteral(red: 0.2732034624, green: 0.608477354, blue: 0.3968070745, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)]
    var GetUserId = [String]()
    var name = [String]()
    
    @IBOutlet var mainview: UIView!
    @IBOutlet weak var message_view: UIView!
    @IBOutlet weak var change_height_view: UIView!
    @IBOutlet weak var ScrollUpHeightConstraint: NSLayoutConstraint!
    var status:Bool = true
    @IBAction func scroll_btn(_ sender: UIButton) {
        if status == true{
            print("true")
            self.ScrollUpHeightConstraint.constant = 700
            self.tableview.reloadData()
            status = false
        }
        else{
            print("false")
            self.ScrollUpHeightConstraint.constant = 400
            self.tableview.reloadData()
            status = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        S_mapView.addSubview(back_btn)
        self.ref = Database.database().reference()
        getALLFIRData()
        tableview.rowHeight = 50
        tableview.reloadData()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.first else {
            return
        }
        self.S_mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 14.0, bearing: 0, viewingAngle: 0)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
          return
        }
        manager.startUpdatingLocation()
        S_mapView.isMyLocationEnabled = true
      }

}
extension CURRENTEVENT1{
    func getALLFIRData(){
        
        self.ref.child("users").queryOrderedByKey().observe(.value) { [self] (snapshot) in
            if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                print("Entry")
                for snap in snapShot{
                    if let mainDict = snap.value as? [String: AnyObject]{
                        let location = mainDict["Location"] as? String
                        let name = mainDict["name"] as? String
                            self.GetUserId.append(location!)
                            self.name.append(name!)
                            print(self.GetUserId)
                            print(self.name)
                        
                    }
                    let imageName = "location"
                    let image = UIImage(named: imageName)
                    
                    // iterate and add to view
                    for i in 0...name.count {
                        imagearr.append(image!)
                    }
                    tableview.reloadData()
                    
                }
            }
        }
    }
}
extension CURRENTEVENT1:UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.img23.image =  imagearr[indexPath.row]
        cell.lbl23.text  =  self.name[indexPath.row]
        cell.detallbl23.text  =  self.GetUserId[indexPath.row]
        //cell.lbl23.textColor = self.tittleColor[indexPath.row]
        cell.lbl23.tag = indexPath.row
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
   
    
}
