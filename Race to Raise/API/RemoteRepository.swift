//
//  RemoteRepository.swift
//  Status U See
//
//  Created by ozit solutions on 13/12/19.
//  Copyright © 2019 ozit solutions. All rights reserved.
//
//

import Foundation
import Alamofire

class RemoteRepository {
    
    fileprivate let baseUrl = baseConstants.baseUrl

    //Post API Request Method
    func remotePostServiceWithoutHeader(_ urlString : String! , params : Dictionary<String, Any> , callback:@escaping (_ data: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void)  {
        let urlString =  "\(baseConstants.baseUrl)\(urlString!)"
      //  print("url--\(urlString) \(params)")
        var request = URLRequest(url: NSURL(string: urlString)! as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        request.httpBody = json!.data(using: String.Encoding.utf8.rawValue)
        Alamofire.request(request as URLRequestConvertible).responseJSON(){ response in
            guard response.result.error == nil else {
                print("ERROR")
                callback(nil , response.result.error! as NSError )
                return
            }
            if let value = response.result.value {
                if let result = value as? Dictionary<String, AnyObject> {
                    //print("Response for POST Data :\(urlString):\(value)")
                    callback(result , nil )

                }else{
                   // KAppDelegate.showNotification(InvalidJson)
                    return
                }
            }
        }
    }

    //Post profile Update API Request Method
    func remoteProfilePostServiceWithoutHeader(_ urlString : String! , params : Dictionary<String, Any> , callback:@escaping (_ data: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void)  {
        let urlString =  "\(baseConstants.baseUrl)\(urlString!)"

        let authToken = "\(baseConstants.kUserDefaults.object(forKey: "AuthToken")!)"
        let headers = ["Content-Type":"application/json","Authorization":authToken]
       //print("URL-\(urlString) prams:\(params)")
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 20.0
        manager.request(urlString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON {response in
                guard response.result.error == nil else {
                    print(response.result.error!)
                    callback(nil , response.result.error! as NSError )
                    return
                }
                if let value = response.result.value {
                  //  print("Response for Post:\(urlString):\(value)")
                    if let result = value as? Dictionary<String, AnyObject> {
                        callback(result , nil )
                    }else{
//                        KAppDelegate.showNotification(InvalidJson)
                        return
                    }
                }
           }
    }


    //Group Post Method

        func remoteGroupPostServiceWithoutHeader(_ urlString : String! , params : Dictionary<String, Any> , callback:@escaping (_ data: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void)  {
            let urlString =  "\(baseConstants.baseUrl)\(urlString!)"

            let authToken = "\(baseConstants.kUserDefaults.object(forKey: "AuthToken")!)"
            let headers = ["Content-Type":"application/json","Authorization":authToken]
          // print("URL-\(urlString) prams:\(params)")
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 20.0
            manager.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .validate()
                .responseJSON {response in
                    guard response.result.error == nil else {
                        print(response.result.error!)
                        callback(nil , response.result.error! as NSError )
                        return
                    }
                    if let value = response.result.value {
                     //   print("Response for Post:\(urlString):\(value)")
                        if let result = value as? Dictionary<String, AnyObject> {
                            callback(result , nil )
                        }else{
    //                        KAppDelegate.showNotification(InvalidJson)
                            return
                        }
                    }
               }
        }



    //Get Api

    func remoteGETConfigFromServiceWithHeader(_ urlString : String! , callback:@escaping (_ data: Dictionary<String,AnyObject>?, _ error: NSError? ) -> Void)  {
        //let username = UserDefaults.standard.string(forKey: "userName")
        let authToken = "\(baseConstants.kUserDefaults.object(forKey: "AuthToken")!)"
        let url =  "\(baseUrl)\(urlString!)"
        let headers = ["Content-Type":"application/json","Authorization":authToken]
        //print("URL==--\(url) herders:\(headers)")

        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 20.0
        manager.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON {response in
                guard response.result.error == nil else {
                    //print(response.result.error!)
                    callback(nil , response.result.error! as NSError )
                    return
                }
                if let value = response.result.value {
                   // print("Response for GET:\(urlString!):\(value)")
                    if let result = value as? Dictionary<String, AnyObject> {
                        callback(result , nil )
                    }else{
                        //KAppDelegate.showNotification(InvalidJson)
                        return
                    }
                }
        }
    }

    // MARK:-- syncp Post Method
    func postDataInBodyWithParametersHeade(_ urlString : String! ,requestData:String , callback:@escaping (_ data: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void)  {
        let authToken = "\(baseConstants.kUserDefaults.object(forKey: "AuthToken")!)"
        let urlString =  "\(baseConstants.baseUrl)\(urlString!)"
        var request = URLRequest(url: NSURL(string: urlString)! as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(authToken, forHTTPHeaderField: "Authorization")
        //print(requestData)
        request.httpBody = requestData.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
        Alamofire.request(request as URLRequestConvertible).responseJSON(){ response in
            guard response.result.error == nil else {
                callback(nil , response.result.error! as NSError )
                return
            }
            if let value = response.result.value {
                if let result = value as? Dictionary<String, AnyObject> {
                  // print("Response for POST Data :\(urlString):\(value)")
                    callback(result , nil )
                }else{
                   // KAppDelegate.showNotification(InvalidJson)
                    return
                }
            }
        }
    }


    
    // MARK:-- MultiPart Data Post Method
    func postImageServiceWithParametersHeader(_ urlString : String! ,_ imageKey : String, _ imageFileName : String, params : Dictionary<String, Any>, _ selectedImg : UIImage, callback:@escaping (_ data: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void)  {
        let authToken = "\(baseConstants.kUserDefaults.object(forKey: "AuthToken")!)"
        let urlString =  "\(baseConstants.baseUrl)\(urlString!)"
        let headers = ["Authorization": authToken]
      //  print("url--\(urlString) header:\(authToken) params:\(params) image:\(imageKey) selectected:\(selectedImg)")
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            if selectedImg.size != .zero {
                let imageData = selectedImg.jpegData(compressionQuality: 0.75)
                multipartFormData.append(imageData!, withName: imageKey, fileName: imageFileName, mimeType: "image/jpg")
            }

        }, usingThreshold: UInt64.init(), to: urlString, method: .post,headers:headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if response.error != nil{
                        callback(nil , response.result.error! as NSError )
                        return
                    }else{
                        let value = response.result.value
                        if let result = value as? Dictionary<String, AnyObject> {
                       //     print("Result Data==\(result)")
                            callback(result , nil )
                        }else{
                           // KAppDelegate.showNotification(InvalidJson)
                            return
                        }
                    }
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                //KAppDelegate.showNotification("\(error)")
                return
            }
        }
    }
    

    
}
