//
//  AccessControl.swift
//  AccessControlModule
//
//  Created by cyd on 2022/2/25.
//

import Foundation

open class AccessControl: NSObject {
    open func openLog() {
        print("可以在其他模块继承重写")
    }
    public func publicLog() {
        print("只能在本模块继承重写")
    }
}
