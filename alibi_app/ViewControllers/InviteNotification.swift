
import UIKit
import GoogleSignIn
import FirebaseAuth
import Firebase
class InviteNotification: UIViewController {
    @IBOutlet weak var eventName_lbl: UILabel!
    @IBOutlet weak var name_lbl2: UILabel!
    @IBOutlet weak var name_lbl: UILabel!
    @IBOutlet weak var geo_label: UILabel!
    @IBOutlet weak var main_view: UIView!
    var ShareWith = [String]()
    var UserId = [String]()
    var name = [String]()
    var find_name:String!
    var firbase:Bool = false
    var google:Bool = false
    var apple:Bool = false
    var ref = DatabaseReference.init()
    var window: UIWindow?
    func changeRootView(identifier:String) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifier)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    @IBAction func Accept_invitation(_ sender: UIButton) {
    }
    @IBAction func Decline_Invitation(_ sender: UIButton) {
    }
    @IBAction func back_btn_action(_ sender: UIButton) {
        //self.dismiss(animated: true, completion: nil)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()

        geo_label.layer.shadowRadius = 1.0
        geo_label.layer.shadowOpacity = 1.0
        geo_label.layer.shadowOffset = CGSize(width: 1, height: 0.5)
        geo_label.layer.masksToBounds = false
        
        getEventDetailData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.getUSerData()
        }
        roundCorner()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    func roundCorner()
    {
        main_view.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 30)
    }
    func getEventDetailData(){
        self.ref.child("EventDetail").queryOrderedByKey().observe(.value) { (snapshot) in
            
            if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapShot{
                    if let mainDict = snap.value as? [String: AnyObject]{
                        let share = mainDict["sharewith"] as? String
                        //
                        let EventName = mainDict["Event Name"] as? String
                        let userid = mainDict["UserId"] as? String
                        let EventLocation_lat = mainDict["EventLat"] as? Double
                        let EventLocation_long = mainDict["EventLong"] as? Double
                        self.ShareWith.append(share!)
                       // print(self.ShareWith)
                        
                        if self.google == true{
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                if share == self.find_name{
                                    self.name.removeAll()
                                    self.name.append(userid!)
                                    print(userid!)
                                    Event_Location.removeAll()
                                    Event_Location.append(EventLocation_lat!)
                                    Event_Location.append(EventLocation_long!)
                                
                                    self.getgoogleorfirebase_data(userid: userid!, EventName: EventName!)
                                }
                            }
                            
//                            for i in self.ShareWith{
//                                if i == self.find_name{
//                                  //  self.Event_Location.append(EventLocation!)
//                                }
//                            }
//                            self.name.removeAll()
//                            self.name.append(userid!)
//                            self.getgoogleorfirebase_data(userid: userid!, EventName: EventName!)
                        }
                        else if self.apple == true{
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                if share == self.find_name{
                                    self.name.removeAll()
                                    self.name.append(userid!)
                                    print(userid!)
                                    Event_Location.removeAll()
                                    Event_Location.append(EventLocation_lat!)
                                    Event_Location.append(EventLocation_long!)
                                    self.getgoogleorfirebase_data(userid: userid!, EventName: EventName!)
                                }
                            }
                            
//                            for i in self.ShareWith{
//                                if i == self.find_name{
//                                 //   self.Event_Location.append(EventLocation!)
//                                }
//                            }
//                            self.name.removeAll()
//                            self.name.append(userid!)
//                            self.getgoogleorfirebase_data(userid: userid!, EventName: EventName!)
                        }
                        else if self.firbase == true{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                if share == self.find_name{
                                    self.name.removeAll()
                                    self.name.append(userid!)
                                    print(userid!)
                                    Event_Location.removeAll()
                                    Event_Location.append(EventLocation_lat!)
                                    Event_Location.append(EventLocation_long!)
                                    self.getgoogleorfirebase_data(userid: userid!, EventName: EventName!)
                                }
                            }
                           
                        }
                    }

                }
            }
        }
    }
    
    func getUSerData(){
        
        if google_signin == true {
            self.ref.child("users").queryOrderedByKey().observe(.value) { (snapshot) in
                
                if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                    for snap in snapShot{
                        if let mainDict = snap.value as? [String: AnyObject]{
                            let getemail = mainDict["email"] as? String
                            let getname = mainDict["name"] as? String
                            let getpassword = mainDict["password"] as? String
                            let getuser_id = mainDict["UserID"] as? String
                            
                            if ((getuser_id == NumbersArray[2])){
                                for i in self.ShareWith{
                                    if i == getname {
                                        self.google = true
                                        self.getEventDetailData()
                                        
                                    }
                                }}}}}}
        }
        else if apple_signin == true{
            self.ref.child("users").queryOrderedByKey().observe(.value) { (snapshot) in
                
                if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                    for snap in snapShot{
                        if let mainDict = snap.value as? [String: AnyObject]{
                            let getemail = mainDict["email"] as? String
                            let getname = mainDict["name"] as? String
                            let getuser_id = mainDict["userid"] as? String
                            print(getuser_id)
                            if ((getuser_id == APPLEUSERID[0])){
                                for i in self.ShareWith{
                                    if i == getname {
                                        self.apple = true
                                        self.getEventDetailData()
                                        
                                    }
                                }}}}}}
        }
        else{
            
            Auth.auth().addStateDidChangeListener() { auth, user in
                if user != nil {
                    self.ref.child("users").queryOrderedByKey().observe(.value) { (snapshot) in
                        
                        if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                            for snap in snapShot{
                                if let mainDict = snap.value as? [String: AnyObject]{
                                    let getemail = mainDict["email"] as? String
                                    let getname = mainDict["name"] as? String
                                    let getpassword = mainDict["password"] as? String
                                    let getuser_id = mainDict["UserID"] as? String
                                    
                                    if ((getuser_id == user?.uid)){
                                        print("Name Match To happy")
                                        print(self.ShareWith)
                               
                                        for i in self.ShareWith{
                                            
                                            if i == getname {
                                                
                                                self.firbase = true
                                                self.find_name = i
                                                print(self.find_name)
                                                self.getEventDetailData()
                                                
                                            }
                                        }
                                        }}}}}}
                else{
                    print("stay")
                }
            }
        }
      
        
    }
    func getgoogleorfirebase_data(userid:String, EventName:String){
        self.ref.child("users").queryOrderedByKey().observe(.value) { (snapshot) in
            
            if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapShot{
                    if let mainDict = snap.value as? [String: AnyObject]{
                        let getemail = mainDict["email"] as? String
                        let getname = mainDict["name"] as? String
                        let getpassword = mainDict["password"] as? String
                        let getuser_id = mainDict["UserID"] as? String
                        let getUser_Location = mainDict["Location"] as? String
                        if ((getuser_id == userid)){
                            print("Label")
                            self.eventName_lbl.text = EventName
                            self.name_lbl.text = getname
                            self.name_lbl2.text = getname! + " " + "has invited you to"
                           }
                        
                    }}}}
    }

}

extension UIView{
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
