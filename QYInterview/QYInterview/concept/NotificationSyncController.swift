//
//  NotificationSyncController.swift
//  QYInterview
//
//  Created by cyd on 2021/4/19.
//

import UIKit

class NotificationSyncController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(addNo), name: .init("123"), object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        logDebug("即将发出通知")
        NotificationCenter.default.post(name: .init("123"), object: nil)
        logDebug("已经发出通知")
    }
    
    @objc func addNo() {
        logDebug("获取通知")
    }
}
