//
//  MyProfileVC.swift
//  Race to Raise
//
//  Created by ozit solutions on 31/12/19.
//  Copyright © 2019 ozit solutions. All rights reserved.
//

import UIKit
import SDWebImage

@available(iOS 13.0, *)
class MyProfileVC: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emaillbl: UILabel!
    @IBOutlet weak var pointlbl: UILabel!
    @IBOutlet weak var tokenlbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    fileprivate var userProfileApi:GetResponseData!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.userProfileApi = GetResponseData()
        self.navigationController?.navigationBar.isHidden = false
        self.title = "My Profile"
        self.navigationItem.hidesBackButton = true
        profileImg.layer.masksToBounds = false
        profileImg.layer.cornerRadius = profileImg.frame.size.height/2
        profileImg.clipsToBounds = true

        getprofileApiCall()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.hidesBackButton = true

        let rightbutton = UIButton.init(type: .custom)
        rightbutton.setImage(UIImage.init(named: "logout"), for: .normal)
        rightbutton.addTarget(self, action:#selector(logoutButtonAction), for:.touchUpInside)
        rightbutton.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        let barRightButton = UIBarButtonItem.init(customView: rightbutton)
        self.navigationItem.rightBarButtonItem = barRightButton


    }

    @objc func logoutButtonAction(){

        self.userProfileApi.getlogoutDataForm{ (result, error) -> Void in
        //  print("result--\(result)")
            let status = "\(result["message"]!)"
            if status == "Successfully logged out" {
                UserDefaults.standard.set(false, forKey: "IsLogin")
                self.navigationController?.navigationBar.isHidden = true
                if #available(iOS 13, *) {
                    senceSwitcher.updateRootVC()

                }else{
                Switcher.updateRootVC()
                }
              // self.navigationController?.popToRootViewController(animated: true)




            }
        }
    }
    func getprofileApiCall(){
        if InterNet.isConnectedToNetwork() == true {
        self.userProfileApi.getUser_profileData{ (result, error) -> Void in
          //print("result--\(result)")
          let status = "\(result["status"]!)"
          if status == "1" {
            let dict = result["user"] as! NSDictionary
            self.nameField.text = dict["full_name"] as? String
            self.emaillbl.text = dict["email"] as? String
            if let point = dict["total_points"] as? String{
                self.pointlbl.text = "Points \(point)"
            }
            let token = dict["total_tokens"] as? Int
            self.tokenlbl.text = "Keys:\(token!)"
            if let imageString = dict["profile_image"] as? String{
                self.profileImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
                self.profileImg.sd_setImage(with: URL(string:baseConstants.profilebaseUrl + imageString), placeholderImage: UIImage(named: "placeholder"))

            }
            }
        }
        }else{
            KAppDelegate.showAlertNotification(noInterNetConnection)
        }

    }
    @IBAction func cameraBtn(sender:Any){
        let alert = UIAlertController(title: "Select Image From", message: "", preferredStyle: .actionSheet)
                  alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
                      let imagePickerController=UIImagePickerController()
                      imagePickerController.delegate = self
                      imagePickerController.sourceType = .camera
                      imagePickerController.cameraCaptureMode = .photo
                      imagePickerController.cameraDevice = .front
                      //self.present(imagePickerController, animated: true, completion: nil)
                      self.view.window!.rootViewController?.present(imagePickerController, animated: true, completion: nil)
                  }))

                  alert.addAction(UIAlertAction(title: "Gallery", style: .default , handler:{ (UIAlertAction)in
                      let imagePickerController=UIImagePickerController()
                      imagePickerController.delegate = self
                      imagePickerController.sourceType =  UIImagePickerController.SourceType.photoLibrary
                      self.view.window!.rootViewController?.present(imagePickerController, animated: true, completion: nil)
                  }))
                  alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
                      //print("User click Dismiss button")
                  }))
                  self.present(alert, animated: true, completion: {
                      //print("completion block")
                  })
    }
       func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           let image = info[.originalImage] as! UIImage
           profileImg.image = image
           let pngImage = profileImg.image!.jpegData(compressionQuality: 0.8)
           UserDefaults.standard.set(pngImage, forKey: "profilePic")
           picker.dismiss(animated: true, completion: nil)
            updateprofilePicture()

       }
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func editButtonBtn(sender:Any){
        if let button = sender as? UIButton {
            if button.isSelected {
                print("deselected")
                let img = UIImage(named: "edit")
                button.setImage(img, for: .normal)
                button.isSelected = false
                self.nameField.isUserInteractionEnabled = false
                self.nameField.backgroundColor = UIColor.clear

               userprofileUpdate()
            } else {
                // set selected
                print("selected")
                self.nameField.isUserInteractionEnabled = true
                self.nameField.backgroundColor = grayColor
                let img = UIImage(named: "verified")
                button.setImage(img, for: .normal)
                button.isSelected = true
            }
        }

    }
    func userprofileUpdate(){
        if InterNet.isConnectedToNetwork() == true {
        var updateDetials: Dictionary<String,String>
        updateDetials = ["full_name":nameField.text!]
        userProfileApi.post_update_user_profileDataOnServer(updateDetials){ (isSuccess, error) -> Void in
            if(isSuccess){
                print("SUCESSS")
                //self.navigationController?.popViewController(animated: true)

            }
        }
        }else{
            KAppDelegate.showAlertNotification(noInterNetConnection)
        }

    }
    func updateprofilePicture(){
        if InterNet.isConnectedToNetwork() == true {

        let imageKey = "profile_image"
        let imgFileName = "update-profile.png"
        let selectedImg = UserDefaults.standard.object(forKey: "profilePic") as AnyObject
        let uploadedAttImg = UIImage(data: (selectedImg as! NSData) as Data)

        var profileDict: Dictionary<String,Any>
        profileDict = ["full_name":""]
        userProfileApi.postupdate_user_profilePictureDataOnServer(profileDict,imageKey, imgFileName,uploadedAttImg){ (result, error) -> Void in
        let status = "\(result!["status"]!)"
            if status == "1" {
            print("sucess")
                self.getprofileApiCall()

        }

        }
        }else{
            KAppDelegate.showAlertNotification(noInterNetConnection)
        }
    }

    @IBAction func changepasswordBtn(sender:Any){
        let objvc = storyboard?.instantiateViewController(withIdentifier: "UpdateProfileVC") as! UpdateProfileVC
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
