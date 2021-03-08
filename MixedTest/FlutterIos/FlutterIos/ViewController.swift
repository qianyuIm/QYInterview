//
//  ViewController.swift
//  FlutterIos
//
//  Created by cyd on 2021/3/8.
//

import UIKit
import Flutter
import FlutterPluginRegistrant
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "混合开发"
    }

    @IBAction func jumpNavite(_ sender: UIButton) {
        let native = NaviteController()
        self.navigationController?.pushViewController(native, animated: true)
    }
    
    @IBAction func jumpFlutter(_ sender: UIButton) {
        let flutter = FlutterViewController()
        self.navigationController?.pushViewController(flutter, animated: true)
    }
    
}

