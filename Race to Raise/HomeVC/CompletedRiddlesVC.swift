//
//  CompletedRiddlesVC.swift
//  Race to Raise
//
//  Created by ozit solutions on 02/01/20.
//  Copyright © 2020 ozit solutions. All rights reserved.
//

import UIKit

class CompletedRiddlesVC: UIViewController {
    @IBOutlet weak var teamnamelbl: UILabel!
    @IBOutlet weak var pointLbl: UILabel!
    @IBOutlet weak var tokenLbl: UILabel!
    @IBOutlet weak var zoneLbl: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lblPercentage: UILabel!
    @IBOutlet weak var lblcompleteriddle: UILabel!
    @IBOutlet weak var checkimg: UIImageView!


    var point:String!
    var teamName:String!
    var tokenString:String!
    var riddle_complete:Int!
    var zonestr:String!
    var time : Float = 0.0
    var completeRiddles:String!
    var abandonedRiddles:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.title =  "Completed Riddles"
        self.navigationItem.hidesBackButton = true

        self.time += Float(riddle_complete)
        self.progressBar.setProgress(self.time/10, animated: true)
        let percentvalue = String(format: "%.0f", self.progressBar.progress*100)
        self.lblPercentage.text = "\(percentvalue)%"
        self.teamnamelbl.text = teamName
        self.pointLbl.text = point
        self.tokenLbl.text = tokenString
        self.zoneLbl.text = zonestr
        self.lblcompleteriddle.text = "Riddle \(completeRiddles!) completed!!"
        if abandonedRiddles == "abdandoned"{
            self.checkimg.image = UIImage(named: "close_white")
            self.lblcompleteriddle.text = "Riddle \(completeRiddles!) abdandoned!!"

        }else{
            self.checkimg.image = UIImage(named: "check")
            self.lblcompleteriddle.text = "Riddle \(completeRiddles!) completed!!"

        }
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



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
