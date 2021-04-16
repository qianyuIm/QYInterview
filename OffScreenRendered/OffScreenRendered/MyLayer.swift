//
//  MyLayer.swift
//  OffScreenRendered
//
//  Created by cyd on 2021/4/14.
//

import UIKit

class MyLayer: CALayer {
    override class func resolveInstanceMethod(_ sel: Selector!) -> Bool {
        print(sel)
        return super.resolveInstanceMethod(sel)
    }
}
