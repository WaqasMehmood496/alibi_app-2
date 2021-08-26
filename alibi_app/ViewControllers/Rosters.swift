
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class Rosters: UIViewController {
    var ref = DatabaseReference.init()
    @IBOutlet weak var tableview: UITableView!
    var arr1 = ["Alpha Co.","Bravo 2","Going Away","Soccer Team","PC Traning","Board Meeting"]
    var arr2 = [String]()
    var imagearr = [UIImage]()
    var btnColor:[UIColor] = []
    var tittleColor:[UIColor] = []
    var EventName = [String]()
    var ButtonTitle = [String]()
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
        
        self.ref = Database.database().reference()
        
        getALLFIRData()
        tableview.rowHeight = 100
    }
    @IBAction func back_btn_action(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func create_roster_action(_ sender: UIButton) {
        roster_create = true
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

extension Rosters{
    func getALLFIRData(){
        
        self.ref.child("Roster").queryOrderedByKey().observe(.value) { [self] (snapshot) in
            if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapShot{
                    if let mainDict = snap.value as? [String: AnyObject]{
                        let Name = mainDict["Event Name"] as? String
                        let title = mainDict["button_title"] as? String
                        self.EventName.append(Name!)
                        self.ButtonTitle.append(title!)
                        
                        if title == "Private"{
                            btnColor.append(#colorLiteral(red: 1, green: 0.9294117647, blue: 0.9215686275, alpha: 1))
                            tittleColor.append(#colorLiteral(red: 0.968627451, green: 0.3098039216, blue: 0.231372549, alpha: 1))
                        }
                        else{
                            btnColor.append(#colorLiteral(red: 0.9098039216, green: 0.9803921569, blue: 0.9529411765, alpha: 0.7))
                            tittleColor.append(#colorLiteral(red: 0.2078431373, green: 0.8196078431, blue: 0.5294117647, alpha: 0.7))
                        }
                    }
                    let imageName = "hell"
                    let image = UIImage(named: imageName)

                    // iterate and add to view
                    for i in 0...EventName.count {
                        imagearr.append(image!)
                        arr2.append("141 members")
                    }
                    tableview.reloadData()
                    
                }
            }
        }
    }
}

extension Rosters:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.img.image =  imagearr[indexPath.row]
        cell.namelbl.text  =  EventName[indexPath.row]
        cell.detaillbl.text  =  arr2[indexPath.row]
        cell.PublicBtn.setTitle(ButtonTitle[indexPath.row], for: .normal)
        cell.PublicBtn.setTitleColor(self.tittleColor[indexPath.row], for: .normal)
        cell.PublicBtn.backgroundColor = self.btnColor[indexPath.row]
        cell.PublicBtn.addTarget(self, action: #selector(publicBtnAction(_:)), for: .touchUpInside)
        cell.PublicBtn.tag = indexPath.row
        
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    // PUBLIC BUTTON ACTION
    @objc func publicBtnAction(_ sender: UIButton){
        
    }
}


