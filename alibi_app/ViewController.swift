
import UIKit
import Firebase
import FirebaseStorage
import MessageUI
import AuthenticationServices
import GoogleSignIn
import FirebaseAuth

@available(iOS 13.0, *)
class ViewController: UIViewController, ASAuthorizationControllerDelegate, GIDSignInDelegate  {
    
    @IBOutlet weak var signin_outlet: ASAuthorizationAppleIDButton!
    @IBOutlet weak var name_textfield: UITextField!
    @IBOutlet weak var email_txt: UITextField!
    @IBOutlet weak var password_textfield: UITextField!
    
    
    var UserId:String? = ""
    let shared = FirebaseCordinator.instance
    var window: UIWindow?
    // Firebase data
    var ref = DatabaseReference.init()
    
    @IBAction func google_signin_action(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self as GIDSignInDelegate
        GIDSignIn.sharedInstance()?.signIn()
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
              print("We have error sign in user == \(error.localizedDescription)")
            } else {
                print("hell")
                if user != nil {
                    print("hello")
                    print(user.profile.email!)
                    print(user.profile.name!)
                    firebase_signin = false
                    apple_signin = false
                    google_signin = true
                    NumbersArray.removeAll()
                    NumbersArray.append(user.profile.name!)
                    NumbersArray.append(user.profile.email!)
                    NumbersArray.append(user.userID)
                    let dict  = ["UserID": user.userID,"email": user.profile.email!, "name": user.profile.name!]
                    self.ref.child("users").child(user.userID).setValue(dict)
                    changeRootView(identifier: "homepage")
                    
              }
            }
    }
    @IBAction func signin_action(_ sender: UIButton) {
        setUpSignInAppleButton()
    }
    @IBAction func signup_action(_ sender: UIButton) {
        
        shared.register(email: email_txt.text!, password: password_textfield.text!) { (result) in
            switch result{
            case.success(let user):
              //  print(user!.uid)
                //self.UserId?.append(user!.uid)
                self.UserId = user?.uid
                self.saveFIRData()
                self.appDataInGlobalArray()
              print("abc")
            case.failure(let error): print(error.localizedDescription )
            }
        }
        
        
        
        
        
       
    }
    func changeRootView(identifier:String) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifier)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    func setUpSignInAppleButton() {
        signin_outlet = ASAuthorizationAppleIDButton()
        handleAppleIdRequest()
    }
    @objc func handleAppleIdRequest() {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    request.requestedScopes = [.fullName, .email]
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.performRequests()
    }

    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let userCredential = authorization.credential as?  ASAuthorizationAppleIDCredential else{ return}
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
        let userIdentifier = appleIDCredential.user
                let givenName:String! = appleIDCredential.fullName?.givenName
                let familyName:String! = appleIDCredential.fullName?.familyName
                let userid = appleIDCredential.user
            if(givenName == nil && familyName == nil){
                print("nil")
                print(userid)
                
                firebase_signin = false
                google_signin = false
                apple_signin = true
                APPLEUSERID.removeAll()
                APPLEUSERID.append(userid)
                changeRootView(identifier: "homepage")
            }
            else{
                
                let fullname = givenName! + familyName!
                let email = appleIDCredential.email
                
                let str = userid
                let UserAppleID = str.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                
                
                let dict  = ["UserID":UserAppleID,"email": email!, "name": givenName]
                self.ref.child("users").child(UserAppleID).setValue(dict)
                firebase_signin = false
                google_signin = false
                apple_signin = true
                APPLEUSERID.removeAll()
                APPLEUSERID.append(userid)
                changeRootView(identifier: "homepage")
            }
        }
    }
    
    
    
    func saveFIRData(){
        if (email_txt.text! == "" && name_textfield.text! == "" && password_textfield.text! == ""){
            let uialert = UIAlertController(title: "Error", message: "All Textfields are Required"
                , preferredStyle: UIAlertController.Style.alert)
                uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                self.present(uialert, animated: true, completion: nil)
        }
        else if(email_txt.text! == ""){
            let uialert = UIAlertController(title: "Error", message: "Email is Required"
                , preferredStyle: UIAlertController.Style.alert)
            uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(uialert, animated: true, completion: nil)
        }
        else if(name_textfield.text! == ""){
            let uialert = UIAlertController(title: "Error", message: "Name is Required"
                , preferredStyle: UIAlertController.Style.alert)
            uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(uialert, animated: true, completion: nil)
        }
        else if(password_textfield.text! == ""){
            let uialert = UIAlertController(title: "Error", message: "Password is Required"
                , preferredStyle: UIAlertController.Style.alert)
            uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(uialert, animated: true, completion: nil)
        }
        else{
            
            Auth.auth().addStateDidChangeListener() { auth, user in
                    if user != nil {
                        let dict  = ["UserID": self.UserId!,"email": self.email_txt.text!, "name": self.name_textfield.text!,"password": self.password_textfield.text!]
                       // self.ref.child("users").childByAutoId().setValue(dict)
                        self.ref.child("users").child(user!.uid).setValue(dict)
                        self.performSegue(withIdentifier: "GO", sender: nil)
                        
                    }
                    else{
                        print("not to sure")
                    }
                }
            
            
           
        }
        
    }
    func appDataInGlobalArray() {
        NumbersArray.removeAll()
        NumbersArray.append(email_txt.text!)
        NumbersArray.append(name_textfield.text!)
        NumbersArray.append(password_textfield.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        //GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance().presentingViewController = self
    }

}

