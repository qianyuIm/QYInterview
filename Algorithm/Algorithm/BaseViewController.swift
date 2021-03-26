//
//  BaseViewController.swift
//  Algorithm
//
//  Created by cyd on 2021/3/25.
//

import UIKit

class BaseViewController: UIViewController {

//    let sortArray: [Int] = [2,10,9,3,20,4,8]
    let sortArray: [Int] = [1,3,4,6,7,8]

    let repeatString = "abcdddacbs"
    var touchesBeganBlock: (() -> Void)?
    
    deinit {
        logDebug("移除了")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        let label = UILabel(frame: .zero)
        label.text = "点击屏幕查看输出"
        label.textColor = .red
        label.sizeToFit()
        label.center = view.center
        view.addSubview(label)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchesBeganBlock?()
    }
}
