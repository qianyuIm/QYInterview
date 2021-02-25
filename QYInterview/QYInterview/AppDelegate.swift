//
//  AppDelegate.swift
//  QYInterview
//
//  Created by cyd on 2021/1/13.
//

import UIKit
// __IOHIDEventSystemClientQueueCallback
// 查看事件的响应
@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        print(filePath)
        return true
    }
}

