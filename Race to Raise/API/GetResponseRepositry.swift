//
//  GetResponseRepositry.swift
//  Status U See
//
//  Created by ozit solutions on 13/12/19.
//  Copyright © 2019 ozit solutions. All rights reserved.
//
//

import Foundation
import UIKit

class GetResponseRepositry{
    fileprivate let regiser_Api = "register"
    fileprivate let loginApi = "login"
     fileprivate let forgotPassword = "forgot-password"
    fileprivate let verify_otp = "verify-otp"
    fileprivate let change_password = "change-password"
    fileprivate let available_zones = "available-zones"
    fileprivate let zone_riddles = "zone-riddles"
    fileprivate let get_riddles = "get-riddle"
    fileprivate let submit_riddle = "submit-riddle"
    fileprivate let submit_abandoned = "submit-abandoned"
    fileprivate let get_hint = "get-hint"
     fileprivate let user_profile = "get-user-profile"
    fileprivate let leaderboard = "get-leaderboard"
    fileprivate let team_members = "get-team-members"
    fileprivate let update_password = "update-password"
    fileprivate let update_user_profile = "update-user-profile"
    fileprivate let  submit_feedback = "submit-feedback"
    fileprivate let logout = "logout"
    fileprivate var remoteRepo:RemoteRepository!
    
    init(){
        self.remoteRepo = RemoteRepository()
    }

    //Logout Get Api
    func getlogOutDetail(_ callback:@escaping (_ response:Dictionary<String, AnyObject>?, _ error:NSError?) -> Void){
        remoteRepo.remoteGETConfigFromServiceWithHeader(logout){(data,error) -> Void in
            callback(data, error)
        }
    }

    //Get leaderboard list
    func getLeaderBoardData(_ callback:@escaping (_ response:Dictionary<String, AnyObject>?, _ error:NSError?) -> Void){
        remoteRepo.remoteGETConfigFromServiceWithHeader(leaderboard){(data,error) -> Void in
            callback(data, error)
        }
    }
    //Post Feedback
    func postsebmit_feedbackDataOnServer(_ userDetails:Dictionary<String,String>, callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void ) {
        remoteRepo.remoteGroupPostServiceWithoutHeader(submit_feedback, params: userDetails) { (data,error) -> Void in
            callback(data, error)
        }
    }
// post hint
    func postsHintDataOnServer(_ userDetails:Dictionary<String,String>, callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void ) {
        remoteRepo.remoteGroupPostServiceWithoutHeader(get_hint, params: userDetails) { (data,error) -> Void in
            callback(data, error)
        }
    }

     //Post team-member
    func postTeam_MemberDataOnServer(_ userDetails:Dictionary<String,String>, callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void ) {
        remoteRepo.remoteGroupPostServiceWithoutHeader(team_members, params: userDetails) { (data,error) -> Void in
            callback(data, error)
        }
    }
    //Post get-riddle
    func postget_riddleDataOnServer(_ userDetails:Dictionary<String,String>, callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void ) {
        remoteRepo.remoteGroupPostServiceWithoutHeader(get_riddles, params: userDetails) { (data,error) -> Void in
            callback(data, error)
        }
    }

    //Get available-zones list

    func getAviable_zoneData(_ callback:@escaping (_ response:Dictionary<String, AnyObject>?, _ error:NSError?) -> Void){
        remoteRepo.remoteGETConfigFromServiceWithHeader(available_zones){(data,error) -> Void in
            callback(data, error)
        }
    }
    //post submit Riddle
    func postsubmit_riddleDataOnServer(_ userDetails:Dictionary<String,String>, callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void ) {
        remoteRepo.remoteGroupPostServiceWithoutHeader(submit_riddle, params: userDetails) { (data,error) -> Void in
            callback(data, error)
        }
    }
    //post submit abandoned
    func postsubmit_abandonedDataOnServer(_ userDetails:Dictionary<String,String>, callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void ) {
        remoteRepo.remoteGroupPostServiceWithoutHeader(submit_abandoned, params: userDetails) { (data,error) -> Void in
            callback(data, error)
        }
    }


//update password
     func postprofileUpdatePasswordDataOnServer(_ userDetails:Dictionary<String,String>, callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void ) {
         remoteRepo.remoteGroupPostServiceWithoutHeader(update_password, params: userDetails) { (data,error) -> Void in
             callback(data, error)
         }
     }
    // update_user_profile

    func postupdate_user_profileDataOnServer(_ userDetails:Dictionary<String,String>, callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void ) {
        remoteRepo.remoteGroupPostServiceWithoutHeader(update_user_profile, params: userDetails) { (data,error) -> Void in
            callback(data, error)
        }
    }
//update profile image
    func postupdate_user_profilePictureDataOnServer(_ userDetails:Dictionary<String,Any> , _ profileImg : String!, _ imageFileName : String!, _ selectedImg : UIImage!, callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void ) {
        remoteRepo.postImageServiceWithParametersHeader(update_user_profile, profileImg, imageFileName, params: userDetails,selectedImg) { (data,error) -> Void in
            callback(data, error)
        }
    }


    //Post Register
    func postRegisterDataOnServer(_ userDetails:Dictionary<String,String>, callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void ) {
        remoteRepo.remotePostServiceWithoutHeader(regiser_Api, params: userDetails) { (data,error) -> Void in
            callback(data, error)
        }
    }
     //Login
    func postLoginDataOnServer(_ userDetails:Dictionary<String,String>, callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void ) {
        remoteRepo.remotePostServiceWithoutHeader(loginApi, params: userDetails) { (data,error) -> Void in
            callback(data, error)
        }
    }
   //Forgot Post
    func postForgotPasswordDataOnServer(_ userDetails:Dictionary<String,String>, callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void ) {
        remoteRepo.remotePostServiceWithoutHeader(forgotPassword, params: userDetails) { (data,error) -> Void in
            callback(data, error)
        }
    }
    //Verify Otp
    func postVerifyOTPDataOnServer(_ userDetails:Dictionary<String,String>, callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void ) {
        remoteRepo.remotePostServiceWithoutHeader(verify_otp, params: userDetails) { (data,error) -> Void in
            callback(data, error)
        }
    }
//Change Password
    func postChangePasswordDataOnServer(_ userDetails:Dictionary<String,String>, callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void ) {
        remoteRepo.remotePostServiceWithoutHeader(change_password, params: userDetails) { (data,error) -> Void in
            callback(data, error)
        }
    }

    //zone_riddles
    func postzone_riddlesDataOnServer(_ userDetails:Dictionary<String,String>, callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void ) {
        remoteRepo.remoteGroupPostServiceWithoutHeader(zone_riddles, params: userDetails) { (data,error) -> Void in
            callback(data, error)
        }
    }

//Get--Profile
    func getProfileData(_ callback:@escaping (_ response:Dictionary<String, AnyObject>?, _ error:NSError?) -> Void){
        remoteRepo.remoteGETConfigFromServiceWithHeader(user_profile){(data,error) -> Void in
            callback(data, error)
        }
    }




}

