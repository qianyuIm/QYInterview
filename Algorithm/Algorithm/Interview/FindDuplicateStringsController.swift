//
//  FindDuplicateStringsController.swift
//  Algorithm
//
//  Created by cyd on 2021/3/25.
//

import UIKit

class FindDuplicateStringsController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nums = [3,9,7,4,2,5,1,6,0,0]
        let bb = findRepeatNumber(nums)
        logDebug(bb)
        
    }
    func findRepeatNumber(_ nums: [Int]) -> Int {
        for i in 0 ..< nums.count {
            for j in (i+1) ..< nums.count {
                if nums[i] == nums[j] {
                    return nums[i]
                }
            }
        }
        return -1
    }

   
}
