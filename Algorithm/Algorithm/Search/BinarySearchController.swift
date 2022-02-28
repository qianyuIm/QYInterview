//
//  BinarySearchController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/21.
// https://programmercarl.com/0704.%E4%BA%8C%E5%88%86%E6%9F%A5%E6%89%BE.html#%E6%80%9D%E8%B7%AF

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
    
    // 左闭右闭
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
    //左闭右开
    func binarySearch1(_ nums: [Int], _ target: Int) -> Int {
        if (nums.isEmpty) {
            return -1
        }
        var left = 0
        var right = nums.count
        while left < right {
            let middle = left + (right - left)/2
            if (target < nums[middle]) {
                right = middle
            } else if (target > nums[middle]) {
                left = middle + 1
            } else {
                return middle
            }
        }
        return -1
    }
}
