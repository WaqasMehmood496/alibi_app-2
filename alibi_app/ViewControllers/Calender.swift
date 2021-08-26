

import UIKit
import Calendar_iOS
import AVFoundation

class Calender: UIViewController,CalendarViewDelegate {
    var calenderIOS = CalendarView(frame: CGRect(x: 50, y: 100, width: 400, height: 280))
    var delegate : refreshDesignProtocal?
    @IBOutlet weak var cal_view: UIView!
    @IBOutlet weak var dateLBL: UILabel!
    var date1:String! = ""
    let eventdetial = EventDetail()
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.cal_view.layer.borderWidth = 2
        self.cal_view.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
            
        calenderIOS.currentDate = Date()
        calenderIOS.calendarDelegate = self
        calenderIOS.selectionColor = UIColor.init(red: 97/255, green: 59/255, blue: 255/255, alpha: 255/255)
        let date = Date()
        let dateFormatterPrint = DateFormatter()
        //"E, d MMMM yyyy"
        dateFormatterPrint.dateFormat = "d MMMM yyyy"
        let datestring = dateFormatterPrint.string(from: date)
        dateLBL.text =  datestring
        cal_view.addSubview(calenderIOS)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    

    func didChangeCalendarDate(_ date: Date!) {
        let dateFormatterPrint = DateFormatter()
        //"E, d MMMM yyyy"
        dateFormatterPrint.dateFormat = "d MMMM yyyy"
        let datestring = dateFormatterPrint.string(from: date)
        dateLBL.text =  datestring
        SelectedDate.removeAll()
        SelectedDate.append(datestring)
        date1 = datestring
    }
    @IBAction func back_btn_action(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        delegate?.refreshData(date: date1)
        
    }
    

}
