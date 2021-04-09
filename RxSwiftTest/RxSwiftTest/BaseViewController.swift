//
//  BaseViewController.swift
//  RxSwiftTest
//
//  Created by cyd on 2021/4/9.
//

import UIKit
import RxCocoa
import RxSwift

class BaseViewController: UIViewController {

    var touchesBeganBlock: (() -> Void)?
    //负责对象销毁
    let disposeBag = DisposeBag()
    let textLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        textLabel.text = "点击屏幕查看输出"
        textLabel.textColor = .red
        textLabel.sizeToFit()
        textLabel.center = view.center
        view.addSubview(textLabel)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchesBeganBlock?()
    }
    deinit {
        print("\(self) --- deinit")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
