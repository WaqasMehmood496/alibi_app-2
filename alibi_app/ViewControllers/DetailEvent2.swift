
import UIKit
import iOSDropDown
import Firebase
import FirebaseStorage
import FirebaseAuth

class DetailEvent2: UIViewController,refreshDesignProtocal {
    
    @IBOutlet weak var switch12_outlet: UISwitch!
    @IBOutlet weak var EventName_txt: UITextField!
    @IBOutlet weak var uniform_view: UIView!
    @IBOutlet weak var reminder_view: UIView!
    @IBOutlet weak var date_time_view: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textfield_view: UIView!
    @IBOutlet weak var date_txt: UITextField!
    @IBOutlet weak var dropDown: DropDown!
    @IBOutlet weak var dropdown1: DropDown!
    @IBOutlet weak var dropdown2: DropDown!
    
    var UserId:String? = ""
    var sharewith:String? = " "
    var reminder:String? = " "
    var uniform:String? = " "
    var button_title:String? = "Private"
    var ref = DatabaseReference.init()
    var window: UIWindow?
    func changeRootView(identifier:String) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifier)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
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
    @IBAction func switch12_action(_ sender: UISwitch) {
        if switch12_outlet.isOn{
            button_title = "Public"
        }
        else{
            button_title = "Private"
        }
    }
    @IBAction func calender_btn_action(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ToCalander", sender: nil)
    }
    @IBAction func save_action(_ sender: UIButton) {
        save()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        EventDetail1 = false
        EventDetail2 = true
        self.ref = Database.database().reference()
        dropdown()
        shadow()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ToCalander") {
            if let nextViewController = segue.destination as? Calender {
                nextViewController.delegate = self
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if SelectedDate.isEmpty {
            date_txt.text! = "5/21/2021 16:30"
        }
        else{
            date_txt.text! = SelectedDate[0]
        }
    }
    func save(){
        
        Auth.auth().addStateDidChangeListener() { auth, user in
                if user != nil {
                    self.UserId = user?.uid
                    let dict  = ["UserID": self.UserId!,"Event Name":self.EventName_txt.text!,"sharewith": self.sharewith!, "reminder": self.reminder!,"uniform": self.uniform!,"date":SelectedDate[0],"button_title":self.button_title!]
                    self.ref.child("Roster").childByAutoId().setValue(dict)
                }
                else{
                    print("not to sure")
                }
            }
    }
    func dropdown(){
        dropDown.optionArray = ["Lt.Keesler", "Lt.Keesler1", "Lt.Keesler2"]
        dropDown.optionIds = [1,23,54,22]
        dropDown.didSelect{(selectedText , index ,id) in
            self.dropDown.text = "Selected String: \(selectedText) \n index: \(index)"
            self.sharewith = selectedText
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
        
        label?.layer.shadowRadius = 1.0
        label?.layer.shadowOpacity = 1.0
        label?.layer.shadowOffset = CGSize(width: 1, height: 0.5)
        label?.layer.masksToBounds = false
        
        
        textfield_view?.layer.shadowRadius = 0.03
        textfield_view?.layer.shadowOpacity = 0.03
        textfield_view?.layer.shadowOffset = CGSize(width: 1, height: 20)
        textfield_view?.layer.masksToBounds = false
        
        date_time_view?.layer.shadowRadius = 0.03
        date_time_view?.layer.shadowOpacity = 0.03
        date_time_view?.layer.shadowOffset = CGSize(width: 1, height: 20)
        date_time_view?.layer.masksToBounds = false
        
        reminder_view?.layer.shadowRadius = 0.03
        reminder_view?.layer.shadowOpacity = 0.03
        reminder_view?.layer.shadowOffset = CGSize(width: 1, height: 20)
        reminder_view?.layer.masksToBounds = false
        
        uniform_view?.layer.shadowRadius = 0.03
        uniform_view?.layer.shadowOpacity = 0.03
        uniform_view?.layer.shadowOffset = CGSize(width: 1, height: 20)
        uniform_view?.layer.masksToBounds = false
    }

}
extension DetailEvent2{
    func refreshData(date:String) {
        date_txt.text! = date
    }
}
