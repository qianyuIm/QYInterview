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
    override func draw(_ rect: CGRect) {
        super.draw(rect)
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
    lazy var sender: UIButton = {
        let sender = UIButton(type: .custom)
        sender.backgroundColor = .green
        sender.addTarget(self, action: #selector(senderDidClick), for: .touchUpInside)
        return sender
    }()
    lazy var imageView: UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = .gray
        imageV.isUserInteractionEnabled = true
        return imageV
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(imageView)
        imageView.addSubview(sender)
        view.addSubview(redView)
        redView.layoutIfNeeded()
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
        sender.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
        redView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
    }
    @objc func senderDidClick() {
        logDebug("按钮点击")
    }
}
