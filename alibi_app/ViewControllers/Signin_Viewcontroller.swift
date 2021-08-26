

import UIKit
import Firebase
import FirebaseStorage
import MessageUI
import AuthenticationServices
import GoogleSignIn
import FirebaseAuth

@available(iOS 13.0, *)
class Signin_Viewcontroller: UIViewController, ASAuthorizationControllerDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    
    @IBOutlet weak var apple_signin_outlet: ASAuthorizationAppleIDButton!
    @IBOutlet weak var email_textfield: UITextField!
    @IBOutlet weak var password_textfield: UITextField!

    // firebase data
    let shared = FirebaseCordinator.instance
    var arrData = [ChatModel]()
    var email = [String]()
    var ref = DatabaseReference.init()
    var email1 = [String]()
    var name = [String]()
    var password = [String]()
    
    // google sign in work
    
    @IBAction func google_signin_action(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self as GIDSignInDelegate
        GIDSignIn.sharedInstance()?.signIn()
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        
        if let error = error {
              print("We have error sign in user == \(error.localizedDescription)")
            } else {
                if user != nil {
                    print(user.profile.email!)
                    print(user.profile.name!)
                    firebase_signin = false
                    google_signin = true
                    apple_signin = false
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
  
    func changeRootView(identifier:String) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifier)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    @IBAction func apple_btn_action(_ sender: UIButton) {
        setUpSignInAppleButton()
    }
    @IBAction func signin_action(_ sender: UIButton) {
        
        shared.login(email: email_textfield.text!, password: password_textfield.text!) { (result) in
            switch result{
            case.success(let user): print(user?.uid)
            case.failure(let error): print(error.localizedDescription )
            }
        }
        getALLFIRData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        GIDSignIn.sharedInstance().presentingViewController = self
        
    }
    
    
    func setUpSignInAppleButton() {
      apple_signin_outlet = ASAuthorizationAppleIDButton()
        handleAppleIdRequest()
    }
    @objc func handleAppleIdRequest() {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
        print(request)
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
    func getALLFIRData(){
        self.ref.child("users").queryOrderedByKey().observe(.value) { (snapshot) in
            
            self.email.removeAll()
            if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapShot{
                    if let mainDict = snap.value as? [String: AnyObject]{
                        let getemail = mainDict["email"] as? String
                        let getname = mainDict["name"] as? String
                        let getpassword = mainDict["password"] as? String
                        if ((getemail == self.email_textfield.text!) && (getpassword == self.password_textfield.text!)){
                            self.performSegue(withIdentifier: "GO1", sender: nil)
                            firebase_signin = true
                            google_signin = false
                            apple_signin = false
                            NumbersArray.removeAll()
                            NumbersArray.append(getname!)
                            NumbersArray.append(getemail!)
                            
                        }
                    }
                }
            }
        }
    }
}
