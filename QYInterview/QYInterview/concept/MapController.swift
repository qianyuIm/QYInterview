//
//  MapController.swift
//  QYInterview
//
//  Created by cyd on 2021/1/18.
//

import UIKit

class MapController: BaseViewController {

    let array = [1,3,4,nil,6]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let mapArray = array.map { $0 }
        let flatMapArray = array.flatMap { $0 }
        let compactMapArray  = array.compactMap { $0 }
        logDebug("mapArray = \(mapArray)", separator: "", terminator: " ")
        logDebug("")
        logDebug("flatMapArray = \(flatMapArray)", separator: "", terminator: " ")
        logDebug("")
        logDebug("compactMapArray = \(compactMapArray)", separator: "", terminator: " ")
        logDebug("")
        let aaa = mapArray.dropFirst()
        logDebug("aaa = \(aaa)", separator: "", terminator: " ")
        let a = stride(from: 0, to: 70, by: 5)
    }
    
}
