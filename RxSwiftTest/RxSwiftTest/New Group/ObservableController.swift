//
//  ObservableController.swift
//  RxSwiftTest
//
//  Created by cyd on 2021/4/9.
//

import UIKit
import RxSwift
import RxCocoa

class ObservableController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            self?.example4()
        }
    }
    //MARK: - 订阅信号
    func example0() {
        let observable = Observable.of("A","B","C")
        observable.subscribe { (event) in
            logDebug(event.element!)
        }.disposed(by: disposeBag)
    }
    func example1() {
        let observable = Observable.of("A","B","C")
        _ = observable.subscribe { (element) in
            logDebug(element)
        } onError: { (error) in
            logDebug(error)
        } onCompleted: {
            logDebug("completed")
        } onDisposed: {
            logDebug("disposed")
        }
    }
    func example2() {
//        let observable = Observable.of("A","B","C")
        let observable = Observable.of("A")

        _ = observable.do { (element) in
            logDebug("do onNext -- \(element)")
        } afterNext: { (element) in
            logDebug("do afterNext \(element)")
        } onError: { (error) in
            logDebug("do \(error)")
        } afterError: { (error) in
            logDebug("do \(error)")
        } onCompleted: {
            logDebug("do onCompleted")
        } afterCompleted: {
            logDebug("do afterCompleted")
        } onSubscribe: {
            logDebug("do onSubscribe")
        } onSubscribed: {
            logDebug("do onSubscribed")
        } onDispose: {
            logDebug("do onDispose")
        }.subscribe { (element) in
            logDebug("\(element)")
        } onError: { (error) in
            logDebug(error)
        } onCompleted: {
            logDebug("onCompleted")
        } onDisposed: {
            logDebug("onDisposed")
        }
    }
    //MARK: - 取消订阅信号
    func example3() {
        let observable = Observable.of("A","B","C")
        //使用subscription常量存储这个订阅方法
        let subscribe = observable.subscribe { (element) in
            logDebug(element)
        }
        // 取消订阅
        subscribe.dispose()
    }
    func example4() {
        // 内部使用 GCD
        let observable = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        observable.map { (element) -> String in
            return "当前索引数：\(element)"
        }.bind { [weak self] (element) in
            self?.textLabel.text = element
        }.disposed(by: disposeBag)
        
    }
}
