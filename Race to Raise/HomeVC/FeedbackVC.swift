//
//  FeedbackVC.swift
//  Race to Raise
//
//  Created by ozit solutions on 05/01/20.
//  Copyright © 2020 ozit solutions. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)

class FeedbackVC: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    let PLACEHOLDER_TEXT = "Message (300 words max)"

    @IBOutlet weak var FeedbakTxt:UITextView!
    fileprivate var feedbackApi:GetResponseData!
    var ques_id:Int! = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedbackApi = GetResponseData()
       // self.navigationController?.navigationBar.isHidden = true
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        self.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        applyPlaceholderStyle(aTextview: FeedbakTxt, placeholderText: PLACEHOLDER_TEXT)
        self.FeedbakTxt.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))

        // Do any additional setup after loading the view.
    }
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }

    func applyPlaceholderStyle(aTextview: UITextView, placeholderText: String)
    {
      // make it look (initially) like a placeholder
      aTextview.textColor = grayColor
      aTextview.text = placeholderText
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
    

    @IBAction func sendButton(sender:Any){
        if self.FeedbakTxt.text!.isEmpty != true {
         sendMessageApicall()
        }else{
            KAppDelegate.showAlertNotification("Enter Message")
        }


    }
    func sendMessageApicall(){
        if InterNet.isConnectedToNetwork() == true {

                var feedbackDetials: Dictionary<String,String>
        feedbackDetials = ["ques_id":String(ques_id),"feedback":FeedbakTxt.text!]
                feedbackApi.postSubmit_feedbackDataOnServer(feedbackDetials){ (result, error) -> Void in
                    //print("result--\(result)")
                    let status = "\(result["status"]!)"
                    if status == "1" {
                        print("Sucess")
                        self.showToast(message: "ok")
                        self.removeAnimate()
                    }
                }
        }else{
            KAppDelegate.showAlertNotification(noInterNetConnection)
        }

    }
    
    
    @IBAction func closeBtn(sender:Any){
        removeAnimate()

    }
    func textViewDidBeginEditing(_ textView: UITextView) {
               animateViewMoving(true, moveValue: 100)
        applyNonPlaceholderStyle(aTextview: textView)


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
    func textViewDidEndEditing(_ textView: UITextView) {
             animateViewMoving(false, moveValue: 100)
         textView.resignFirstResponder()

    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

                let maxLength = 300
        let currentString: NSString = textView.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: text) as NSString
        return newString.length <= maxLength

    }



    func applyNonPlaceholderStyle(aTextview: UITextView)
    {
      // make it look like normal text instead of a placeholder
        aTextview.text = ""
      aTextview.textColor = UIColor.black
      aTextview.alpha = 1.0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func showToast(message : String) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 100, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }



}
extension UITextView {

    func addDoneButton(title: String, target: Any, selector: Selector) {

        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}
