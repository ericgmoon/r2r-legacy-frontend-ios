//
//  ZoneRiddlesVC.swift
//  Race to Raise
//
//  Created by ozit solutions on 02/01/20.
//  Copyright © 2020 ozit solutions. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class ZoneRiddlesVC: UIViewController {
    @IBOutlet weak var oneBtn: UIButton!
    @IBOutlet weak var twoBtn: UIButton!
    @IBOutlet weak var threeBtn: UIButton!
    @IBOutlet weak var fourBtn: UIButton!
    @IBOutlet weak var fiveBtn: UIButton!
    @IBOutlet weak var sixeBtn: UIButton!
    @IBOutlet weak var seveneBtn: UIButton!
    @IBOutlet weak var eightBtn: UIButton!
    @IBOutlet weak var nightBtn: UIButton!
    @IBOutlet weak var tenBtn: UIButton!
    @IBOutlet weak var teamnamelbl: UILabel!
    @IBOutlet weak var pointslbl: UILabel!
    @IBOutlet weak var tokenlbl: UILabel!
    @IBOutlet weak var zonelbl: UILabel!

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lblPercentage: UILabel!
    var time : Float = 0.0
    var timer: Timer?
    fileprivate var zone_riddles:GetResponseData!
    var team_id:Int! = 0
    var zone_id:Int! = 0
    var points:String! = ""
    var completeRiddle:Int! = 0
    var riddleslist = [[String:AnyObject]]()
   var pointArray = NSArray()
   var dict = NSDictionary()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.zone_riddles = GetResponseData()
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Zone Riddles"
        self.navigationItem.hidesBackButton = true

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
        time = 0.0
        progressBar.setProgress(0.0, animated: true)
        lblPercentage.text = "\(progressBar.progress*100)%"

        zoneRiddersApicall()

    }
    @objc func barButtonAction() {
        self.navigationController?.popViewController(animated: true)

    }
    func zoneRiddersApicall(){
        if InterNet.isConnectedToNetwork() == true {

        var zoneDetials: Dictionary<String,String>
        zoneDetials = ["team_id":String(team_id),"zone_id":String(zone_id),"points":points]
        zone_riddles.postZoneRidersDataOnServer(zoneDetials){ (result, error) -> Void in
           // print("result--\(result)")
            let status = "\(result["status"]!)"
            if status == "1" {
                self.teamnamelbl.text = result["team_name"] as? String
                if let total_points = (result as AnyObject).value(forKey: "total_points") as? String{
                    self.pointslbl.text = "Points:\(total_points)"
                }
                let total_tokens = result["total_tokens"] as! NSNumber
                self.tokenlbl.text = "Keys:\(total_tokens)"
                self.zonelbl.text = result["zone_name"] as? String
                let completeriddles = result["completed_riddles"] as! Int
                self.completeRiddle = completeriddles
                self.time += Float(completeriddles)
                self.progressBar.setProgress(self.time/10, animated: true)
                let percentvalue = String(format: "%.0f", self.progressBar.progress*100)
                self.lblPercentage.text = "\(percentvalue)%"
                self.dict = result["data"] as! NSDictionary

                let point10Array = self.dict["10_points"] as! NSArray
                    if (point10Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 0{
                        self.oneBtn.backgroundColor = grayColor

                    }else if (point10Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                        self.oneBtn.backgroundColor = blueColor

                    }else if (point10Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                        if (point10Array[0] as AnyObject).value(forKey: "is_correct") as? Int == 1{
                            self.oneBtn.backgroundColor = greenColor
                        }else{
                            self.oneBtn.backgroundColor = blueColor
                        }

                    }else{
                        self.oneBtn.backgroundColor = orangeColor

                    }
                if (point10Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 0{
                    self.twoBtn.backgroundColor = grayColor

                }else if (point10Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                    self.twoBtn.backgroundColor = blueColor

                }else if (point10Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                    if (point10Array[1] as AnyObject).value(forKey: "is_correct") as? Int == 1{
                        self.twoBtn.backgroundColor = greenColor
                    }else{
                        self.twoBtn.backgroundColor = blueColor
                    }

                }else{
                    self.twoBtn.backgroundColor = orangeColor

                }
                if (point10Array[2] as AnyObject).value(forKey: "task_completed") as? Int == 0{
                    self.threeBtn.backgroundColor = grayColor

                }else if (point10Array[2] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                    self.threeBtn.backgroundColor = blueColor

                }else if (point10Array[2] as AnyObject).value(forKey: "task_completed") as? Int == 2{

                    if (point10Array[2] as AnyObject).value(forKey: "is_correct") as? Int == 1{
                        self.threeBtn.backgroundColor = greenColor
                    }else{
                        self.threeBtn.backgroundColor = blueColor
                    }

                }else{
                    self.threeBtn.backgroundColor = orangeColor

                }
                if (point10Array[3] as AnyObject).value(forKey: "task_completed") as? Int == 0{
                    self.fourBtn.backgroundColor = grayColor

                }else if (point10Array[3] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                    self.fourBtn.backgroundColor = blueColor

                }else if (point10Array[3] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                    if (point10Array[3] as AnyObject).value(forKey: "is_correct") as? Int == 1{
                        self.fourBtn.backgroundColor = greenColor
                    }else{
                        self.fourBtn.backgroundColor = blueColor
                    }
                }else{
                    self.fourBtn.backgroundColor = orangeColor

                }
                let point20Array = self.dict["20_points"] as! NSArray
                    if (point20Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 0{
                        self.fiveBtn.backgroundColor = grayColor

                    }else if (point20Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                        self.fiveBtn.backgroundColor = blueColor

                    }else if (point20Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                        if (point20Array[0] as AnyObject).value(forKey: "is_correct") as? Int == 1{
                            self.fiveBtn.backgroundColor = greenColor
                        }else{
                            self.fiveBtn.backgroundColor = blueColor
                        }

                    }else{
                        self.fiveBtn.backgroundColor = orangeColor

                    }
                if (point20Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 0{
                    self.sixeBtn.backgroundColor = grayColor

                }else if (point20Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                    self.sixeBtn.backgroundColor = blueColor

                }else if (point20Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                    if (point20Array[1] as AnyObject).value(forKey: "is_correct") as? Int == 1{
                        self.sixeBtn.backgroundColor = greenColor
                    }else{
                        self.sixeBtn.backgroundColor = blueColor
                    }

                }else{
                    self.sixeBtn.backgroundColor = orangeColor

                }
                if (point20Array[2] as AnyObject).value(forKey: "task_completed") as? Int == 0{
                    self.seveneBtn.backgroundColor = grayColor

                }else if (point20Array[2] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                    self.seveneBtn.backgroundColor = blueColor

                }else if (point20Array[2] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                    if (point20Array[2] as AnyObject).value(forKey: "is_correct") as? Int == 1{
                        self.seveneBtn.backgroundColor = greenColor
                    }else{
                        self.seveneBtn.backgroundColor = blueColor
                    }

                }else {
                    self.seveneBtn.backgroundColor = orangeColor

                }
                let point30Array = self.dict["30_points"] as! NSArray
                    if (point30Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 0{
                        self.eightBtn.backgroundColor = grayColor

                    }else if (point30Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                        self.eightBtn.backgroundColor = blueColor

                    }else if (point30Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                        if (point30Array[0] as AnyObject).value(forKey: "is_correct") as? Int == 1{
                            self.eightBtn.backgroundColor = greenColor
                        }else{
                            self.eightBtn.backgroundColor = blueColor
                        }

                    }else {
                        self.eightBtn.backgroundColor = orangeColor

                    }
                if (point30Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 0{
                    self.nightBtn.backgroundColor = grayColor

                }else if (point30Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                    self.nightBtn.backgroundColor = blueColor

                }else if (point30Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                    if (point30Array[1] as AnyObject).value(forKey: "is_correct") as? Int == 1{
                        self.nightBtn.backgroundColor = greenColor
                    }else{
                        self.nightBtn.backgroundColor = blueColor
                    }

                }else{
                    self.nightBtn.backgroundColor = orangeColor

                }
                let point40Array = self.dict["40_points"] as! NSArray
                    if (point40Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 0{
                        self.tenBtn.backgroundColor = grayColor

                    }else if (point40Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                        self.tenBtn.backgroundColor = blueColor

                    }else if (point40Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                        if (point40Array[0] as AnyObject).value(forKey: "is_correct") as? Int == 1{
                            self.tenBtn.backgroundColor = greenColor
                        }else{
                            self.tenBtn.backgroundColor = blueColor
                        }

                    }else{
                        self.tenBtn.backgroundColor = orangeColor

                    }

                }
            }
        }else{
            KAppDelegate.showAlertNotification(noInterNetConnection)
        }
        }


    @IBAction func pointBtn(sender:UIButton){
        let point10Array = self.dict["10_points"] as! NSArray
        let point20Array = self.dict["20_points"] as! NSArray
        let point30Array = self.dict["30_points"] as! NSArray
        let point40Array = self.dict["40_points"] as! NSArray
        switch sender.tag {
        case 100:
                if (point10Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 0{
                    AskConfirmation(title: questintitle, message: "This action will cost you 1 Key.",vc:self) { (result) in
                       if result {
                        print("Ok")
                        let questionID = (point10Array[0] as AnyObject).value(forKey: "ques_id") as? Int
                        let taskcomplete =  (point10Array[0] as AnyObject).value(forKey: "task_completed") as? Int
                        self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "10",riddle_number: "1.1")
                       } else {
                       print("Cancel")
                       }
                   }

                }else if (point10Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                    print("Zero1")
                        let questionID = (point10Array[0] as AnyObject).value(forKey: "ques_id") as? Int
                        let taskcomplete =  (point10Array[0] as AnyObject).value(forKey: "task_completed") as? Int
                        self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "10",riddle_number: "1.1")

                }else if (point10Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                    print("Zero2")
                    if (point10Array[0] as AnyObject).value(forKey: "is_correct") as? Int == 1{
                        self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "1.1",riddlestype: "completed")
                    }else{
                        let questionID = (point10Array[0] as AnyObject).value(forKey: "ques_id") as? Int
                        let taskcomplete =  (point10Array[0] as AnyObject).value(forKey: "task_completed") as? Int
                        self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "10",riddle_number: "1.1")

                    }

                }else if (point10Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 3{
//                        let questionID = (point10Array[0] as AnyObject).value(forKey: "ques_id") as? Int
//                        let taskcomplete =  (point10Array[0] as AnyObject).value(forKey: "task_completed") as? Int
//                        self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "10",riddle_number: "1.1")
                    self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "1.1",riddlestype: "abdandoned")


                }

            break
        case 101:
            if (point10Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 0{
                AskConfirmation(title: questintitle, message: "This action will cost you 1 Key.",vc:self) { (result) in
                   if result {
                        let questionID = (point10Array[1] as AnyObject).value(forKey: "ques_id") as? Int
                        let taskcomplete =  (point10Array[1] as AnyObject).value(forKey: "task_completed") as? Int
                        self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "10",riddle_number: "1.2")

                   } else {
                   print("Cancel")
                   }
               }
            }else if (point10Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                    let questionID = (point10Array[1] as AnyObject).value(forKey: "ques_id") as? Int
                    let taskcomplete =  (point10Array[1] as AnyObject).value(forKey: "task_completed") as? Int
                    self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "10",riddle_number: "1.2")

            }else if (point10Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                print("Zero2")
                if (point10Array[1] as AnyObject).value(forKey: "is_correct") as? Int == 1{
                    self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "1.2",riddlestype: "completed")

                }else{
                let questionID = (point10Array[1] as AnyObject).value(forKey: "ques_id") as? Int
            let taskcomplete =  (point10Array[1] as AnyObject).value(forKey: "task_completed") as? Int
            self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "10",riddle_number: "1.2")
                }
            }else if (point10Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 3{
//                    let questionID = (point10Array[1] as AnyObject).value(forKey: "ques_id") as? Int
//                    let taskcomplete =  (point10Array[1] as AnyObject).value(forKey: "task_completed") as? Int
//                    self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "10",riddle_number: "1.2")

                self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "1.2",riddlestype: "abdandoned")


            }

            break
        case 102:
            if (point10Array[2] as AnyObject).value(forKey: "task_completed") as? Int == 0{
                AskConfirmation(title: questintitle, message: "This action will cost you 1 Key.",vc:self) { (result) in
                   if result {
                        let questionID = (point10Array[2] as AnyObject).value(forKey: "ques_id") as? Int
                        let taskcomplete =  (point10Array[2] as AnyObject).value(forKey: "task_completed") as? Int
                        self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "10",riddle_number: "1.3")

                   } else {
                   print("Cancel")
                   }
               }
            }else if (point10Array[2] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                    let questionID = (point10Array[2] as AnyObject).value(forKey: "ques_id") as? Int
                    let taskcomplete =  (point10Array[2] as AnyObject).value(forKey: "task_completed") as? Int
                    self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "10",riddle_number: "1.3")

            }else if (point10Array[2] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                if (point10Array[2] as AnyObject).value(forKey: "is_correct") as? Int == 1{

                self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "1.3",riddlestype: "completed")
                }else{
                let questionID = (point10Array[2] as AnyObject).value(forKey: "ques_id") as? Int
                let taskcomplete =  (point10Array[2] as AnyObject).value(forKey: "task_completed") as? Int
                self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "10",riddle_number: "1.3")

                }
            }else if (point10Array[2] as AnyObject).value(forKey: "task_completed") as? Int == 3{
//                    let questionID = (point10Array[2] as AnyObject).value(forKey: "ques_id") as? Int
//                    let taskcomplete =  (point10Array[2] as AnyObject).value(forKey: "task_completed") as? Int
//                    self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "10",riddle_number: "1.3")
                self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "1.3",riddlestype: "abdandoned")


            }

            break
        case 103:
            if (point10Array[3] as AnyObject).value(forKey: "task_completed") as? Int == 0{
                AskConfirmation(title: questintitle, message: "This action will cost you 1 Key.",vc:self) { (result) in
                   if result {
                        let questionID = (point10Array[3] as AnyObject).value(forKey: "ques_id") as? Int
                        let taskcomplete =  (point10Array[3] as AnyObject).value(forKey: "task_completed") as? Int
                        self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "10",riddle_number: "1.4")

                   } else {
                   print("Cancel")
                   }
               }
            }else if (point10Array[3] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                    let questionID = (point10Array[3] as AnyObject).value(forKey: "ques_id") as? Int
                    let taskcomplete =  (point10Array[3] as AnyObject).value(forKey: "task_completed") as? Int
                    self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "10",riddle_number: "1.4")

            }else if (point10Array[3] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                if (point10Array[3] as AnyObject).value(forKey: "is_correct") as? Int == 1{
                    self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "1.4",riddlestype: "completed")

                }else{
                let questionID = (point10Array[3] as AnyObject).value(forKey: "ques_id") as? Int
                let taskcomplete =  (point10Array[3] as AnyObject).value(forKey: "task_completed") as? Int
                self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "10",riddle_number: "1.4")

                }

            }else if (point10Array[3] as AnyObject).value(forKey: "task_completed") as? Int == 3{
//                    let questionID = (point10Array[3] as AnyObject).value(forKey: "ques_id") as? Int
//                    let taskcomplete =  (point10Array[3] as AnyObject).value(forKey: "task_completed") as? Int
//                    self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "10",riddle_number: "1.4")
                self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "1.4",riddlestype: "abdandoned")


            }

            break
        case 104:
            if (point20Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 0{
            AskConfirmation(title: questintitle, message: "This action will cost you 2 Keys.",vc: self) { (result) in
                   if result {
                        let questionID = (point20Array[0] as AnyObject).value(forKey: "ques_id") as? Int
                        let taskcomplete =  (point20Array[0] as AnyObject).value(forKey: "task_completed") as? Int
                        self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "20",riddle_number: "2.1")

                   } else {
                   print("Cancel")
                   }
               }
            }else if (point20Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                    let questionID = (point20Array[0] as AnyObject).value(forKey: "ques_id") as? Int
                    let taskcomplete =  (point20Array[0] as AnyObject).value(forKey: "task_completed") as? Int
                    self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "20",riddle_number: "2.1")

            }else if (point20Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                if (point20Array[0] as AnyObject).value(forKey: "is_correct") as? Int == 1{
                    self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "2.1",riddlestype: "completed")

                }else{
                    let questionID = (point20Array[0] as AnyObject).value(forKey: "ques_id") as? Int
                                        let taskcomplete =  (point20Array[0] as AnyObject).value(forKey: "task_completed") as? Int
                                        self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "20",riddle_number: "2.1")
                }

            }else if (point20Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 3{
//                    let questionID = (point20Array[0] as AnyObject).value(forKey: "ques_id") as? Int
//                    let taskcomplete =  (point20Array[0] as AnyObject).value(forKey: "task_completed") as? Int
//                    self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "20",riddle_number: "2.1")
                self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "2.1",riddlestype: "abdandoned")


            }

            break
        case 105:
            if (point20Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 0{
            AskConfirmation(title: questintitle, message: "This action will cost you 2 Keys.",vc: self) { (result) in
                   if result {
                        let questionID = (point20Array[1] as AnyObject).value(forKey: "ques_id") as? Int
                        let taskcomplete =  (point20Array[1] as AnyObject).value(forKey: "task_completed") as? Int
                        self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "20",riddle_number: "2.2")

                   } else {
                   print("Cancel")
                   }
               }
            }else if (point20Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                let questionID = (point20Array[1] as AnyObject).value(forKey: "ques_id") as? Int
                let taskcomplete =  (point20Array[1] as AnyObject).value(forKey: "task_completed") as? Int
                self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "20",riddle_number: "2.2")

            }else if (point20Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                if (point20Array[1] as AnyObject).value(forKey: "is_correct") as? Int == 1{
                    self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "2.2",riddlestype: "completed")

                }else{
                    let questionID = (point20Array[1] as AnyObject).value(forKey: "ques_id") as? Int
                                    let taskcomplete =  (point20Array[1] as AnyObject).value(forKey: "task_completed") as? Int
                                    self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "20",riddle_number: "2.2")
                }
            }else if (point20Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 3{
//                let questionID = (point20Array[1] as AnyObject).value(forKey: "ques_id") as? Int
//                let taskcomplete =  (point20Array[1] as AnyObject).value(forKey: "task_completed") as? Int
//                self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "20",riddle_number: "2.2")
                self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "2.2",riddlestype: "abdandoned")


            }

            break
        case 106:
            if (point20Array[2] as AnyObject).value(forKey: "task_completed") as? Int == 0{
                AskConfirmation(title: questintitle, message: "This action will cost you 2 Keys.",vc: self) { (result) in
                       if result {
                        let questionID = (point20Array[2] as AnyObject).value(forKey: "ques_id") as? Int
                        let taskcomplete =  (point20Array[2] as AnyObject).value(forKey: "task_completed") as? Int
                        self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "20",riddle_number: "2.2")

                       } else {
                       print("Cancel")
                       }
                   }

            }else if (point20Array[2] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                print("Zero1")
                let questionID = (point20Array[2] as AnyObject).value(forKey: "ques_id") as? Int
                let taskcomplete =  (point20Array[2] as AnyObject).value(forKey: "task_completed") as? Int
                self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "20",riddle_number: "2.3")

            }else if (point20Array[2] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                if (point20Array[2] as AnyObject).value(forKey: "is_correct") as? Int == 1{

                self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "2.3",riddlestype: "completed")

                }else{
                      let questionID = (point20Array[2] as AnyObject).value(forKey: "ques_id") as? Int
                                    let taskcomplete =  (point20Array[2] as AnyObject).value(forKey: "task_completed") as? Int
                                    self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "20",riddle_number: "2.3")
                }
            }else if (point20Array[2] as AnyObject).value(forKey: "task_completed") as? Int == 3{
//                let questionID = (point20Array[2] as AnyObject).value(forKey: "ques_id") as? Int
//                let taskcomplete =  (point20Array[2] as AnyObject).value(forKey: "task_completed") as? Int
//                self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "20",riddle_number: "2.3")
                self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "2.3",riddlestype: "abdandoned")

            }


            break
        case 107:
            if (point30Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 0{
            print("Zero")
                AskConfirmation(title: questintitle, message: "This action will cost you 3 Keys.",vc: self) { (result) in
                       if result {
                        let questionID = (point30Array[0] as AnyObject).value(forKey: "ques_id") as? Int
                        let taskcomplete =  (point30Array[0] as AnyObject).value(forKey: "task_completed") as? Int
                        self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "30",riddle_number: "3.1")

                       } else {
                       print("Cancel")
                       }
                   }

            }else if (point30Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                let questionID = (point30Array[0] as AnyObject).value(forKey: "ques_id") as? Int
                let taskcomplete =  (point30Array[0] as AnyObject).value(forKey: "task_completed") as? Int
                self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "30",riddle_number: "3.1")

            }else if (point30Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                if (point30Array[0] as AnyObject).value(forKey: "is_correct") as? Int == 1{

                self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "3.1",riddlestype: "completed")
                }else{
                    let questionID = (point30Array[0] as AnyObject).value(forKey: "ques_id") as? Int
                                    let taskcomplete =  (point30Array[0] as AnyObject).value(forKey: "task_completed") as? Int
                                    self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "30",riddle_number: "3.1")
                }
            }else if (point30Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 3{
//                let questionID = (point30Array[0] as AnyObject).value(forKey: "ques_id") as? Int
//                let taskcomplete =  (point30Array[0] as AnyObject).value(forKey: "task_completed") as? Int
//                self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "30",riddle_number: "3.1")
                self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "3.1",riddlestype: "abdandoned")


            }

            break
        case 108:
            if (point30Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 0{
                AskConfirmation(title: questintitle, message: "This action will cost you 3 Keys.",vc: self) { (result) in
                       if result {
                        let questionID = (point30Array[1] as AnyObject).value(forKey: "ques_id") as? Int
                        let taskcomplete =  (point30Array[1] as AnyObject).value(forKey: "task_completed") as? Int
                        self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "30",riddle_number: "3.2")

                       } else {
                       print("Cancel")
                       }
                   }

            }else if (point30Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                let questionID = (point30Array[1] as AnyObject).value(forKey: "ques_id") as? Int
                let taskcomplete =  (point30Array[1] as AnyObject).value(forKey: "task_completed") as? Int
                self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "30",riddle_number: "3.2")

            }else if (point30Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                if (point30Array[1] as AnyObject).value(forKey: "is_correct") as? Int == 1{

                self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "3.2",riddlestype: "completed")
                }else{
                    let questionID = (point30Array[1] as AnyObject).value(forKey: "ques_id") as? Int
                                    let taskcomplete =  (point30Array[1] as AnyObject).value(forKey: "task_completed") as? Int
                                    self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "30",riddle_number: "3.2")
                }
            }else if (point30Array[1] as AnyObject).value(forKey: "task_completed") as? Int == 3{
//                let questionID = (point30Array[1] as AnyObject).value(forKey: "ques_id") as? Int
//                let taskcomplete =  (point30Array[1] as AnyObject).value(forKey: "task_completed") as? Int
//                self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "30",riddle_number: "3.2")
                self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "3.2",riddlestype: "abdandoned")


            }

         break
         case 109:
            if (point40Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 0{
            print("Zero")
                AskConfirmation(title: questintitle, message: "This action will cost you 4 Keys.",vc: self) { (result) in
                       if result {
                        let questionID = (point40Array[0] as AnyObject).value(forKey: "ques_id") as? Int
                        let taskcomplete =  (point40Array[0] as AnyObject).value(forKey: "task_completed") as? Int
                        self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "40",riddle_number: "4")

                       } else {
                       print("Cancel")
                       }
                   }

            }else if (point40Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 1{
                
                let questionID = (point40Array[0] as AnyObject).value(forKey: "ques_id") as? Int
                let taskcomplete =  (point40Array[0] as AnyObject).value(forKey: "task_completed") as? Int
                self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "40",riddle_number: "4")

            }else if (point40Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 2{
                if (point40Array[0] as AnyObject).value(forKey: "is_correct") as? Int == 1{
                    self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "4",riddlestype: "completed")

                }else{
                let questionID = (point40Array[0] as AnyObject).value(forKey: "ques_id") as? Int
                    let taskcomplete =  (point40Array[0] as AnyObject).value(forKey: "task_completed") as? Int
                self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "40",riddle_number: "4")

                }

            }else if (point40Array[0] as AnyObject).value(forKey: "task_completed") as? Int == 3{
//                let questionID = (point40Array[0] as AnyObject).value(forKey: "ques_id") as? Int
//                let taskcomplete =  (point40Array[0] as AnyObject).value(forKey: "task_completed") as? Int
//                self.callnextClass(teamId: self.team_id, zoneId: self.zone_id, questionId: questionID!, taskcomplete: taskcomplete!, Points: "40",riddle_number: "4")
                self.completeviewcontrollerPush(teamname: self.teamnamelbl.text!, point: self.pointslbl.text!, token: self.tokenlbl.text!, zone: self.zonelbl.text!, completed_riddles: self.completeRiddle,riddle_number: "4",riddlestype: "abdandoned")
//

            }

         break

        default:
            break
        }

    }


    func callnextClass(teamId:Int,zoneId:Int,questionId:Int,taskcomplete:Int,Points:String,riddle_number:String){
        let objvc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionVC") as! QuestionVC
            objvc.team_id = teamId
        objvc.zone_id = zoneId
        objvc.points = Points
        objvc.ques_id = questionId
        objvc.task_completed = taskcomplete
        objvc.questionNumber = riddle_number
    self.navigationController?.pushViewController(objvc, animated: true)

    }


    func completeviewcontrollerPush(teamname:String,point:String,token:String,zone:String,completed_riddles:Int,riddle_number:String,riddlestype:String){

    let objvc = self.storyboard?.instantiateViewController(withIdentifier: "CompletedRiddlesVC") as! CompletedRiddlesVC
    objvc.point = point
    objvc.teamName = teamname
    objvc.riddle_complete = completed_riddles
    objvc.zonestr = zone
    objvc.tokenString = token
    objvc.completeRiddles = riddle_number
        objvc.abandonedRiddles = riddlestype
    self.navigationController?.pushViewController(objvc, animated: true)

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
/*@available(iOS 13.0, *)
extension ZoneRiddlesVC {

func AskConfirmation (title:String, message:String, completion:@escaping (_ result:Bool) -> Void) {
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
  }
}*/
