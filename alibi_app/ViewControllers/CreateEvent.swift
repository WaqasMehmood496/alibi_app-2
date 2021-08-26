

import UIKit
import CoreLocation
import GoogleMaps
import MapKit
import Firebase

class CreateEvent: UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate {
    var window: UIWindow?
    var time:Float!
    var status:Bool = true
    var strloc:String? = ""
    var ref = DatabaseReference.init()
    let manager = CLLocationManager()
    var userLongitude:Double?
    var userLatitude:Double?
    @IBOutlet weak var menu_btn: UIButton!
    @IBOutlet weak var notification_btn: UIButton!
    @IBOutlet weak var S_mapview: GMSMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        if Perform_Segue == false{
            changeRootView(identifier: "LoadingScreenController")
        }

        self.ref = Database.database().reference()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        //  manager.stopUpdatingLocation()
        S_mapview.addSubview(menu_btn)
        S_mapview.addSubview(notification_btn)
        
    }
    func changeRootView(identifier:String) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifier)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    @IBAction func create_event_action(_ sender: UIButton) {
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.first else {
            
            return
        }
        let Latitude = location.coordinate.latitude
        let Longitude = location.coordinate.longitude
        self.userLongitude = Longitude
        self.userLatitude = Latitude
        getAddress()
        self.S_mapview.camera = GMSCameraPosition(target: location.coordinate, zoom: 14.0, bearing: 0, viewingAngle: 0)
        if Event_Location.isEmpty{
            print("Array is Empty")
        }
        else{
            let EventLat = Event_Location[0]
            let EventLon = Event_Location[1]
            let coordinate₀ = CLLocation(latitude: userLatitude!, longitude: userLongitude!)
            let coordinate₁ = CLLocation(latitude: EventLat, longitude: EventLon)

            let distanceInMeters = coordinate₀.distance(from: coordinate₁)

            let distanceinKilometers = distanceInMeters/1000
            print(distanceinKilometers)
            self.time = Float(distanceinKilometers/50)
            let str = self.time*3600
            secondsToHoursMinutesSeconds(seconds: Double(str))
        
       
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        manager.startUpdatingLocation()
        S_mapview.isMyLocationEnabled = true
        print(Event_Location)
        }
     
    }
    func secondsToHoursMinutesSeconds (seconds : Double) -> (Double, Double, Double) {
      let (hr,  minf) = modf (seconds / 3600)
      let (min, secf) = modf (60 * minf)
        let hours:Int = Int(hr)
        let minutes:Int = Int(min)
        let sec:Int = Int(60*secf)
        print("\(hours) Hours, \(minutes) Minutes, \(sec) Seconds")
      return (hr, min, 60 * secf)
    }
    
    func getAddress() -> String {
        let address: String = ""
        let location = CLLocation(latitude: userLatitude!, longitude: userLongitude!)
        
        
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarksArray, error) in
            if (error) == nil {
                if placemarksArray!.count > 0 {
                    let placemark = placemarksArray?[0]
                    let address = "\(placemark?.subThoroughfare ?? ""), \(placemark?.thoroughfare ?? ""), \(placemark?.locality ?? ""), \(placemark?.subLocality ?? ""), \(placemark?.administrativeArea ?? ""), \(placemark?.postalCode ?? ""), \(placemark?.country ?? "")"
                    
                    let street = placemark?.thoroughfare
                    let country = placemark?.country ?? ""
                    let city = placemark?.locality ?? ""
                    if street != nil{
                        if google_signin == true{
                            self.ref.child("users").queryOrderedByKey().observe(.value) { (snapshot) in
                                if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                                    for snap in snapShot{
                                        if let mainDict = snap.value as? [String: AnyObject]{
                                            
                                            let userid = mainDict["UserID"] as? String
                                            
                                            if ( userid == NumbersArray[2]){
                                                let str1 = street! + " " + city + " " + country
                                                let dict  = ["Location":str1]
                                                self.ref.root.child("users").child(NumbersArray[2]).updateChildValues(["Location": str1])
                                                self.manager.stopUpdatingLocation()
                                            }}}}}
                        }
                        else if apple_signin == true{
                            let str = APPLEUSERID[0]
                            let UserAppleID = str.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                            self.ref.child("users").queryOrderedByKey().observe(.value) { (snapshot) in
                                if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                                    for snap in snapShot{
                                        if let mainDict = snap.value as? [String: AnyObject]{
                                            
                                            let userid = mainDict["UserID"] as? String
                                            
                                            if ( userid == UserAppleID){
                                                
                                                let str1 = street! + " " + city + " " + country
                                                let dict  = ["Location":str1]
                                                self.ref.root.child("users").child(UserAppleID).updateChildValues(["Location": str1])
                                                self.manager.stopUpdatingLocation()
                                            }}}}}
                        }
                        else{
                            Auth.auth().addStateDidChangeListener() { auth, user in
                                if user != nil {
                                    let x = user
                                    
                                    self.ref.child("users").queryOrderedByKey().observe(.value) { (snapshot) in
                                        if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                                            for snap in snapShot{
                                                if let mainDict = snap.value as? [String: AnyObject]{
                                                    
                                                    let userid = mainDict["UserID"] as? String
                                                    
                                                    
                                                    if ( userid == user?.uid){
                                                        
                                                        let str1 = street! + " " + city + " " + country
                                                        let dict  = ["Location":str1]
                                                        self.ref.root.child("users").child(user!.uid).updateChildValues(["Location": str1])
                                                        self.manager.stopUpdatingLocation()
                                                    }}}}}}
                                else{
                                    print("not to sure")
                                }}}}
                    
                }}}
        return address;
    }
}


