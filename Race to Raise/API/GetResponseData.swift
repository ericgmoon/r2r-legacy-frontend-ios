//
//  GetResponseData.swift
//  Status U See
//
//  Created by ozit solutions on 13/12/19.
//  Copyright © 2019 ozit solutions. All rights reserved.
//
//

import Foundation
import UIKit
import RappleProgressHUD
//import SVProgressHUD

@available(iOS 13.0, *)
class GetResponseData{
    fileprivate let getRemoteReplicator:GetResponseRepositry!
    
    init() {
        
        self.getRemoteReplicator = GetResponseRepositry()
    }

    //logout
    func getlogoutDataForm(callback:@escaping (_ result:Dictionary<String,AnyObject>,_ error:NSError?) -> Void){
        RappleActivityIndicatorView.startAnimating()

        getRemoteReplicator.getlogOutDetail(){(data,error) -> Void in
            if data != nil{
                let status = "\(data!["message"]!)"
                if status == "Successfully logged out"{
                    callback(data!, nil)
                }else{
                   // KAppDelegate.showNotification("Something went wrong.")
                    callback(data!,error)
                }
            }
            RappleActivityIndicatorView.stopAnimation()
        }
    }


    //Get profile

    func getUser_profileData(callback:@escaping (_ result:Dictionary<String,AnyObject>,_ error:NSError?) -> Void){
        RappleActivityIndicatorView.startAnimating()
        getRemoteReplicator.getProfileData(){(data,error) -> Void in
            if data != nil{
                let status = "\(data!["status"]!)"
                if status == "1"{
                    callback(data!, nil)
                }else{
                   // KAppDelegate.showNotification("Something went wrong.")
                    callback(data!,error)
                }
            }
            RappleActivityIndicatorView.stopAnimation()
        }
    }

    //leaderBoard
    func getleaderBoardData(callback:@escaping (_ result:Dictionary<String,AnyObject>,_ error:NSError?) -> Void){
        RappleActivityIndicatorView.startAnimating()
        getRemoteReplicator.getLeaderBoardData(){(data,error) -> Void in
            if data != nil{
                let status = "\(data!["status"]!)"
                if status == "1"{
                    callback(data!, nil)
                }else{
                   // KAppDelegate.showNotification("Something went wrong.")
                    callback(data!,error)
                }
            }
            RappleActivityIndicatorView.stopAnimation()
        }
    }

    //postsebmit_feedbackDataOnServer
    func postSubmit_feedbackDataOnServer(_ userProfileDict: Dictionary<String, String> , callback:@escaping (_ result:Dictionary<String,AnyObject>, _ error: NSError? ) -> Void) {
        RappleActivityIndicatorView.startAnimating()
           getRemoteReplicator.postsebmit_feedbackDataOnServer(userProfileDict) { (data, error) -> Void in
               if data != nil{
                   let status = "\((data as AnyObject).value(forKey: "status")!)"
                   if status == "1"{
                    callback(data!, nil)
                   }else{
                    KAppDelegate.showAlertNotification("\((data as AnyObject).value(forKey: "message")!)")
                    callback(data!, nil)
                   }
               }else{
                   let errorMsg = error?.localizedDescription ?? "The request timed out."
                   KAppDelegate.showAlertNotification(errorMsg)
               }
              RappleActivityIndicatorView.stopAnimation()
           }
       }
//postsHintDataOnServer
    func postHintDataOnServer(_ userProfileDict: Dictionary<String, String> , callback:@escaping (_ result:Dictionary<String,AnyObject>, _ error: NSError? ) -> Void) {
        RappleActivityIndicatorView.startAnimating()
           getRemoteReplicator.postsHintDataOnServer(userProfileDict) { (data, error) -> Void in
               if data != nil{
                   let status = "\((data as AnyObject).value(forKey: "status")!)"
                   if status == "1"{
                    callback(data!, nil)
                   }else{
                    KAppDelegate.showAlertNotification("\((data as AnyObject).value(forKey: "message")!)")
                    callback(data!, nil)
                   }
               }else{
                   let errorMsg = error?.localizedDescription ?? "The request timed out."
                   KAppDelegate.showAlertNotification(errorMsg)
               }
              RappleActivityIndicatorView.stopAnimation()
           }
       }



