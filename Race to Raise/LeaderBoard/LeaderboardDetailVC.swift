//
//  LeaderboardDetailVC.swift
//  Race to Raise
//
//  Created by  ozit solutions on 31/12/19.
//  Copyright © 2019 ozit solutions. All rights reserved.
//

import UIKit
import SDWebImage

@available(iOS 13.0, *)
class LeaderboardDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
@IBOutlet weak var leadertableView: UITableView!
    var leamleaderlist = [[String:AnyObject]]()
    fileprivate var leamMemberdAPI: GetResponseData!

    var teamId:Int!
    var titleStr:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leamMemberdAPI = GetResponseData()
        self.navigationController?.navigationBar.isHidden = false
        self.title = titleStr
        self.navigationItem.hidesBackButton = true
        leadertableView.rowHeight = UITableView.automaticDimension
        leadertableView.estimatedRowHeight = 80

       teammemberCallApi()
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
    func teammemberCallApi(){
        if InterNet.isConnectedToNetwork() == true {
        var teammemberDetials: Dictionary<String,String>
        teammemberDetials = ["team_id":String(teamId)]
        leamMemberdAPI.postTeamMemberDataOnServer(teammemberDetials){ (result, error) -> Void in
            //print("result--\(result)")
            let status = "\(result["status"]!)"
            if status == "1" {
                     let dataArray = result["data"] as! NSArray

                    for datalist in dataArray{
                        self.leamleaderlist.append(datalist as! [String : AnyObject])
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

        return leamleaderlist.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderDetailCell", for: indexPath) as! LeaderDetailCell
        cell.selectionStyle = .none
        let item = leamleaderlist[indexPath.row]
        cell.fullnamelbl.text = item["full_name"] as? String
       // let imgString = item["profile_image"] as! String
        cell.imgProfile.layer.masksToBounds = false
        cell.imgProfile.layer.cornerRadius = cell.imgProfile.frame.size.height/2
        cell.imgProfile.clipsToBounds = true

        if let imageString = item["profile_image"] as? String{
            cell.imgProfile.sd_setImage(with: URL(string:baseConstants.profilebaseUrl + imageString), placeholderImage: UIImage(named: "placeholder"))

        }


        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

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
