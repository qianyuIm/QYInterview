//
//  BinarySearchController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/21.
//

import UIKit

class BinarySearchController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nums = [1,3,4,5,7,8,9]
        let target = 3
        touchesBeganBlock = { [weak self] in
            guard let self = self else {
                return
            }
            logDebug("target 位置 \(self.binarySearch(nums, target))")
        }
    }
    

    func binarySearch(_ nums: [Int], _ target: Int) -> Int {
        if nums.isEmpty {
            return -1
        }
        // [1,3,4,5,7,8,9]
        // 3
        var low = 0
        var high = nums.count - 1
        while low <= high {
            let mid = low + ((high - low) / 2)
            let midValue = nums[mid]
            if midValue > target {
                high = mid - 1
            } else if midValue < target{
                low = mid + 1
            } else {
                return mid
            }
        }
        return -1
    }

}
