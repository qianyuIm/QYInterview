//
//  AccessControlController.swift
//  QYInterview
//
//  Created by cyd on 2022/2/25.
//

import UIKit
import AccessControlModule

class SubAccessControl: AccessControl {
    override func openLog() {
        super.openLog()
        logDebug("其他模块继承重写了")
    }
    // 报错
//    override func publicLog() {}
    
}

class AccessControlController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let string = """
        查看SwiftModule -> AccessControl
        """
        logDebug(string)
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            self.test()
        }
    }
    func test() {
        let accessControl = SubAccessControl()
        accessControl.openLog()
        accessControl.publicLog()
    }
}
