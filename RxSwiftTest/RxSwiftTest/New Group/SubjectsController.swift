//
//  SubjectsController.swift
//  RxSwiftTest
//
//  Created by cyd on 2021/4/9.
//

import UIKit
import RxSwift
import RxCocoa

class SubjectsController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            self?.examplePublishSubject()
        }
    }
    //MARK: - PublishSubject
    func examplePublishSubject()  {
        // 初始化序列
        let publishSubject = PublishSubject<Int>()
        // 发送
        publishSubject.onNext(1)
        // 订阅
        publishSubject.subscribe { (element) in
            logDebug("第一次订阅 \(element)")
        }.disposed(by: disposeBag)
        // 再次发送
        publishSubject.onNext(2)
        publishSubject.onNext(3)
        // 再次订阅
        publishSubject.subscribe { (element) in
            logDebug("第二次订阅 \(element)")
        }.disposed(by: disposeBag)
        // 再次发送
        publishSubject.onNext(4)
        publishSubject.onNext(5)

    }
}
