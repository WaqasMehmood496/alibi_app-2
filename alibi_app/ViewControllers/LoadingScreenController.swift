
import UIKit

class LoadingScreenController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            Perform_Segue = true
            self.performSegue(withIdentifier: "ShoW", sender: nil)
        }
    }
    

}
