//
//  MinSubArrayLenController.swift
//  QYInterview
//
//  Created by cyd on 2022/1/14.
// 209.长度最小的子数组
// https://leetcode-cn.com/problems/minimum-size-subarray-sum/
/**
 给定一个含有 n 个正整数的数组和一个正整数 s
 ，找出该数组中满足其和 ≥ s 的长度最小的
 **连续 子数组**，
 并返回其长度。如果不存在符合条件的子数组，返回 0。

 示例：

 输入：s = 7, nums = [2,3,1,2,4,3] 输出：2 解释：子数组 [4,3] 是该条件下的长度最小的子数组。

 #
 
 */
import UIKit

class MinSubArrayLenController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let target = 7
        let nums = [2,3,1,1,2,4,3]
        let count = minSubArrayLen(target, nums)
        logDebug("count == \(count)")
    }
    
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        var result = Int.max
        var sum = 0
        var starIndex = 0
        for endIndex in 0..<nums.count {
           sum += nums[endIndex]
           while sum >= target {
               result = min(result, endIndex - starIndex + 1)
               sum -= nums[starIndex]
               starIndex += 1
           }
        }
        return result == Int.max ? 0 : result
    }
}
