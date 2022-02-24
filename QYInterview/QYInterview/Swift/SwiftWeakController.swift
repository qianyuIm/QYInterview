//
//  SwiftWeakController.swift
//  QYInterview
//
//  Created by cyd on 2022/2/24.
//

import UIKit


class SwiftWeakController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            
        }
    }
    
    
}
