import UIKit
import CoreLocation
import GoogleMaps
import MapKit
import Firebase
import FirebaseStorage
class ActiveEvents: UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate{
    // tableview outlet
    var arr1 = ["Medicle Appoinment","Medicle Appoinment","Medicle Appoinment"]
    var arr2 = ["in 2 days","in 2 days","in 2 days"]
    var arr3 = ["Trippler Army Medicle","Trippler Army Medicle","Trippler Army Medicle"]
    var btnTitile:[String] = ["Private","Public","Private","Public","Private","Public","Private","Public"]
    var pri_btnColor:[UIColor] = [#colorLiteral(red: 1, green: 0.9294117647, blue: 0.9215686275, alpha: 1)]
    var pri_tittleColor:[UIColor] = [#colorLiteral(red: 0.968627451, green: 0.3098039216, blue: 0.231372549, alpha: 1)]
    var pub_btnColor:[UIColor] = [#colorLiteral(red: 0.9098039216, green: 0.9803921569, blue: 0.9529411765, alpha: 0.7)]
    var pub_tittleColor:[UIColor] = [#colorLiteral(red: 0.2078431373, green: 0.8196078431, blue: 0.5294117647, alpha: 0.7)]
    var ref = DatabaseReference.init()
    
    
    
    
    
    @IBOutlet weak var tableview: UITableView!
    let manager = CLLocationManager()
    @IBOutlet weak var S_mapVIew: GMSMapView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    
    var email = [String]()
    var arrData = [ChatModel]()
    var EventName = [String]()
    var GetDate = [String]()
    var GetReminder = [String]()
    var GetSharewith = [String]()
    var GetUniform = [String]()
    var GetButtonTitle = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.rowHeight = 100
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        S_mapVIew.addSubview(view1)
        S_mapVIew.addSubview(view2)
        S_mapVIew.addSubview(view3)
        S_mapVIew.addSubview(view4)
        S_mapVIew.addSubview(view5)
        S_mapVIew.addSubview(view6)
        S_mapVIew.addSubview(view7)
        self.ref = Database.database().reference()
        getALLFIRData()
        tableview.reloadData()
        
    }
    @IBAction func back_btn_action(_ sender: UIButton) {
        self.dismiss(animated:true, completion: nil)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.first else {
            return
        }
        self.S_mapVIew.camera = GMSCameraPosition(target: location.coordinate, zoom: 14.0, bearing: 0, viewingAngle: 0)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
          return
        }
        manager.startUpdatingLocation()
        S_mapVIew.isMyLocationEnabled = true
      }
}
extension ActiveEvents{
    func getALLFIRData(){
        self.ref.child("EventDetail").queryOrderedByKey().observe(.value) { [self] (snapshot) in
            
            self.email.removeAll()
            if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapShot{
                    if let mainDict = snap.value as? [String: AnyObject]{
                        let buttonTitile = mainDict["button_title"] as? String
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
                    tableview.reloadData()
                }
            }
        }
    }
}
extension ActiveEvents:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.GetDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(self.GetDate)
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.M_oppointment_label.text  = self.EventName[indexPath.row]
        cell.time_label.text  =  self.GetDate[indexPath.row]
        cell.event_detail.text = self.GetReminder[indexPath.row]
        
       
        
        cell.public_btn.setTitle(self.GetButtonTitle[indexPath.row], for: .normal)
        cell.public_btn.addTarget(self, action: #selector(publicBtnAction), for: .touchUpInside)
        cell.public_btn.tag = indexPath.row

        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView

        
        if GetButtonTitle[indexPath.row] == "Public"{
            
            
            cell.public_btn.setTitleColor(UIColor.init(red: 53/255, green: 209/255, blue: 135/255, alpha: 1), for: .normal)
            cell.public_btn.backgroundColor = UIColor.init(named: "green")
            }
            else{
                cell.public_btn.setTitleColor(UIColor.init(red: 247/255, green: 79/255, blue: 59/255, alpha: 1), for: .normal)
                cell.public_btn.backgroundColor = UIColor.init(named: "Red")
            }

        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "product", sender: nil)
        
        
    }
    // PUBLIC BUTTON ACTION
    @objc func publicBtnAction(sender: UIButton){
        
        let str = sender.currentTitle
        var context = IndexPath(row: sender.tag, section: 0)
        let rowindex = context[1]
        if str! == "Public"{
            self.performSegue(withIdentifier: "PUBLIC", sender: nil)
        }
        else if str! == "Private"{
            self.performSegue(withIdentifier: "PRIVATE", sender: nil)
        }
    }
    
    
    
}


