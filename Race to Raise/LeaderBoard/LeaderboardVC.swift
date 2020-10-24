//
//  LeaderboardVC.swift
//  Race to Raise
//
//  Created by ozit solutions on 31/12/19.
//  Copyright © 2019 ozit solutions. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class LeaderboardVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var leadertableView: UITableView!
    var leaderboardlist = [[String:AnyObject]]()
    fileprivate var leaderboardAPI: GetResponseData!
   private var index:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.leaderboardAPI = GetResponseData()
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Leaderboard"
        self.navigationItem.hidesBackButton = true
        leadertableView.rowHeight = UITableView.automaticDimension
        leadertableView.estimatedRowHeight = 44

      leaderboardApiCall()
        // Do any additional setup after loading the view.
    }
    func leaderboardApiCall(){
        if InterNet.isConnectedToNetwork() == true {
        self.leaderboardAPI.getleaderBoardData{ (result, error) -> Void in
         // print("result--\(result)")
          let status = "\(result["status"]!)"
          if status == "1" {
               let dataArray = result["data"] as! NSArray

              for datalist in dataArray{
                  self.leaderboardlist.append(datalist as! [String : AnyObject])
               // self.index += 1
//                print("Index-\(self.index)")


              }
          }
          self.leadertableView.reloadData()
          }
        }else{
            KAppDelegate.showAlertNotification(noInterNetConnection)
        }

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return leaderboardlist.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderCell", for: indexPath) as! LeaderCell
        cell.selectionStyle = .none
        let item = leaderboardlist[indexPath.row]
       // let name = item["team_name"] as? String
        if let name = item["team_name"] as? String{
            self.index = (indexPath.row) + 1
            cell.teamNamelbl.text = "\(self.index). Team \(name)"

        }

        //let teamId = item["id"] as? Int
        if let point = item["points"] as? String{
         cell.pointlbl.text = "Points:\(point)"
        }else{
            cell.pointlbl.text = "Points:0"

        }



        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = leaderboardlist[indexPath.row]
        let objvc = storyboard?.instantiateViewController(withIdentifier: "LeaderboardDetailVC") as! LeaderboardDetailVC
        objvc.teamId = item["id"] as? Int
        objvc.titleStr = (item["team_name"] as? String)!
        self.navigationController?.pushViewController(objvc, animated: true)

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
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
