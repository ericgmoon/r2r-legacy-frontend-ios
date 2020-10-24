//
//  RecoveryVC.swift
//  Race to Raise
//
//  Created by ozit solutions on 31/12/19.
//  Copyright © 2019 ozit solutions. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class RecoveryVC: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var setpasswordtxt:UITextField!
    @IBOutlet weak var confirmpasswordtxt:UITextField!
    fileprivate var recoveryAPI: GetResponseData!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.recoveryAPI = GetResponseData()
          let screenSize: CGRect = UIScreen.main.bounds
         let screenWidth = screenSize.width
          let screenHeight = screenSize.height
        self.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        setpasswordtxt.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: setpasswordtxt.frame.height))
        setpasswordtxt.leftViewMode = .always
        confirmpasswordtxt.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: confirmpasswordtxt.frame.height))
        confirmpasswordtxt.leftViewMode = .always

        // Do any additional setup after loading the view.
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

    @IBAction func submitbtn(sender:AnyObject){
        if setpasswordtxt.text?.isEmpty != true{
            if setpasswordtxt.text! == confirmpasswordtxt.text!{
                    recoveryApicall()
            }else{
                KAppDelegate.showAlertNotification("No match password")
            }
        }else{
            KAppDelegate.showAlertNotification("Please enter password")

        }

    }
    @IBAction func closeBTn(sender:Any){
          removeAnimate()
    }

    func recoveryApicall(){
        if InterNet.isConnectedToNetwork() == true {

        let userId = UserDefaults.standard.object(forKey: "userID") as! String
        var userOtpDetials: Dictionary<String,String>
        userOtpDetials = ["password":setpasswordtxt.text!, "id":userId]
        recoveryAPI.postchangePasswordDataOnServer(userOtpDetials){ (isSuccess, error) -> Void in
            if(isSuccess){
                NotificationCenter.default.post(name: Notification.Name("removepopup"), object: nil)
                self.removeAnimate()
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
