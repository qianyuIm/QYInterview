//
//  ViewController.swift
//  OffScreenRendered
//
//  Created by cyd on 2021/4/13.
//

import UIKit
public extension UIView {
    func addRoundedCorners(_ corner: UIRectCorner, raddi: CGSize, fillColor: UIColor) {
        let maskLayer = self.mask(for: corner, raddi: raddi, fillColor: fillColor)
        self.layer.mask = maskLayer
    }

    func mask(for corner: UIRectCorner, raddi: CGSize, fillColor: UIColor) -> CALayer {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        let path = UIBezierPath(roundedRect: maskLayer.bounds, byRoundingCorners: corner, cornerRadii: raddi)
        maskLayer.fillColor = fillColor.cgColor
        maskLayer.backgroundColor = UIColor.clear.cgColor
        maskLayer.path = path.cgPath
        return maskLayer
    }
}

class ViewController: UIViewController {

    var myLayer = MyLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let wh: CGFloat = 80
        
        let blue = UIView()
        blue.frame = .init(x: 50, y: 100, width: wh, height: wh);
        // 单单设置背景色不会有离屏渲染，即使是非纯色背景也是如此。
        blue.backgroundColor = .blue;
        blue.layer.cornerRadius = 20
//        blue.layer.shouldRasterize = true
//        view.addSubview(blue)
        
        let red = UIView()
        red.frame = .init(x: 10, y: 10, width: wh - 30, height: wh - 30);
        // 单单设置背景色不会有离屏渲染，即使是非纯色背景也是如此。
        red.backgroundColor = .red;
        red.layer.cornerRadius = 10
        red.layer.shadowColor = UIColor.black.cgColor
//        red.layer.shadowOffset = CGSize(width: 2, height: 2)
        red.layer.shadowOpacity = 1
//        red.layer.masksToBounds = true
        view.addSubview(red)
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("点击屏幕")
    }

}

