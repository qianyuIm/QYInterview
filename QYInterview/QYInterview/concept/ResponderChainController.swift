//
//  ResponderChainController.swift
//  QYInterview
//
//  Created by cyd on 2021/2/24.
//

import UIKit
import SnapKit
import Toaster

class ResponderNextChainController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Next"
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let aa = self.next
        self.navigationController?.popViewController(animated: true)
        logDebug("点击\(aa)")

    }
}

class ResponderChainController: BaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        logDebug("点击")
        let next = ResponderNextChainController()
        self.navigationController?.pushViewController(next, animated: true)
    }
}
