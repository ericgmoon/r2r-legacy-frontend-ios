//
//  AppDelegate.swift
//  Race to Raise
//
//  Created by ozit solutions on 31/12/19.
//  Copyright © 2019 ozit solutions. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift



@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var originalAppDelegate:AppDelegate!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().backgroundColor = headerColor
        UINavigationBar.appearance().barTintColor = headerColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        // UINavigationBar.appearance().isTranslucent = true
//        if UserDefaults.standard.bool(forKey:"IsLogin") == true{
//         print("Login")
//         self.window = UIWindow(frame: UIScreen.main.bounds)
//         let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//           let objvc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
//         let nav = UINavigationController.init(rootViewController: objvc!)
//         self.window?.rootViewController = nav
//         self.window?.makeKeyAndVisible()
//
//        }else{
//         print("Not Login")
//
//
//         }
                 print("UIApplication ")

        KeyboardActivity()
        Switcher.updateRootVC()
        return true
    }
    func KeyboardActivity(){
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableDebugging = true
    }




    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func sharedInstance() -> AppDelegate {
       return UIApplication.shared.delegate as! AppDelegate
    }

    func showAlertNotification(_ text: String){
        let alert = UIAlertController(title: "", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
       self.window?.rootViewController?.present(alert, animated: true, completion: nil)

    }

}

@available(iOS 13.0, *)
class Switcher {

    static func updateRootVC(){
        let status = UserDefaults.standard.bool(forKey: "IsLogin")
        var rootVC : UIViewController?
        print(status)
        if(status == true){
           // rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()


        }else{

           //rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginVC
            rootVC =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController


        }

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC

    }

}

