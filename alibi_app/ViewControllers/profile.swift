

import UIKit
import Firebase
import FirebaseStorage
import MessageUI
import AuthenticationServices
import GoogleSignIn
import FirebaseAuth

class profile: UIViewController {
    var ref = DatabaseReference.init()
    var email1 = [String]()
    var getname:String!
    var getemail:String!
    var appleuserid:String!
    var userid:String!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    
    var window: UIWindow?
    func changeRootView(identifier:String) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifier)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    @IBAction func BackToMenu_action(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Auth.auth().addStateDidChangeListener() { auth, user in
                if user != nil {
                    self.userid = user?.uid
                         print(self.userid)
                }
                else{
                    print("not to sure")
                }
            }
        
        
        
        self.ref = Database.database().reference()
        if (google_signin == true){
            name.text! = NumbersArray[0]
            email.text! = NumbersArray[1]
        }
        else if(firebase_signin == true){
            getFir()
        }
        else{
            print(APPLEUSERID)
            appleuserid = APPLEUSERID[0]
            
            getALLFIRData()
        }
       
        
       
        
    }
    func getALLFIRData(){
        
        self.ref.child("users").queryOrderedByKey().observe(.value) { (snapshot) in
            self.email1.removeAll()
            if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapShot{
                    if let mainDict = snap.value as? [String: AnyObject]{
                        let userid = mainDict["userid"] as? String
                        let email1 = mainDict["email"] as? String
                        let name1 = mainDict["name"] as? String
                        
                        if ((userid == self.appleuserid!)){
                            self.email.text! = email1!
                            self.name.text! = name1!
                            
                        }
                    }
                }
            }
        }
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
    
    func getFir(){
        
        self.ref.child("users").queryOrderedByKey().observe(.value) { (snapshot) in
            self.email1.removeAll()
            if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapShot{
                    if let mainDict = snap.value as? [String: AnyObject]{
                        let userid = mainDict["UserID"] as? String
                        let email1 = mainDict["email"] as? String
                        let name1 = mainDict["name"] as? String
                        
                        if ((userid == self.userid)){
                            print("Come In TO")
                            self.email.text! = email1!
                            self.name.text! = name1!
                            
                        }
                    }
                }
            }
        }
    }
    
    
}
