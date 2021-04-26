//
//  AutoclosureController.swift
//  QYInterview
//
//  Created by cyd on 2021/4/22.
//

import UIKit

class AutoclosureController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return  }
            self.logIfTrue { () -> Bool in
                return 2 > 1
            }
            self.logIfTrueAuto(2 > 1)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
        }
    }
    
    func logIfTrue(_ predicate: () -> Bool) {
        if predicate() {
            logDebug("True")
        }
    }
    func logIfTrueAuto(_ predicate: @autoclosure () -> Bool) {
        if predicate() {
            logDebug("True")
        }
    }
}
