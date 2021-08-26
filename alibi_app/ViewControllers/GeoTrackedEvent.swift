
import UIKit
import FirebaseAuth

class GeoTrackedEvent: UIViewController {
    var window: UIWindow?
    func changeRootView(identifier:String) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifier)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func back_btn_action(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func logout_action(_ sender: UIButton) {
        if google_signin == true || apple_signin == true{
            changeRootView(identifier: "launchscreen")
        }
        else{
            do{
               try FirebaseAuth.Auth.auth().signOut()
            }
            catch{
                print("error occurd")
            }
        }
    }
    
}
