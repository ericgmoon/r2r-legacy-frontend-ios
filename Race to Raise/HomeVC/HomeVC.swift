//
//  HomeVC.swift
//  Race to Raise
//
//  Created by ozit solutions on 31/12/19.
//  Copyright © 2019 ozit solutions. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class HomeVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
   @IBOutlet weak var hometableView: UITableView!
    @IBOutlet weak var teamnamelbl: UILabel!
    @IBOutlet weak var pointLbl: UILabel!
    @IBOutlet weak var tokenLbl: UILabel!
    var aviablezonelist = [[String:AnyObject]]()
    fileprivate var aviableZoneAPI: GetResponseData!
    var time : Float!// = 0.0


    override func viewDidLoad() {
        super.viewDidLoad()
        self.aviableZoneAPI = GetResponseData()

        self.navigationController?.navigationBar.isHidden = false
        self.title = "Available Zones"
        self.navigationItem.hidesBackButton = true
        hometableView.rowHeight = UITableView.automaticDimension
        hometableView.estimatedRowHeight = 200
        callForAviable_zoneApi()

        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedNotificationForTab(notification:)), name: Notification.Name("NextControllerForTab"), object: nil)
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
    //  callForAviable_zoneApi()
    }

    func callForAviable_zoneApi() {
        self.aviablezonelist.removeAll()
        if InterNet.isConnectedToNetwork() == true {
          self.aviableZoneAPI.getAviable_zonetData{ (result, error) -> Void in
          //  print("result--\(result)")
            let status = "\(result["status"]!)"
            if status == "1" {
                 let dict = result["data"] as! NSDictionary
                //print("data--\(dict)")
                let teamname = dict["team_name"] as! String
                if let total_points = (dict as AnyObject).value(forKey: "total_points") as? String{
                    self.pointLbl.text = "Points:\(total_points)"
                }
                let total_tokens = dict["total_tokens"] as! NSNumber
                let teamzoneArray = dict["team_zones"] as! NSArray
                self.teamnamelbl.text = teamname
                self.tokenLbl.text = "Keys:\(total_tokens)"

                for datalist in teamzoneArray{
                    self.aviablezonelist.append(datalist as! [String : AnyObject])

                }
            }
            self.hometableView.reloadData()
            }
        }else{
            KAppDelegate.showAlertNotification(noInterNetConnection)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return aviablezonelist.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.selectionStyle = .none
         let item = aviablezonelist[indexPath.row]
         time = 0.0
         cell.progressBar.setProgress(0.0, animated: true)

         cell.zonelbl.text = item["zone_name"] as? String
        if let completeRiddles = item["completed_riddles"] as? Int{
            cell.riddleslbl.text = "Riddles completed:\(completeRiddles)/10"

        }
        if let points = item["points"] as? String{
            cell.pointlbl.text = "Points Recevied:\(points)/200"

        }
         let value = (item["completed_riddles"] as? Int)!
         time += Float(value)
         cell.progressBar.setProgress(time/10, animated: true)
         let percentvalue = String(format: "%.0f", cell.progressBar.progress*100)
        print(String(format: "%.0f", cell.progressBar.progress*100))
         cell.percentagelbl.text = "\(percentvalue)%"
        cell.continueBtn.tag = indexPath.row
        cell.continueBtn.addTarget(self, action: #selector(HomeVC.ContinueBTNAction(_:)), for: .touchUpInside)


        return cell
    }
    @objc func ContinueBTNAction(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
       let zoneitem = aviablezonelist[indexPath.row]
        let objvc = storyboard?.instantiateViewController(withIdentifier: "ZoneRiddlesVC") as! ZoneRiddlesVC

        if let points = zoneitem["points"] as? String{
          //  print("points---\(points)")
            objvc.points = points

        }
        objvc.zone_id = zoneitem["zone_id"] as? Int
        objvc.team_id = zoneitem["team_id"] as? Int
        self.navigationController?.pushViewController(objvc, animated: true)


    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let objvc = storyboard?.instantiateViewController(withIdentifier: "ZoneRiddlesVC") as! ZoneRiddlesVC
//        self.navigationController?.pushViewController(objvc, animated: true)

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
