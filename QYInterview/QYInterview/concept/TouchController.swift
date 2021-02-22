//
//  TouchController.swift
//  QYInterview
//
//  Created by cyd on 2021/2/22.
//

import UIKit
fileprivate class RedView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        logDebug("红色视图")
    }
}
fileprivate class OrangeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        logDebug("橘色视图")
    }
}
class TouchController: BaseViewController {

    fileprivate lazy var redView: RedView = {
        let view = RedView()
        view.isUserInteractionEnabled = false
        return view
    }()
    fileprivate lazy var orangeView: OrangeView = {
        let view = OrangeView()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(redView)
        redView.addSubview(orangeView)
        redView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
        orangeView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
        let sem = DispatchSemaphore(value: 5)
        for _ in 0..<100 {
            DispatchQueue.global().async {
                sem.wait()
                logDebug(Thread.current)
                sleep(3)
                sem.signal()
            }
        }
        
    }
}
