

import Foundation
import UIKit

class ChatModel{
    var email:String?
    var name:String?
    var password:String?
    init(email:String,name:String,password:String) {
        self.email = email
        self.name = name
        self.password = password
    }
}
