import UIKit
import CoreLocation
import GoogleMaps
import MapKit
import Firebase
import FirebaseStorage

class CurrentEventMedicle: UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate {
    @IBOutlet weak var tableview: UITableView!
    let manager = CLLocationManager()
    var ref = DatabaseReference.init()
    @IBOutlet weak var S_mapView: GMSMapView!
    @IBOutlet weak var back_btn: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    var EventName = [String]()
    var GetDate = [String]()
    var GetReminder = [String]()
    var GetSharewith = [String]()
    var GetUniform = [String]()
    var GetButtonTitle = [String]()
    var status:Bool = true
    @IBOutlet weak var ScrollUpHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        S_mapView.addSubview(view1)
        S_mapView.addSubview(view2)
        S_mapView.addSubview(view3)
        S_mapView.addSubview(back_btn)
        self.ref = Database.database().reference()
        getALLFIRData()
        tableview.rowHeight = 90
    }
    @IBAction func Scroll_btn(_ sender: UIButton) {
        if status == true{
            self.ScrollUpHeightConstraint.constant = 600
            self.tableview.reloadData()
            status = false
        }
        else{
            self.ScrollUpHeightConstraint.constant = 298
            self.tableview.reloadData()
            status = true
        }
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
extension CurrentEventMedicle{
    func getALLFIRData(){
        
        self.ref.child("EventDetail").queryOrderedByKey().observe(.value) { [self] (snapshot) in
            if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapShot{
                    if let mainDict = snap.value as? [String: AnyObject]{
                        let buttonTitile = mainDict["button_title"] as? String
                        if buttonTitile == "Private"{
                            
                            let getEventName = mainDict["Event Name"] as? String
                            let getdate = mainDict["date"] as? String
                            let getreminder = mainDict["reminder"] as? String
                            let getsharewith = mainDict["sharewith"] as? String
                            let getuniform = mainDict["uniform"] as? String
                          
                            self.EventName.append(getEventName!)
                            self.GetDate.append(getdate!)
                            self.GetReminder.append(getreminder!)
                            self.GetSharewith.append(getsharewith!)
                            self.GetUniform.append(getuniform!)
                            self.GetButtonTitle.append(buttonTitile!)
                        }
                        else{
                            print("Not a private Data")
                        }
                    }
                    tableview.reloadData()
                }
            }
        }
    }
}
extension CurrentEventMedicle:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.EventName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.EventNAme.text  =  self.EventName[indexPath.row]
        cell.EventDaTe.text  =  self.GetDate[indexPath.row]
        cell.EventDeTAIL.text  =  self.GetUniform[indexPath.row]
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
    }
    
}