    //postTeam_MemberDataOnServer
    func postTeamMemberDataOnServer(_ userProfileDict: Dictionary<String, String> , callback:@escaping (_ result:Dictionary<String,AnyObject>, _ error: NSError? ) -> Void) {
        RappleActivityIndicatorView.startAnimating()
           getRemoteReplicator.postTeam_MemberDataOnServer(userProfileDict) { (data, error) -> Void in
               if data != nil{
                   let status = "\((data as AnyObject).value(forKey: "status")!)"
                   if status == "1"{
                    callback(data!, nil)
                   }else{
                    KAppDelegate.showAlertNotification("\((data as AnyObject).value(forKey: "message")!)")
                    callback(data!, nil)
                   }
               }else{
                   let errorMsg = error?.localizedDescription ?? "The request timed out."
                   KAppDelegate.showAlertNotification(errorMsg)
               }
              RappleActivityIndicatorView.stopAnimation()
           }
       }

//Get riddles

    func postget_riddleDataOnServerDataOnServer(_ userProfileDict: Dictionary<String, String> , callback:@escaping (_ result:Dictionary<String,AnyObject>, _ error: NSError? ) -> Void) {
        RappleActivityIndicatorView.startAnimating()
           getRemoteReplicator.postget_riddleDataOnServer(userProfileDict) { (data, error) -> Void in
               if data != nil{
                   let status = "\((data as AnyObject).value(forKey: "status")!)"
                   if status == "1"{
                    callback(data!, nil)
                   }else{
                    KAppDelegate.showAlertNotification("\((data as AnyObject).value(forKey: "message")!)")
                    callback(data!, nil)
                   }
               }else{
                   let errorMsg = error?.localizedDescription ?? "The request timed out."
                   KAppDelegate.showAlertNotification(errorMsg)
               }
              RappleActivityIndicatorView.stopAnimation()
           }
       }

    func getAviable_zonetData(callback:@escaping (_ result:Dictionary<String,AnyObject>,_ error:NSError?) -> Void){
      //  RappleActivityIndicatorView.startAnimating()
        getRemoteReplicator.getAviable_zoneData(){(data,error) -> Void in
            if data != nil{
                let status = "\(data!["status"]!)"
                if status == "1"{
                    callback(data!, nil)
                }else{
                   // KAppDelegate.showNotification("Something went wrong.")
                    callback(data!,error)
                }
            }
            //RappleActivityIndicatorView.stopAnimation()
        }
    }
//submit Riddle
    func postSubmit_riddleDataOnServerDataOnServer(_ userProfileDict: Dictionary<String, String> , callback:@escaping (_ successResponse: Bool, _ error: NSError? ) -> Void) {

        RappleActivityIndicatorView.startAnimating()
           getRemoteReplicator.postsubmit_riddleDataOnServer(userProfileDict) { (data, error) -> Void in
               if data != nil{
                   let status = "\((data as AnyObject).value(forKey: "status")!)"
                   if status == "1" || status == "2"{
                    callback(true, nil)
                   }else{
                    KAppDelegate.showAlertNotification("\((data as AnyObject).value(forKey: "message")!)")
                    callback(false, nil)
                   }
               }else{
                   let errorMsg = error?.localizedDescription ?? "The request timed out."
                   KAppDelegate.showAlertNotification(errorMsg)
               }
              RappleActivityIndicatorView.stopAnimation()
           }
       }
//postsubmit_abandonedDataOnServer
    func postSubmit_abandonedDataOnServerDataOnServer(_ userProfileDict: Dictionary<String, String> , callback:@escaping (_ successResponse: Bool, _ error: NSError? ) -> Void) {

        RappleActivityIndicatorView.startAnimating()
           getRemoteReplicator.postsubmit_abandonedDataOnServer(userProfileDict) { (data, error) -> Void in
               if data != nil{
                   let status = "\((data as AnyObject).value(forKey: "status")!)"
                   if status == "1"{
                    callback(true, nil)
                   }else{
                    KAppDelegate.showAlertNotification("\((data as AnyObject).value(forKey: "message")!)")
                    callback(false, nil)
                   }
               }else{
                   let errorMsg = error?.localizedDescription ?? "The request timed out."
                   KAppDelegate.showAlertNotification(errorMsg)
               }
              RappleActivityIndicatorView.stopAnimation()
           }
       }


///Post Methods Register
 func postRegisetDataOnServer(_ userProfileDict: Dictionary<String, String> , callback:@escaping (_ successResponse: Bool, _ error: NSError? ) -> Void) {
    RappleActivityIndicatorView.startAnimating()

        getRemoteReplicator.postRegisterDataOnServer(userProfileDict) { (data, error) -> Void in
            if data != nil{

             //   print("data--\(data!)")
                let status = "\((data as AnyObject).value(forKey: "status")!)"
                if status == "1"{

                    callback(true, nil)
                }else{
                    KAppDelegate.showAlertNotification(data!["message"] as! String)
                    callback(false, nil)
                }
            }else{
                let errorMsg = error?.localizedDescription ?? "The request timed out."
                KAppDelegate.showAlertNotification(errorMsg)
            }
            RappleActivityIndicatorView.stopAnimating()

        }
    }



//Login Api

