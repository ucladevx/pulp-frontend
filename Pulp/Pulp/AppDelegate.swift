//
//  AppDelegate.swift
//  Pulp
//
//  Created by Aryan Arora on 10/22/19.
//  Copyright © 2019 Pulp Inc. All rights reserved.
//

import UIKit
import Foundation
import FBSDKCoreKit
import Moya


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let defaults = UserDefaults.standard
        let defaultValue = ["login_key" : "", "user_id" : "" , "user_photo" :""]
        defaults.register(defaults: defaultValue)
//        USERID = defaults.string(forKey: "user_id")!
        USERID = "5e62d202a29655c3f54a14e5" //me- 5e62d202a29655c3f54a14e5    5e66e1a2a29655e38f4a14e7
        USER_Photo = defaults.string(forKey: "user_photo")!
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        return ApplicationDelegate.shared.application(app, open: url, options: options)
        return true
    }
    


}
