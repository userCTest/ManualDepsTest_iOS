//
//  AppDelegate.swift
//  ManualDepsTest
//
//  Created by Rui Reis on 22/06/2022.
//

import UIKit

import Usercentrics
import UsercentricsUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let uc = Usercentrics()
        /// Initialize Usercentrics with your configuration
        uc.appInit()
        return true
    }


}

