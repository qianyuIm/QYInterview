//
//  ClosureController.swift
//  QYInterview
//
//  Created by cyd on 2022/2/21.
//

import UIKit

var num1 = 1
var num2 = 2

class ClosureController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.touchesBeganBlock = { [weak self] in
            self?.test()
        }
    }
    var iStrong = {
        num1 += 1
        num2 += 1
    }
    var iCopy = { [num1, num2] in
        logDebug("copy -> \(num1) - \(num2)")
    }
    func test() {
        iStrong()
        logDebug("\(num1) - \(num2)")
        iCopy()
        logDebug("\(num1) - \(num2)")
    }

}
