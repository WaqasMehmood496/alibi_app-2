
import UIKit
import LocalAuthentication

class MainScreen: UIViewController {
    @IBOutlet weak var fingerprint_outlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func fingerprint_action(_ sender: UIButton) {
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason  = "please authorized with touch id"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics , localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else{
                        let alert = UIAlertController(title: "failed to authontication", message: "please try again", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                         self?.present(alert, animated: true)
                        // failed
                        return
                    }
                    self?.performSegue(withIdentifier: "allow", sender: nil)
                    // success
                    // show other screen
                }
                
            }
        }
        else{
            let alert = UIAlertController(title: "Unabailble", message: "you cannot use this feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
}
 
