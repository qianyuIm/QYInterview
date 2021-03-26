//
//  FindRepeatNumberController.swift
//  Algorithm
//
//  Created by cyd on 2021/3/25.
// https://leetcode-cn.com/problems/shu-zu-zhong-zhong-fu-de-shu-zi-lcof/

import UIKit

class FindRepeatNumberController: BaseViewController {

    var repeatNumber = [2, 3, 1, 0, 2, 5, 3]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            let number = self.findRepeatNumber(self.repeatNumber)
            logDebug("重复数字为 \(number)")
        }
        
    }
    // 在一个长度为 n 的数组 nums 里的所有数字都在 0～n-1 的范围内。数组中某些数字是重复的，但不知道有几个数字重复了，也不知道每个数字重复了几次。请找出数组中任意一个重复的数字。
    
    // [2, 3, 1, 0, 2, 5, 3]
    // 如果没有重复数字，那么正常排序后，数字i应该在下标为i的位置，所以思路是重头扫描数组，遇到下标为i的数字如果不是i的话，（假设为m),那么我们就拿与下标m的数字交换。在交换过程中，如果有重复的数字发生，那么终止返回ture
    
    //因为给定的数组是0-n-1这个范围内，因而比如nums[0]假设是2，那么我们可以放到2这个位置，这样，一旦遇到重复的数字，那么在同一个位置就会发生碰撞，我们就可以检测出重复的数字，
    
    //  时间复杂度为o(n)，而空间复杂度为o(1)
    func findRepeatNumber(_ nums: [Int]) -> Int {
        var nums = nums
        for i in 0..<nums.count {
            // 正常没有重复的数组则应该相等
            while i != nums[i] {
                if nums[i] == nums[nums[i]] {
                    return nums[i]
                }
                nums.swapAt(i, nums[i])
            }
        }
        return -1
    }
}
