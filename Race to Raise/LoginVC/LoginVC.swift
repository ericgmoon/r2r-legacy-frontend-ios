//
//  LoginVC.swift
//  Race to Raise
//
//  Created by ozit solutions on 31/12/19.
//  Copyright © 2019 ozit solutions. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class LoginVC: UIViewController ,UITextFieldDelegate {

   @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var passwordtxtField: UITextField!
    @IBOutlet weak var resetemailtxtField: UITextField!
    @IBOutlet weak var forgetBtn: UIButton!
    @IBOutlet weak var checkBtn: UIButton!
    var isselectedCheck:Bool = false

    @IBOutlet weak var mview: UIView!
    fileprivate var loginAPI: GetResponseData!
   // fileprivate var popViewController :  OtpVC!
    var popupType:String!
    fileprivate var verifyPopup : VerifyVC!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginAPI = GetResponseData()

        self.navigationController?.navigationBar.isHidden = true
        mview.isHidden = true
        emailtextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: emailtextField.frame.height))
        emailtextField.leftViewMode = .always

        passwordtxtField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: passwordtxtField.frame.height))
        passwordtxtField.leftViewMode = .always

        resetemailtxtField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: resetemailtxtField.frame.height))
        resetemailtxtField.leftViewMode = .always
        //self.forgetBtn.titleLabel?.font =  UIFont(name: "IBMPlexSans-Medium", size: 50)

        //NotificationCenter.default.addObserver(self, selector: #selector(self.receivedNotificationForTab(notification:)), name: Notification.Name("NextControllerForTab"), object: nil)


        // Do any additional setup after loading the view.
    }
    //Local Notification Handle
    @objc func receivedNotificationForTab(notification: Notification) {
        if notification.object! as! String == "home" {
            let objvc = self.storyboard!.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            self.navigationController!.pushViewController(objvc, animated: false)
        }else if notification.object! as! String == "profile" {
            let objvc = self.storyboard!.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
            self.navigationController!.pushViewController(objvc, animated: false)

        }else if notification.object! as! String == "leaderboard" {
            let objvc = self.storyboard!.instantiateViewController(withIdentifier: "LeaderboardVC") as! LeaderboardVC
            self.navigationController!.pushViewController(objvc, animated: false)

        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        passwordtxtField.text = ""
//        emailtextField.text = ""
//        if isselectedCheck == true{
//
//        }else{
//        let img = UIImage(named: "Icon-3-CheckFill – 1")
//        checkBtn.setImage(img, for: .normal)
//        }

    }

    @IBAction func stayLoginBtnAction(sender:Any){
        if let button = sender as? UIButton {
            if button.isSelected {
                print("deselected")
                let img = UIImage(named: "Icon-3-CheckFill – 1")
                button.setImage(img, for: .normal)
                checkBtn.isSelected = false
                self.isselectedCheck = false
            } else {
                // set selected
                //UserDefaults.standard.set(true, forKey: "IsLogin")
                print("selected")
                let img = UIImage(named: "verified")
                button.setImage(img, for: .normal)
                checkBtn.isSelected = true
                self.isselectedCheck = true

            }
        }

    }
    @IBAction func forgottenBtnAction(sender:Any){

        let bundle = Bundle(for: VerifyVC.self)
        self.verifyPopup = VerifyVC(nibName: "VerifyVC", bundle: bundle)
        self.verifyPopup.showInView(self.view,animated: true)

//          popupType = "forget"
//        UIView.transition(with: mview,
//                          duration: 1.0,
//                          options: [.showHideTransitionViews],
//                          animations: {
//
//                            self.mview.isHidden = false
//        },
//                          completion: nil)


    }
    @IBAction func newAccountBtnAction(sender:Any){
        let objvc = storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(objvc, animated: true)

    }
    @IBAction func signInBtnAction(sender:Any){

        if self.emailtextField.text!.isEmpty != true {
            if self.passwordtxtField.text!.isEmpty != true {
               callLoginAPI()

            }else{
                KAppDelegate.showAlertNotification("Please enter password")
            }
        }else{
            KAppDelegate.showAlertNotification("Please enter email")

        }

    }
    @IBAction func continueBtnAction(sender:Any){

//        if self.resetemailtxtField.text!.isEmpty != true {
//            forgetpasswordApicall()
//
//        }else{
//            KAppDelegate.showAlertNotification("Please enter email")
//
//        }

    }
    @IBAction func colseBtnAction(sender:Any){
        mview.isHidden = true

    }
    func callLoginAPI(){
    if InterNet.isConnectedToNetwork() == true {

        var userLoginDetials: Dictionary<String,String>
        userLoginDetials = ["email":emailtextField.text!, "password":passwordtxtField.text!]
        loginAPI.postLoginDataOnServer(userLoginDetials){ (isSuccess, error) -> Void in
            if(isSuccess){
                if self.isselectedCheck == true{
                 UserDefaults.standard.set(true, forKey: "IsLogin")
                }
                let objvc = self.storyboard!.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.navigationController?.pushViewController(objvc, animated: true)
//                Switcher.updateRootVC()
//                senceSwitcher.updateRootVC()

            }
        }
       }else{
        KAppDelegate.showAlertNotification(noInterNetConnection)

        }

    }
    func forgetpasswordApicall(){
        if InterNet.isConnectedToNetwork() == true {

        var userforgetDetials: Dictionary<String,String>
        userforgetDetials = ["email":resetemailtxtField.text!]
        loginAPI.postForgetDataOnServer(userforgetDetials){ (isSuccess, error) -> Void in
            if(isSuccess){
                self.mview.isHidden = true
                print("SUCESSS")
               // let bundle = Bundle(for: OtpVC.self)
//                self.popViewController = OtpVC(nibName: "OtpVC", bundle: bundle)
//                self.popViewController.emailStr = self.resetemailtxtField.text!
//                self.popViewController.showInView(self.view,animated: true)
            }
        }
        }else{
            KAppDelegate.showAlertNotification(noInterNetConnection)
        }

        }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(true, moveValue: 80)

    }
    func animateViewMoving (_ up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
         //self.view.frame = CGRect(x: 0,y: 0,width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        UIView.commitAnimations()

    }
    func textFieldDidEndEditing(_ textField: UITextField) {
     animateViewMoving(false, moveValue: 80)
      textField.resignFirstResponder()

    }




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
