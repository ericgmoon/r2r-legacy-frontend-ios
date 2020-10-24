//
//  UpdateProfileVC.swift
//  Race to Raise
//
//  Created by ozit solutions on 31/12/19.
//  Copyright © 2019 ozit solutions. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class UpdateProfileVC: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var oldpasswordtxtField: UITextField!
    @IBOutlet weak var newpasswordtxtField: UITextField!
    @IBOutlet weak var confirmpasswordtxtField: UITextField!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var emaillbl: UILabel!
    @IBOutlet weak var pointlbl: UILabel!
    @IBOutlet weak var tokenlbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    fileprivate var updateApi:GetResponseData!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateApi = GetResponseData()
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Race to Raise"
        self.navigationItem.hidesBackButton = true
        oldpasswordtxtField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: oldpasswordtxtField.frame.height))
        oldpasswordtxtField.leftViewMode = .always
        newpasswordtxtField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: newpasswordtxtField.frame.height))
        newpasswordtxtField.leftViewMode = .always
        confirmpasswordtxtField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: confirmpasswordtxtField.frame.height))
        confirmpasswordtxtField.leftViewMode = .always
        profileImg.layer.masksToBounds = false
        profileImg.layer.cornerRadius = profileImg.frame.size.height/2
        profileImg.clipsToBounds = true

       getprofileApiCall()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.hidesBackButton = true
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "back"), for: .normal)
        button.addTarget(self, action:#selector(barButtonAction), for:.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = barButton


    }
    @objc func barButtonAction() {
        self.navigationController?.popViewController(animated: true)

    }
    func getprofileApiCall(){
        if InterNet.isConnectedToNetwork() == true {

        self.updateApi.getUser_profileData{ (result, error) -> Void in
         // print("result--\(result)")

          let status = "\(result["status"]!)"
          if status == "1" {
            let dict = result["user"] as! NSDictionary
            self.namelbl.text = dict["full_name"] as? String
            self.emaillbl.text = dict["email"] as? String
            if let point = dict["total_points"] as? String{
                self.pointlbl.text = "Point \(point)"
            }
            let token = dict["total_tokens"] as? Int
            self.tokenlbl.text = "Keys:\(token!)"
            if let imageString = dict["profile_image"] as? String{
                self.profileImg.sd_setImage(with: URL(string:baseConstants.profilebaseUrl + imageString), placeholderImage: UIImage(named: "placeholder"))

            }

            }
        }
        }else{
            KAppDelegate.showAlertNotification(noInterNetConnection)
        }

    }

    @IBAction func submitBtn(sender:Any){
        if self.oldpasswordtxtField.text!.isEmpty != true {
            if self.newpasswordtxtField.text!.isEmpty != true {
                if self.newpasswordtxtField.text! == confirmpasswordtxtField.text!{
                 updatepasswordAPIcall()
                }else{
                    KAppDelegate.showAlertNotification("password do not match,Please enter same ")
                }
            }else{
                KAppDelegate.showAlertNotification("Please enter New Password")
            }
        }else{
            KAppDelegate.showAlertNotification("Please enter old Password")

        }

    }

    func updatepasswordAPIcall(){
        if InterNet.isConnectedToNetwork() == true {

        var updateDetials: Dictionary<String,String>
        updateDetials = ["old_password":oldpasswordtxtField.text!,"new_password":newpasswordtxtField.text!]
        updateApi.postupdatePasswordDataOnServer(updateDetials){ (isSuccess, error) -> Void in
            if(isSuccess){
                print("SUCESSS")
                self.navigationController?.popViewController(animated: true)

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
