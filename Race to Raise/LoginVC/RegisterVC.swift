//
//  RegisterVC.swift
//  Race to Raise
//
//  Created by ozit solutions on 31/12/19.
//  Copyright © 2019 ozit solutions. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class RegisterVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var fullnametextField: UITextField!
    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var passwordtxtField: UITextField!
    fileprivate var registerApi:GetResponseData!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerApi = GetResponseData()
        fullnametextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: fullnametextField.frame.height))
        fullnametextField.leftViewMode = .always
        emailtextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: emailtextField.frame.height))
        emailtextField.leftViewMode = .always

        passwordtxtField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: passwordtxtField.frame.height))
        passwordtxtField.leftViewMode = .always

        // Do any additional setup after loading the view.
    }
    
    @IBAction func stayLoginBtnAction(sender:Any){
        if let button = sender as? UIButton {
            if button.isSelected {
                print("deselected")
              //  UserDefaults.standard.set(false, forKey: "IsLogin")
                let img = UIImage(named: "Icon-3-CheckFill – 1")
                button.setImage(img, for: .normal)
                button.isSelected = false
            } else {
                // set selected
                //UserDefaults.standard.set(true, forKey: "IsLogin")
                print("selected")
                let img = UIImage(named: "verified")
                button.setImage(img, for: .normal)
                button.isSelected = true
            }
        }


    }
    @IBAction func LoginBtnAction(sender:Any){
        self.navigationController?.popViewController(animated: true)

    }
    @IBAction func signUpBtnAction(sender:Any){
        if self.fullnametextField.text!.isEmpty != true {
            if self.emailtextField.text!.isEmpty != true {
                if self.passwordtxtField.text!.isEmpty != true{
                    resisterApicall()

                }else{
                 KAppDelegate.showAlertNotification("Please enter password")
                }

            }else{
                KAppDelegate.showAlertNotification("Please enter email")
            }
        }else{
            KAppDelegate.showAlertNotification("Please enter fullname")

        }


    }
    func resisterApicall(){
        if InterNet.isConnectedToNetwork() == true {

        var userRegisterDetials: Dictionary<String,String>
        userRegisterDetials = ["full_name":fullnametextField.text!,"password":passwordtxtField.text!,"email":emailtextField.text!]
        registerApi.postRegisetDataOnServer(userRegisterDetials){ (isSuccess, error) -> Void in
            if(isSuccess){
                self.navigationController?.popViewController(animated: true)

            }
        }
        }else{
            KAppDelegate.showAlertNotification(noInterNetConnection)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == firstnametextField {
//            lastnametxtField.becomeFirstResponder()
//
//        }else if textField == lastnametxtField{
//            phonetextField.becomeFirstResponder()
//
//        }else if textField == phonetextField{
//            emailtxtField.becomeFirstResponder()
//        }else{
        textField.resignFirstResponder()
      //  }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(true, moveValue: 100)

    }
    func animateViewMoving (_ up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        // self.view.frame = CGRect(x: 0,y: 0,width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        UIView.commitAnimations()

    }
    func textFieldDidEndEditing(_ textField: UITextField) {
     animateViewMoving(false, moveValue: 100)
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
