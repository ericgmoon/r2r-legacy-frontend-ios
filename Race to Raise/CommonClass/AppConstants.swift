//
//  AppConstants.swift
//  Race to Raise
//
//  Created by ozit solutions on 31/12/19.
//  Copyright © 2019 ozit solutions. All rights reserved.
//

import Foundation
import UIKit


struct baseConstants {
    static let kUserDefaults = UserDefaults.standard
    static let baseUrl = "http://52.14.243.169/race-to-raise/api/"
    static let profilebaseUrl = "http://52.14.243.169/race-to-raise/public/images/profile/"
    static let zonebaseurl = "http://52.14.243.169/race-to-raise/public/images/zone/"


}

@available(iOS 13.0, *)
let KAppDelegate = AppDelegate().sharedInstance()

let orangeColor  = UIColor(red: 255/255, green: 139/255, blue: 105/255, alpha: 1)
let redColor  = UIColor(red: 216/255, green: 0/255, blue: 39/255, alpha: 1)
let grayColor  = UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 1)
let greenColor  = UIColor(red: 120/255, green: 214/255, blue: 124/255, alpha: 1)
let blueColor  = UIColor(red: 104/255, green: 208/255, blue: 255/255, alpha: 1)
let blackColor  = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
let headerColor  = UIColor(red: 133.0/255.0, green: 221.0/255.0, blue: 219.0/255.0, alpha: 1.0)

let hintmeassage = "Unlocking this hint will cost you 1 Key."
let hinttitle = "Are you sure?"
let abandonMessage = "Once abandon,you won't be able to answer this question again"
let abandontitle = "Are you sure you want to abandon this question?"
let questintitle = "Are you sure?"

let normalFont = UIFont(name:"Montserrat-Regular", size: 14.0)
let primaryFont = UIFont(name:"Montserrat-Regular", size: 18.0)


let noInterNetConnection  = "Opps! No internet Please try later!"
let InvalidJson = "Invalid Json Response"


func showAlert(title: String?, message: String?, buttonTitle: String?, vc: UIViewController) {
//    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//    //alert.view.tintColor =  #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
//    let action = UIAlertAction(title: buttonTitle, style: .cancel, handler: nil)
//    alert.addAction(action)
//    vc.present(alert, animated: true, completion: nil)

    let uiAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    vc.present(uiAlert, animated: true, completion: nil)

    uiAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
     print("Click of default button")


    }))

    uiAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
     print("Click of cancel button")
    }))


}

func AskConfirmation (title:String, message:String, vc: UIViewController, completion:@escaping (_ result:Bool) -> Void) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let imgTitle = UIImage(named:"warning")
    let imgViewTitle = UIImageView(frame: CGRect(x: 40, y: 20, width: 20, height: 20))
    imgViewTitle.image = imgTitle
    alert.view.addSubview(imgViewTitle)
    alert.view.tintColor = headerColor
    vc.present(alert, animated: true, completion: nil)
    alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in
        completion(true)
    }))

    alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { action in
        completion(false)
    }))
  }


class validationClass {
    class func isValidPhone(phoneno: String) -> Bool {
        var PHONE_REGEX = ""
        if phoneno.count == 10 {
            PHONE_REGEX = "^([1-9][0-9]*)|([10])$"
        }else if phoneno.count == 11 {
            PHONE_REGEX = "^([0]{1,1}[1-9][0-9]*)|([11])$"
        }
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: phoneno)
        return result
    }
    class func isValidEmail(emailStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z.%_]{2,20}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,8}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: emailStr)
        return result
    }
}

class convertDictToJsonString {
    class func convertDictToJsonString(dataDict: Dictionary<String, Any>) -> String {
        let data = try! JSONSerialization.data(withJSONObject: dataDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        return json! as String
    }
}


