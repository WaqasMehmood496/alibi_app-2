import UIKit
import CoreLocation
import GoogleMaps
import MapKit

class CreateEventEmpty: UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate  {
    let manager = CLLocationManager()
    @IBOutlet weak var S_mapView: GMSMapView!
    @IBOutlet weak var back_btn: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        S_mapView.addSubview(back_btn)
        S_mapView.addSubview(view1)
        S_mapView.addSubview(view2)
        S_mapView.addSubview(view3)
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
