//
//  ResponderChainController.swift
//  QYInterview
//
//  Created by cyd on 2021/2/24.
//

import UIKit
import SnapKit
import Toaster

fileprivate class RootView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        logDebug("RootView hitTest")
        return view
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touche = touches.first!
        logDebug("RootView touchesBegan \(touche.phase.rawValue)")
    }
}
fileprivate class AView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        logDebug("AView hitTest")
        return view
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touche = touches.first!
        logDebug("AView touchesBegan \(touche.phase.rawValue)")
        Toast(text: "123").show()
    }
}
fileprivate class BView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        logDebug("BView hitTest")
        return view
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touche = touches.first!
        logDebug("BView touchesBegan \(touche.phase.rawValue)")
    }
}
fileprivate class Sender: UIButton {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        logDebug("\(self) hitTest")
        return view
    }
}
class ResponderChainController: BaseViewController {

    fileprivate lazy var sender: Sender = {
        let sender = Sender(type: .custom)
        sender.addTarget(self, action: #selector(senderDidClick), for: .touchUpInside)
        sender.backgroundColor = .orange
//        sender.isUserInteractionEnabled = false
        return sender
    }()
    fileprivate lazy var aView: AView = {
        let view = AView()
//        view.isUserInteractionEnabled = false
        view.backgroundColor = .gray
        return view
    }()
    fileprivate lazy var bView: BView = {
        let view = BView()
//        view.isUserInteractionEnabled = false
        view.backgroundColor = .red
        return view
    }()
    override func loadView() {
        view = RootView()
//        view.isUserInteractionEnabled = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(aView)
        aView.addSubview(bView)
        aView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
        bView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(50)
        }
        view.setNeedsLayout()
        logDebug(bView)
        view.layoutIfNeeded()
        logDebug(bView)

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logDebug("来了")
    }
    @objc func senderDidClick() {
        logDebug("按钮点击")
        Toast(text: "123").show()
    }
}
