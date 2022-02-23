//
//  DoubleQuickSortController.swift
//  Algorithm
//
//  Created by cyd on 2022/2/23.
//

import UIKit

class DoubleQuickSortController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        logDebug(def)
        var array = [7,10,9,3,20,4,8]
        touchesBeganBlock = { [weak self] in
            guard let self = self else { return  }
            self.quickSort(&array,low: 0,high: array.count - 1)
            logDebug(array)
        }
    }
    func quickSort(_ array: inout [Int], low: Int, high: Int) {
        
    }
}
