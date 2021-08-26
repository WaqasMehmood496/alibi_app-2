

import UIKit
import iOSDropDown
import Firebase
import FirebaseStorage
import FirebaseAuth

class EventDetail: UIViewController,refreshDesignProtocal {
    
    @IBOutlet weak var activityIndicator_Outlet: UIActivityIndicatorView!
    @IBOutlet weak var Switch_outlet: UISwitch!
    @IBOutlet weak var dropDown : DropDown!
    @IBOutlet weak var date_txt: UITextField!
    @IBOutlet weak var dropdown1: DropDown!
    @IBOutlet weak var dropdown2: DropDown!
    @IBOutlet weak var M_oppointment_textfield: UITextField!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var sharewith_btn_outlet: UIButton!
    @IBOutlet weak var reminder_btn_outlet: UIButton!
    @IBOutlet weak var uniform_btn_outlet: UIButton!
    var Fir_User_Name = [String]()
    var sharewith:String? = " "
    var reminder:String? = " "
    var uniform:String? = " "
    var ref = DatabaseReference.init()
    var button_title:String? = "Private"
    var getstrLocation:String? = ""
    var window: UIWindow?
    func changeRootView(identifier:String) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifier)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
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
    @IBAction func switch_action(_ sender: UISwitch) {
        if Switch_outlet.isOn{
            button_title = "Public"
        }
        else{
            button_title = "Private"
        }
    }
    @IBAction func CaenderBtnAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ToDateVC", sender: nil)
    }
    
   
    @IBAction func sharewith_btn_action(_ sender: UIButton) {
        
    }
    @IBAction func reminder_btn_action(_ sender: UIButton) {
    }
    @IBAction func uniform_btn_action(_ sender: UIButton) {
        
    }
    deinit {
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ToDateVC") {
            if let nextViewController = segue.destination as? Calender {
                nextViewController.delegate = self
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(getstrLocation!)
        EventDetail1 = true
        EventDetail2 = false
        self.ref = Database.database().reference()
        getALLFIRData()
        dropdown()
        shadow()
        
    }
    @IBAction func save_action(_ sender: UIButton) {
        
        save()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    func getALLFIRData(){
        self.ref.child("users").queryOrderedByKey().observe(.value) { (snapshot) in

            if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapShot{
                    if let mainDict = snap.value as? [String: AnyObject]{
                        let getemail = mainDict["email"] as? String
                        let getname = mainDict["name"] as? String
                        let getpassword = mainDict["password"] as? String
                        self.Fir_User_Name.append(getname!)
                        
                    }
                }
            }
        }
    }
    func save(){
        if LocationArray.isEmpty{
            LocationArray.append("nil")
        }
        if google_signin == true{
            let dict  = ["Event Name": self.M_oppointment_textfield.text!,"sharewith": self.sharewith!, "reminder": self.reminder!,"uniform": self.uniform!,"date":SelectedDate[0],"button_title":self.button_title!,"UserId": NumbersArray[2],"EventLat":Event_Latitude[0],"EventLong":Event_Longitude[0]] as [String : Any]
            // ,"Location":LocationArray[0]
            print(dict)
            self.ref.child("EventDetail").child(NumbersArray[2]).setValue(dict)
        }
        else if(apple_signin == true){
            let dict  = ["Event Name": self.M_oppointment_textfield.text!,"sharewith": self.sharewith!, "reminder": self.reminder!,"uniform": self.uniform!,"date":SelectedDate[0],"button_title":self.button_title!,"UserId": APPLEUSERID[0],"EventLat":Event_Latitude[0],"EventLong":Event_Longitude[0]] as [String : Any]
            
            // ,"Location":LocationArray[0]
            self.ref.child("EventDetail").child(APPLEUSERID[0]).setValue(dict)
        }
        else{
            Auth.auth().addStateDidChangeListener() { auth, user in
                    if user != nil {
                        let dict  = ["Event Name":self.M_oppointment_textfield.text!,"sharewith": self.sharewith!, "reminder": self.reminder!,"uniform": self.uniform!,"date":SelectedDate[0],"button_title":self.button_title!,"UserId": user?.uid,"EventLat":Event_Latitude[0],"EventLong":Event_Longitude[0]] as [String : Any]
                        // ,"Location":LocationArray[0]
                        self.ref.child("EventDetail").child(user!.uid).setValue(dict)
                    }
                    else{
                        print("error")
                    }
                }
        }
        
       
        
    }
    func dropdown(){
        var sequenceArray = [Int]()
        print(self.Fir_User_Name)
        //dropDown.optionArray = ["Lt.Keesler", "Lt.Keesler1", "Lt.Keesler2"]
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dropDown.optionArray = self.Fir_User_Name
            if self.Fir_User_Name.isEmpty{
                self.activityIndicator_Outlet.startAnimating()
            }
            else{
                self.activityIndicator_Outlet.stopAnimating()
                self.activityIndicator_Outlet.hidesWhenStopped = true
            }
            for i in 0...self.Fir_User_Name.count{
                sequenceArray.append(i)
            }
            
            self.dropDown.optionIds = sequenceArray
            self.dropDown.didSelect{(selectedText , index ,id) in
                self.dropDown.text = "Selected String: \(selectedText) \n index: \(index)"
                self.sharewith = selectedText
                
            }
        }
       
        
        
        dropdown1.optionArray = ["30 mint before", "10 mint after", "60 mint Later"]
        dropdown1.optionIds = [1,23,54,22]
        dropdown1.didSelect{(selectedText , index ,id) in
            self.dropdown1.text = "Selected String: \(selectedText) \n index: \(index)"
            self.reminder = selectedText
        }
        
        
        dropdown2.optionArray = ["Civilian Attire", "Civilian Attire2", "Civilian Attire3"]
        dropdown2.optionIds = [1,23,54,22]
        dropdown2.didSelect{(selectedText , index ,id) in
            self.dropdown2.text = "Selected String: \(selectedText) \n index: \(index)"
            self.uniform = selectedText
        }
    }
    func shadow(){
        view1.layer.shadowRadius = 0.03
        view1.layer.shadowOpacity = 0.03
        view1.layer.shadowOffset = CGSize(width: 1, height: 20)
        view1.layer.masksToBounds = false
        
        view2.layer.shadowRadius = 0.03
        view2.layer.shadowOpacity = 0.03
        view2.layer.shadowOffset = CGSize(width: 1, height: 20)
        view2.layer.masksToBounds = false
        
        view3.layer.shadowRadius = 0.03
        view3.layer.shadowOpacity = 0.03
        view3.layer.shadowOffset = CGSize(width: 1, height: 20)
        view3.layer.masksToBounds = false
        
        view4.layer.shadowRadius = 0.03
        view4.layer.shadowOpacity = 0.03
        view4.layer.shadowOffset = CGSize(width: 1, height: 20)
        view4.layer.masksToBounds = false
        
        view5.layer.shadowRadius = 0.03
        view5.layer.shadowOpacity = 0.03
        view5.layer.shadowOffset = CGSize(width: 1, height: 20)
        view5.layer.masksToBounds = false
    }
}
extension EventDetail{
    func refreshData(date:String) {
        date_txt.text! = date
    }
}
