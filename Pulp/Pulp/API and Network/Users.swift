//
//  Users.swift
//  Pulp
//
//  Created by Aryan Arora on 12/4/19.
//  Copyright © 2019 Pulp Inc. All rights reserved.
//

import Foundation
import FacebookLogin
import FacebookCore

struct CreateUserResponse: Codable{
    let user_id: String
}
struct FBresponse {
    let id : Int
    let name: String
}

func CreateUser(){
    var first_name : String?
    var last_name : String?
    var id = ""
    var photo_url : String?
    var friends = [String]()
    print("GraphRequest starting")
    
    GraphRequest(graphPath: "me", parameters: ["fields": "id, first_name,last_name,picture.type(large),friends"]).start(completionHandler: {
        (connection,result,error) -> Void in
        if (error == nil){
            let dict = result as! [String:AnyObject]
            let temp = dict as NSDictionary
            let pic1 = temp.object(forKey: "picture") as? NSDictionary
            let pic2 = pic1?.object(forKey: "data") as? NSDictionary
            photo_url = pic2?.object(forKey: "url") as? String
            USER_Photo = photo_url ?? ""
            let defaults = UserDefaults.standard
            defaults.set(USER_Photo, forKey: "user_photo")
            defaults.synchronize()
            let friend1 = temp.object(forKey: "friends") as? NSDictionary
            let friend2 = friend1?.object(forKey: "data") as? [NSDictionary]
            
            if friend2 != nil{
                for a in friend2!{
                    friends.append((a.object(forKey: "id") as? String)!)
                }
            }
            
            first_name = temp.object(forKey: "first_name") as? String
            last_name = temp.object(forKey: "last_name") as? String
            id = (temp.object(forKey: "id") as? String)!
            
            let access = "a"
            service.request(.NewUser(firstName: first_name ?? "", lastName: last_name ?? "", photo: photo_url ?? "", fbID: id, friends: friends , accessToken: access)) {(result) in
                   switch result {
                   case .success(let response):
                       if let string = String(data: response.data, encoding: .utf8) {
                           let string2 = string.dropLast(1)
                           USERID = String(string2.dropFirst())
                            let defaults = UserDefaults.standard
                            defaults.set(USERID, forKey: "user_id")
                            defaults.synchronize()
                            loginDispatch.leave()


                       } else {
                           print("not a valid UTF-8 sequence")
                       }
                   case .failure(let error):
                       print("Error: \(error)")
                   }
               }

            
        }
        
    })
    
   }
