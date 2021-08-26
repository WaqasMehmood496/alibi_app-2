//
//  PopupHelper.swift
//  TradeAir
//
//  Created by Adeel on 08/10/2019.
//  Copyright © 2019 Buzzware. All rights reserved.
//

import UIKit
//import SwiftEntryKit

class PopupHelper
{
    /// Show a popup using the STPopup framework [STPopup on Cocoapods](https://cocoapods.org/pods/STPopup)
    /// - parameters:
    ///   - storyBoard: the name of the storyboard the popup viewcontroller will be loaded from
    ///   - popupName: the name of the viewcontroller in the storyboard to load
    ///   - viewController: the viewcontroller the popup will be popped up from
    ///   - blurBackground: boolean to indicate if the background should be blurred
    /// - returns: -
    static let sharedInstance = PopupHelper() //<- Singleton Instance
    
    private init() { /* Additional instances cannot be created */ }
    static func alertWithField(title: String,message: String,qty: String,unit: String,part: String){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Quantity"
            textField.text = qty
            textField.placeHolderColor = UIColor().colorsFromAsset(name: .themeColor)
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Unit"
            textField.text = unit
            textField.placeHolderColor = UIColor().colorsFromAsset(name: .themeColor)
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Part"
            textField.text = part
            textField.placeHolderColor = UIColor().colorsFromAsset(name: .themeColor)
        }
        let saveAction = UIAlertAction.init(title: "Save", style: .default) { (alertAction) in
            
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default) { (alertAction) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        
    }
    static func alertWithOk(title: String,message: String,controler:UIViewController){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let saveAction = UIAlertAction.init(title: "Ok", style: .default) { (alertAction) in
            controler.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(saveAction)
        controler.present(alertController, animated: true, completion: nil)
        
        
        
    }
//    static func alertTop(title:String,msg:String,uppercolor:UIColor.assetColors,lowercolor:UIColor.assetColors,controler:UIViewController){
//        
//        var attributes = EKAttributes()
//        attributes.name = "Top Note"
//        EKAttributes.Precedence.QueueingHeuristic.value = .priority
//        attributes.precedence = .enqueue(priority: .normal)
//        attributes.precedence.priority = .normal
//        attributes.displayDuration = 2
//        attributes.entryBackground = .color(color: .init(light: UIColor().colorsFromAsset(name: uppercolor), dark: UIColor().colorsFromAsset(name: lowercolor)))
//        
//        let title = EKProperty.LabelContent(text: title, style: .init(font: UIFont(name: "Montserrat-Regular", size: 15)!, color: .white))
//        let description = EKProperty.LabelContent(text: msg, style: .init(font: UIFont(name: "Montserrat-Regular", size: 13)!, color: .white))
//        let simpleMessage = EKSimpleMessage(title: title, description: description)
//        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
//
//        let contentView = EKNotificationMessageView(with: notificationMessage)
//        SwiftEntryKit.display(entry: contentView, using: attributes)
//        if SwiftEntryKit.isCurrentlyDisplaying(entryNamed: "Top Note") {
//            /* Do your things */
//            SwiftEntryKit.dismiss(.enqueued)
//        }
//    }
//    static func alertMid(title:String,msg:String,uppercolor:UIColor.assetColors,lowercolor:UIColor.assetColors,controler:UIViewController){
//        
//        var attributes = EKAttributes.centerFloat
//        attributes.name = "Top Note"
//        EKAttributes.Precedence.QueueingHeuristic.value = .priority
//        attributes.windowLevel = .alerts
//        attributes.position = .center
//        attributes.precedence = .enqueue(priority: .normal)
//        attributes.precedence.priority = .normal
//        attributes.displayDuration = 2
//        attributes.entryBackground = .color(color: .init(light: UIColor().colorsFromAsset(name: uppercolor), dark: UIColor().colorsFromAsset(name: lowercolor)))
//        
//        let title = EKProperty.LabelContent(text: title, style: .init(font: UIFont(name: "Montserrat-Regular", size: 15)!, color: .white))
//        let description = EKProperty.LabelContent(text: msg, style: .init(font: UIFont(name: "Montserrat-Regular", size: 13)!, color: .white))
//        let simpleMessage = EKSimpleMessage(title: title, description: description)
//        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
//
//        let contentView = EKNotificationMessageView(with: notificationMessage)
//        SwiftEntryKit.display(entry: contentView, using: attributes)
//        if SwiftEntryKit.isCurrentlyDisplaying(entryNamed: "Top Note") {
//            /* Do your things */
//            SwiftEntryKit.dismiss(.enqueued)
//        }
//    }
}

