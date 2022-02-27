//
//  OCCallSwift.swift
//  QYInterview
//
//  Created by 丁帅 on 2022/2/27.
//

import Foundation
@objcMembers class OCCallSwift: NSObject {
    // 使用@objcMembers 或者单独方法前面添加@objc
    class func log() {
        logDebug("OC调用Swift方法")
    }
}