 func postLoginDataOnServer(_ userProfileDict: Dictionary<String, String> , callback:@escaping (_ successResponse: Bool, _ error: NSError? ) -> Void) {
    RappleActivityIndicatorView.startAnimating()

        getRemoteReplicator.postLoginDataOnServer(userProfileDict) { (data, error) -> Void in
            if data != nil{
                var status = ""
                if (data as AnyObject).value(forKey: "status") != nil {
                    status = "\((data as AnyObject).value(forKey: "status")!)"

                }// let status = "\((data as AnyObject).value(forKey: "status")!)"
                if status == "1"{
            baseConstants.kUserDefaults.setValue( "Bearer \((data as AnyObject).value(forKey: "access_token")!)", forKey: "AuthToken")
            baseConstants.kUserDefaults.setValue( "\((data as AnyObject).value(forKey: "token_type")!)", forKey: "token_type")


                    callback(true, nil)
                }else{
                   KAppDelegate.showAlertNotification("\((data as AnyObject).value(forKey: "error")!)")
                    callback(false, nil)
                }
            }else{
                let errorMsg = error?.localizedDescription ?? "The request timed out."
                KAppDelegate.showAlertNotification(errorMsg)
            }
            RappleActivityIndicatorView.stopAnimation()

        }
    }
//update password

    func postupdatePasswordDataOnServer(_ userProfileDict: Dictionary<String, String> , callback:@escaping (_ successResponse: Bool, _ error: NSError? ) -> Void) {
        RappleActivityIndicatorView.startAnimating()

           getRemoteReplicator.postprofileUpdatePasswordDataOnServer(userProfileDict) { (data, error) -> Void in
               if data != nil{
                   let status = "\((data as AnyObject).value(forKey: "status")!)"

                   if status == "1"{
                  //  UserDefaults.standard.set("\((data as AnyObject).value(forKey: "id")!)", forKey: "userID")

                       callback(true, nil)
                   }else{
                      KAppDelegate.showAlertNotification("\((data as AnyObject).value(forKey: "message")!)")
                       callback(false, nil)
                   }
               }else{
                   let errorMsg = error?.localizedDescription ?? "The request timed out."
                   KAppDelegate.showAlertNotification(errorMsg)
               }
              RappleActivityIndicatorView.stopAnimation()
           }
       }

    //update-user-profile

    func post_update_user_profileDataOnServer(_ userProfileDict: Dictionary<String, String> , callback:@escaping (_ successResponse: Bool, _ error: NSError? ) -> Void) {
        RappleActivityIndicatorView.startAnimating()

           getRemoteReplicator.postupdate_user_profileDataOnServer(userProfileDict) { (data, error) -> Void in
               if data != nil{
                   let status = "\((data as AnyObject).value(forKey: "status")!)"

                   if status == "1"{
                  //  UserDefaults.standard.set("\((data as AnyObject).value(forKey: "id")!)", forKey: "userID")

                       callback(true, nil)
                   }else{
                      KAppDelegate.showAlertNotification("\((data as AnyObject).value(forKey: "message")!)")
                       callback(false, nil)
                   }
               }else{
                   let errorMsg = error?.localizedDescription ?? "The request timed out."
                   KAppDelegate.showAlertNotification(errorMsg)
               }
              RappleActivityIndicatorView.stopAnimation()
           }
       }
//postupdate_user_profilePicture

