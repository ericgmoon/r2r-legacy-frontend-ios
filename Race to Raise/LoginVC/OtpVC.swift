//
//  OtpVC.swift
//  Race to Raise
//
//  Created by ozit solutions on 06/01/20.
//  Copyright © 2020 ozit solutions. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class OtpVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var otpTxt:UITextField!
    @IBOutlet weak var emailLbl:UILabel!
    var emailStr:String!
    fileprivate var popRecover :  RecoveryVC!
    fileprivate var otpAPI: GetResponseData!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.otpAPI = GetResponseData()
       let screenSize: CGRect = UIScreen.main.bounds
      let screenWidth = screenSize.width
       let screenHeight = screenSize.height
     self.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)

        otpTxt.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 5, height: otpTxt.frame.height))
        otpTxt.leftViewMode = .always
        emailLbl.text = "For security reason,we need to erify your identity We've sent OTP to the \(emailStr!) ,Please enter it below to complete verification."
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
    NotificationCenter.default.addObserver(self, selector: #selector(OtpVC.methodOfReceivedNotification(notification:)), name: Notification.Name("removepopup"), object: nil)

    }
        @objc func methodOfReceivedNotification(notification: Notification) {
          // Take Action on Notification
            self.removeAnimate()
        }

    internal func showInView(_ aView: UIView!, animated: Bool)
    {
        aView.addSubview(self.view)

        if animated
        {
            self.showAnimate()
        }
    }

    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }

    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }

    @IBAction func continuebtn(sender:AnyObject){
      otpApiCall()
    }
    @IBAction func closeBTn(sender:Any){
          removeAnimate()
    }
    func otpApiCall(){
        if InterNet.isConnectedToNetwork() == true {

        let userId = UserDefaults.standard.object(forKey: "userID") as! String
        var userOtpDetials: Dictionary<String,String>
        userOtpDetials = ["otp":otpTxt.text!, "id":userId]
        otpAPI.postVerifyOTPDataOnServer(userOtpDetials){ (isSuccess, error) -> Void in
            if(isSuccess){
                let bundle = Bundle(for: RecoveryVC.self)
                self.popRecover = RecoveryVC(nibName: "RecoveryVC", bundle: bundle)
                self.popRecover.showInView(self.view,animated: true)

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
        animateViewMoving(true, moveValue: 120)

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
     animateViewMoving(false, moveValue: 120)
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
