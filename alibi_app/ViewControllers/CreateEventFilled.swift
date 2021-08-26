import UIKit
import CoreLocation
import GoogleMaps
import MapKit

class CreateEventFilled: UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate  {
    let manager = CLLocationManager()
    @IBOutlet weak var S_mapView: GMSMapView!
    @IBOutlet weak var arrow_btn: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var location_lbl: UILabel!
    let zoomlevel:Float = 10.0
    var markerArray = [(String,UIImage,CLLocationCoordinate2D)]()
    var StrLocation = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        S_mapView.addSubview(arrow_btn)
        S_mapView.addSubview(view1)
        S_mapView.addSubview(view2)
        S_mapView.addSubview(view3)
        S_mapView.delegate = self
        
        self.markerArray = [
            ("Resturent Islamabad",#imageLiteral(resourceName: "Rectangle"),CLLocationCoordinate2D(latitude: 33.6714, longitude: 73.0181)),
            ("Meezan Bank",#imageLiteral(resourceName: "Logo"),CLLocationCoordinate2D(latitude: 33.6850, longitude: 72.9884)),
            ("G11 Markaz",#imageLiteral(resourceName: "google"),CLLocationCoordinate2D(latitude: 33.6928, longitude: 73.0146)),
            ("Savour Foods",#imageLiteral(resourceName: "Logo"),CLLocationCoordinate2D(latitude: 33.6721, longitude: 73.0183)),
            ("Brew & Chew cafe",#imageLiteral(resourceName: "Rectangle"),CLLocationCoordinate2D(latitude: 33.6692, longitude: 73.0136))
        ]
        
    }
    
    @IBAction func add_location_action(_ sender: UIButton) {
        if roster_create == true{
            self.performSegue(withIdentifier: "public", sender: nil)
        }
        else{
            self.performSegue(withIdentifier: "private", sender: nil)
        }
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.loadMarker()
    }
    func loadMarker(){
        for (index,data) in self.markerArray.enumerated(){
            let marker = GMSMarker(position: data.2)
            marker.title = data.0
            marker.map = self.S_mapView
            marker.accessibilityHint = "\(index)"
            marker.icon = #imageLiteral(resourceName: "RED")
        }
        self.S_mapView.reloadInputViews()
    }
    func getAddress(location:CLLocationCoordinate2D) -> String {
        let address: String = ""

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: location.latitude, longitude: location.longitude)) { (placemarksArray, error) in
                if (error) == nil {
                    
                    if placemarksArray!.count > 0 {
                        let placemark = placemarksArray?[0]
                        let address = "\(placemark?.subThoroughfare ?? ""), \(placemark?.thoroughfare ?? ""), \(placemark?.locality ?? ""), \(placemark?.subLocality ?? ""), \(placemark?.administrativeArea ?? ""), \(placemark?.postalCode ?? ""), \(placemark?.country ?? "")"
                        
                        let street = placemark?.thoroughfare
                        let country = placemark?.country ?? ""
                        let city = placemark?.locality ?? ""
                        let str1 = street! + " " + city + " " + country
                        if street != nil{
                            print(location.latitude)
                            print(location.longitude)
                            Event_Latitude.removeAll()
                            Event_Latitude.append(Double(location.latitude))
                            Event_Longitude.removeAll()
                            Event_Longitude.append(Double(location.longitude))
                            LocationArray.removeAll()
                            LocationArray.append(str1)
                            print(LocationArray)
                            self.location_lbl.text! = str1
                            
                        }
                    }}}
            return address;
        }
    func mapView(_ S_mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        S_mapView.selectedMarker = marker
        let camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: zoomlevel)
        let update = GMSCameraUpdate.setCamera(camera)
        S_mapView.animate(with: update)
        let address = getAddress(location: markerArray[Int(marker.accessibilityHint!) ?? 0].2)
        let name = marker.title
        
        return true
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