    func postupdate_user_profilePictureDataOnServer(_ userProfileDict: Dictionary<String, Any> ,_ imageKey : String!,_ imageFileName : String!, _ selectedImg : UIImage!, callback:@escaping (_ successResponse: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void) {
        RappleActivityIndicatorView.startAnimating()
        getRemoteReplicator.postupdate_user_profilePictureDataOnServer(userProfileDict, imageKey, imageFileName,selectedImg) { (data, error) -> Void in
            if data != nil{
                let status = "\((data as AnyObject).value(forKey: "status")!)"
                if status == "1" {
                    callback(data, nil)
                }else{
                   // KAppDelegate.showNotification("Something went wrong.")
                }
            }
            RappleActivityIndicatorView.stopAnimation()
        }
    }

    //Forget Method

    func postForgetDataOnServer(_ userProfileDict: Dictionary<String, String> , callback:@escaping (_ successResponse: Bool, _ error: NSError? ) -> Void) {
        RappleActivityIndicatorView.startAnimating()

           getRemoteReplicator.postForgotPasswordDataOnServer(userProfileDict) { (data, error) -> Void in
               if data != nil{
                   let status = "\((data as AnyObject).value(forKey: "status")!)"

                   if status == "1"{
                    UserDefaults.standard.set("\((data as AnyObject).value(forKey: "id")!)", forKey: "userID")

                       callback(true, nil)
                   }else{
                      KAppDelegate.showAlertNotification("\((data as AnyObject).value(forKey: "message")!)")
                       callback(false, nil)
                   }
               }else{
                   let errorMsg = error?.localizedDescription ?? "The request timed out."
                   KAppDelegate.showAlertNotification(errorMsg)
               }
              RappleActivityIndicatorView.stopAnimation()
           }
       }
//Verify OTP
    func postVerifyOTPDataOnServer(_ userProfileDict: Dictionary<String, String> , callback:@escaping (_ successResponse: Bool, _ error: NSError? ) -> Void) {
     RappleActivityIndicatorView.startAnimating()

        getRemoteReplicator.postVerifyOTPDataOnServer(userProfileDict) { (data, error) -> Void in
            if data != nil{
                let status = "\((data as AnyObject).value(forKey: "status")!)"
                if status == "1"{


                    callback(true, nil)
                }else{
                   KAppDelegate.showAlertNotification("\((data as AnyObject).value(forKey: "message")!)")
                    callback(false, nil)
                }
            }else{
                let errorMsg = error?.localizedDescription ?? "The request timed out."
                KAppDelegate.showAlertNotification(errorMsg)
            }
           RappleActivityIndicatorView.stopAnimation()
        }
    }

    //Change password
    func postchangePasswordDataOnServer(_ userchangepasswordDict: Dictionary<String, String> , callback:@escaping (_ successResponse: Bool, _ error: NSError? ) -> Void) {
     RappleActivityIndicatorView.startAnimating()

        getRemoteReplicator.postChangePasswordDataOnServer(userchangepasswordDict) { (data, error) -> Void in
            if data != nil{
                let status = "\((data as AnyObject).value(forKey: "status")!)"
                if status == "1"{


                    callback(true, nil)
                }else{
                   KAppDelegate.showAlertNotification("\((data as AnyObject).value(forKey: "message")!)")
                    callback(false, nil)
                }
            }else{
                let errorMsg = error?.localizedDescription ?? "The request timed out."
                KAppDelegate.showAlertNotification(errorMsg)
            }
           RappleActivityIndicatorView.stopAnimation()
        }
    }




//Zone_Riddles

    func postZoneRidersDataOnServer(_ userProfileDict: Dictionary<String, String> , callback:@escaping (_ result:Dictionary<String,AnyObject>, _ error: NSError? ) -> Void) {
        RappleActivityIndicatorView.startAnimating()
           getRemoteReplicator.postzone_riddlesDataOnServer(userProfileDict) { (data, error) -> Void in
               if data != nil{
                   let status = "\((data as AnyObject).value(forKey: "status")!)"
                   if status == "1"{
                    callback(data!, nil)
                   }else{
                    KAppDelegate.showAlertNotification("\((data as AnyObject).value(forKey: "message")!)")
                    callback(data!, nil)
                   }
               }else{
                   let errorMsg = error?.localizedDescription ?? "The request timed out."
                   KAppDelegate.showAlertNotification(errorMsg)
               }
              RappleActivityIndicatorView.stopAnimation()
           }
       }

}
