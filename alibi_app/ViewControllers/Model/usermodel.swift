//
//  usermodel.swift
//  alibi_app
//
//  Created by Azmat Abbas on 09/06/2021.
//  Copyright © 2021 apple. All rights reserved.
//
import Foundation
import UIKit
class UserModel:NSObject,NSCoding{
var first_Name = String()
 var last_name = String()
 var email = String()
 var password = String()
  var user_id = String()
 override init()
 {
   first_Name     = ""
   last_name    = ""
   email   = ""
   password  = ""
    user_id = ""
 }
 init(Data:UserModel)
 {
   first_Name = Data.first_Name
   last_name = Data.last_name
   email   = Data.email
   password  = Data.password
    user_id  = Data.user_id
 }
 required convenience init?(coder aDecoder: NSCoder) {
   let obj     = UserModel()
   obj.first_Name = aDecoder.decodeObject(forKey: Constant.first_Name) as? String ?? ""
   obj.last_name  = aDecoder.decodeObject(forKey: Constant.last_name) as? String ?? ""
   obj.email    = aDecoder.decodeObject(forKey: Constant.email) as? String ?? ""
    
    obj.user_id    = aDecoder.decodeObject(forKey: constants.user_ID) as? String ?? ""
   self.init(Data:obj)
 }
 func encode(with aCoder: NSCoder) {
   aCoder.encode(self.first_Name, forKey: "\(Constant.first_Name)")
   aCoder.encode(self.last_name, forKey: "\(Constant.last_name)")
   aCoder.encode(self.email, forKey: "\(Constant.email)")
    aCoder.encode(self.user_id, forKey: "\(constants.user_ID)")
    
 }
 //MARK: Private Methods
 static func LoadData(key:String) -> UserModel
 {
   if let DataFromCache = UserDefaults.standard.object(forKey: "\(key)_List") as? Data
   {
     let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: DataFromCache) as! UserModel
     return decodedTeams
   }
   else
   {
     return UserModel()
   }
 }
 static func SaveData(Data:UserModel,key:String)
 {
   // load data for not network time
   let userDefaults   = UserDefaults.standard
   let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: Data)
   userDefaults.set(encodedData, forKey: "\(key)_List")
   userDefaults.synchronize()
 }
}
