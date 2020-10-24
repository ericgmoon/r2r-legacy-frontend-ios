//
//  VerifyVC.swift
//  Race to Raise
//
//  Created by ozit solutions on 21/01/20.
//  Copyright © 2020 ozit solutions. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class VerifyVC: UIViewController, UITextFieldDelegate {
       @IBOutlet weak var emailLbl:UITextField!
    fileprivate var verifyAPI: GetResponseData!
    fileprivate var popViewController :  OtpVC!

    override func viewDidLoad() {
        super.viewDidLoad()
          let screenSize: CGRect = UIScreen.main.bounds
         let screenWidth = screenSize.width
          let screenHeight = screenSize.height
        self.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
           emailLbl.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 5, height: emailLbl.frame.height))
           emailLbl.leftViewMode = .always
        
           verifyAPI = GetResponseData()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
    NotificationCenter.default.addObserver(self, selector: #selector(VerifyVC.methodOfReceivedNotification(notification:)), name: Notification.Name("removepopup"), object: nil)

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
      if self.emailLbl.text!.isEmpty != true {
          forgetpasswordApicall()

      }else{
          KAppDelegate.showAlertNotification("Please enter email")

      }
    }
    @IBAction func closeBTn(sender:Any){
          removeAnimate()
    }
    func forgetpasswordApicall(){
        if InterNet.isConnectedToNetwork() == true {
            var userforgetDetials: Dictionary<String,String>
            userforgetDetials = ["email":emailLbl.text!]
            verifyAPI.postForgetDataOnServer(userforgetDetials){ (isSuccess, error) -> Void in
                if(isSuccess){
                    print("SUCESSS")
                    let bundle = Bundle(for: OtpVC.self)
                    self.popViewController = OtpVC(nibName: "OtpVC", bundle: bundle)
                    self.popViewController.emailStr = self.emailLbl.text!
                    self.popViewController.showInView(self.view,animated: true)
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
