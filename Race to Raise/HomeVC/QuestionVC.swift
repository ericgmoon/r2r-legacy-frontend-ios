//
//  QuestionVC.swift
//  Race to Raise
//
//  Created by ozit solutions on 03/01/20.
//  Copyright © 2020 ozit solutions. All rights reserved.
//

import UIKit
import SDWebImage

@available(iOS 13.0, *)
class QuestionVC: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var teamnamelbl: UILabel!
    @IBOutlet weak var pointslbl: UILabel!
    @IBOutlet weak var tokenlbl: UILabel!
    @IBOutlet weak var questionlbl: UILabel!
    @IBOutlet weak var riddlelbl: UILabel!
    @IBOutlet weak var footearImg: UIImageView!
    @IBOutlet weak var answerTxt: UITextField!
    @IBOutlet weak var hint1lbl: UILabel!
    @IBOutlet weak var hint2lbl: UILabel!
    @IBOutlet weak var hint3lbl: UILabel!
    @IBOutlet weak var hint1Btn: UIButton!
    @IBOutlet weak var hint2Btn: UIButton!
    @IBOutlet weak var hint3Btn: UIButton!
    fileprivate var popViewController :  FeedbackVC!

    fileprivate var get_riddlesApi:GetResponseData!
    @IBOutlet weak var hint1height:NSLayoutConstraint!
    @IBOutlet weak var hint2height:NSLayoutConstraint!
    @IBOutlet weak var hint3height:NSLayoutConstraint!
    var questionNumber:String!
    var team_id:Int!
    var zone_id:Int!
    var ques_id:Int!
    var task_completed:Int!
    var points:String!
    var hint_id:Int! = 0
    var get_hintsArray = NSArray()
    var dict = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hint1lbl.isHidden = true
        self.hint2lbl.isHidden = true
        self.hint3lbl.isHidden = true
        self.hint1Btn.isHidden = true
        self.hint2Btn.isHidden = true
        self.hint3Btn.isHidden = true

        self.get_riddlesApi = GetResponseData()
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Riddles"
        self.navigationItem.hidesBackButton = true
        self.riddlelbl.text = "Riddle \(questionNumber!)"
        getriddlesApicall()
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

        let rightbutton = UIButton.init(type: .custom)
        rightbutton.setImage(UIImage.init(named: "chat"), for: .normal)
        rightbutton.addTarget(self, action:#selector(chatButtonAction), for:.touchUpInside)
        rightbutton.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        let barRightButton = UIBarButtonItem.init(customView: rightbutton)
        self.navigationItem.rightBarButtonItem = barRightButton


    }
    @objc func barButtonAction() {
        self.navigationController?.popViewController(animated: true)

    }
    @objc func chatButtonAction(){
        print("Chat")
        let bundle = Bundle(for: FeedbackVC.self)
        self.popViewController = FeedbackVC(nibName: "FeedbackVC", bundle: bundle)
        self.popViewController.ques_id = ques_id
        self.popViewController.showInView(self.view,animated: true)

    }

    func getriddlesApicall(){
        if InterNet.isConnectedToNetwork() == true {

        var getriddleDetials: Dictionary<String,String>
        getriddleDetials = ["team_id":String(team_id),"zone_id":String(zone_id),"points":points,"ques_id":String(ques_id),"task_completed":String(task_completed)]
        get_riddlesApi.postget_riddleDataOnServerDataOnServer(getriddleDetials){ (result, error) -> Void in
           // print("result--\(result)")
            let status = "\(result["status"]!)"
            if status == "1" {
                self.dict = result["question"] as! NSDictionary
               // print("Dict--\(self.dict)")
                self.teamnamelbl.text = self.dict["team_name"] as? String
                if let total_points = (self.dict as AnyObject).value(forKey: "total_points") as? String{
                    self.pointslbl.text = "Points:\(total_points)"
                }
                let total_tokens = self.dict["total_tokens"] as! NSNumber
                self.tokenlbl.text = "Keys:\(total_tokens)"
                self.questionlbl.text = self.dict["question"] as? String
//                self.riddlelbl.text = "Riddle "
                if let imageString = self.dict["zone_image"] as? String{
                    self.footearImg.sd_setImage(with: URL(string:baseConstants.zonebaseurl + imageString), placeholderImage: UIImage(named: "placeholder"))

                }
                self.get_hintsArray = self.dict["get_hints"] as! NSArray
                if self.get_hintsArray.count <= 0{
               self.hint1height.constant = 0
               self.hint2height.constant = 0
               self.hint3height.constant = 0

                }
                //print("Hint--\(self.get_hintsArray.count)")
                if self.get_hintsArray.count == 1{
                    self.hint2height.constant = 0
                    self.hint3height.constant = 0
                    self.hint1lbl.isHidden = false
                    self.hint1Btn.isHidden = false

                }else if self.get_hintsArray.count == 2{
                    self.hint3height.constant = 0
                    self.hint1lbl.isHidden = false
                    self.hint1Btn.isHidden = false
                    self.hint2lbl.isHidden = false
                    self.hint2Btn.isHidden = false

                }else{
                    self.hint1lbl.isHidden = false
                    self.hint1Btn.isHidden = false
                    self.hint2lbl.isHidden = false
                    self.hint2Btn.isHidden = false
                    self.hint3lbl.isHidden = false
                    self.hint3Btn.isHidden = false

                }

                if (self.dict as AnyObject).value(forKey: "hint_used") as? Int == 1{
                    self.hint1Btn.backgroundColor = grayColor
                    let hintstr = (self.get_hintsArray[0] as AnyObject).value(forKey: "hint") as? String
                    self.hint1lbl.text = hintstr
                    self.hint1lbl.textColor = grayColor
                    self.hint1Btn.isEnabled = false

                }else if (self.dict as AnyObject).value(forKey: "hint_used") as? Int == 2{
                    self.hint1Btn.backgroundColor = grayColor
                    let hint1str = (self.get_hintsArray[0] as AnyObject).value(forKey: "hint") as? String
                    self.hint1lbl.text = hint1str
                    self.hint1lbl.textColor = grayColor
                    self.hint1Btn.isEnabled = false

                    self.hint2Btn.backgroundColor = grayColor
                    let hint2str = (self.get_hintsArray[1] as AnyObject).value(forKey: "hint") as? String
                    self.hint2lbl.text = hint2str
                    self.hint2lbl.textColor = grayColor
                    self.hint2Btn.isEnabled = false

                }else if (self.dict as AnyObject).value(forKey: "hint_used") as? Int == 3{
                    self.hint1Btn.backgroundColor = grayColor
                    let hint1str = (self.get_hintsArray[0] as AnyObject).value(forKey: "hint") as? String
                    self.hint1lbl.text = hint1str
                    self.hint1lbl.textColor = grayColor
                    self.hint1Btn.isEnabled = false

                    self.hint2Btn.backgroundColor = grayColor
                    let hint2str = (self.get_hintsArray[1] as AnyObject).value(forKey: "hint") as? String
                    self.hint2lbl.text = hint2str
                    self.hint2lbl.textColor = grayColor
                    self.hint2Btn.isEnabled = false

                    self.hint3Btn.backgroundColor = grayColor
                    let hintstr = (self.get_hintsArray[2] as AnyObject).value(forKey: "hint") as? String
                    self.hint3lbl.text = hintstr
                    self.hint3lbl.textColor = grayColor
                    self.hint3Btn.isEnabled = false

                }else{
                    print("UnhintUsed")
                }

            }
        }
        }else{
            KAppDelegate.showAlertNotification(noInterNetConnection)
        }
    }

    @IBAction func submitBtn(sender:Any){
        if self.answerTxt.text!.isEmpty != true {
         submitApicall()
        }else{
            KAppDelegate.showAlertNotification("Enter Answer")
        }
    }
    func submitApicall(){
        var submitRiddleDetials: Dictionary<String,String>
        submitRiddleDetials = ["ques_id":String(ques_id),"team_id":String(team_id),"zone_id":String(zone_id),"points":points,"answer":answerTxt.text!]
            get_riddlesApi.postSubmit_riddleDataOnServerDataOnServer(submitRiddleDetials){ (isSuccess, error) -> Void in
                if(isSuccess){
                    self.showToast(message: "Congratulations!!")
                self.navigationController?.popViewController(animated: true)


            }
        }

    }
    @IBAction func hintBtn(sender:UIButton){
        let get_hintsArray1 = self.dict["get_hints"] as! NSArray
        switch sender.tag {
        case 100:
            AskConfirmation(title: hinttitle, message: hintmeassage, vc: self) { (result) in
              if result {
                self.hint_id = (get_hintsArray1[0] as AnyObject).value(forKey: "hint_id") as? Int
                print("Hint1- \(self.hint_id!)")
                self.hintApiCall()
              }else{
                print("NO")

             }
        }
        break
        case 101:
            if (self.dict as AnyObject).value(forKey: "hint_used") as? Int != 0{

            AskConfirmation(title: hinttitle, message: hintmeassage,vc: self) { (result) in
                   if result {

                    self.hint_id = (get_hintsArray1[1] as AnyObject).value(forKey: "hint_id") as? Int
                    print("Hint2- \(self.hint_id!)")
                    self.hintApiCall()
                        

                   }else{

                  }
             }
            }

            break
        case 102:
            if (self.dict as AnyObject).value(forKey: "hint_used") as? Int != 0 && (self.dict as AnyObject).value(forKey: "hint_used") as? Int != 1{

            AskConfirmation(title: hinttitle, message: hintmeassage,vc: self) { (result) in
                   if result {
                    self.hint_id = (get_hintsArray1[2] as AnyObject).value(forKey: "hint_id") as? Int
                    print("Hint3- \(self.hint_id!)")
                    self.hintApiCall()

                   }else{

                  }
                }
             }

            break
            default:
                break

        }
    }

    @IBAction func abandonedBtn(sender:Any){
        let alert = UIAlertController(title: abandontitle, message: abandonMessage, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)

        alert.addAction(UIAlertAction(title: "YES,ABANDON", style: .default, handler: { action in
         print("Click Yes")
            self.abandonApiCall()

        }))

        alert.addAction(UIAlertAction(title: "NO,DON'T ABANDON", style: .cancel, handler: { action in
         print("Click No")

        }))



    }

    func hintApiCall(){
        //postHintDataOnServer
        var hintDetials: Dictionary<String,String>
        hintDetials = ["ques_id":String(ques_id),"team_id":String(team_id),"zone_id":String(zone_id),"hint_id":String(self.hint_id)]

        get_riddlesApi.postHintDataOnServer(hintDetials){ (result, error) -> Void in
            print("result--\(result)")
            let status = "\(result["status"]!)"
            if status == "1" {
                self.getriddlesApicall()


            }
        }
    }

    func abandonApiCall(){
        var abandonDetials: Dictionary<String,String>
        abandonDetials = ["ques_id":String(ques_id),"team_id":String(team_id),"zone_id":String(zone_id),"points":points]
           get_riddlesApi.postSubmit_abandonedDataOnServerDataOnServer(abandonDetials){ (isSuccess, error) -> Void in
                if(isSuccess){
                self.navigationController?.popViewController(animated: true)
                    self.showToast(message: "Riddle is Abandon successful!")

            }
        }

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

   /* func AskConfirmation (title:String, message:String, completion:@escaping (_ result:Bool) -> Void) {
      let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let imgTitle = UIImage(named:"warning")
        let imgViewTitle = UIImageView(frame: CGRect(x: 40, y: 20, width: 20, height: 20))
        imgViewTitle.image = imgTitle
        alert.view.addSubview(imgViewTitle)
        alert.view.tintColor = headerColor


      self.present(alert, animated: true, completion: nil)

      alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in
          completion(true)
      }))

      alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { action in
          completion(false)
      }))
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func showToast(message : String) {

        let toastLabel = UILabel(frame: CGRect(x: 10, y: self.view.frame.size.height-100, width: self.view.frame.size.width - 20, height: 35))
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
