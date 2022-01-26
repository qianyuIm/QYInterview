//
//  Helper.swift
//  QYInterview
//
//  Created by cyd on 2022/1/24.
//

import Foundation

class Helper {
    
    class func home() {
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
    }
}
