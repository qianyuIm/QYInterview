//
//  SortedSquaresArrayController.swift
//  QYInterview
//
//  Created by cyd on 2022/1/14.
// 977.有序数组的平方
// https://leetcode-cn.com/problems/squares-of-a-sorted-array/
/**
 
 给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。

 示例 1： 输入：nums = [-4,-1,0,3,10] 输出：[0,1,9,16,100] 解释：平方后，数组变为 [16,1,0,9,100]，排序后，数组变为 [0,1,9,16,100]

 示例 2： 输入：nums = [-7,-3,2,3,11] 输出：[4,9,9,49,121]

 
 */

import UIKit

class SortedSquaresArrayController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nums = [-4,-1,0,3,10]
        let new = sortedSquares(nums)
        logDebug(new)
    }
    func sortedSquares(_ nums: [Int]) -> [Int] {
        // 指向新数组最后一个元素
        var k = nums.count - 1
        // 指向原数组第一个元素
        var left = 0
        // 指向原数组最后一个元素
        var right = nums.count - 1
        // 初始化新数组(用-1填充)
        var result = Array<Int>(repeating: -1, count: nums.count)

        for _ in 0..<nums.count {
            if nums[left] * nums[left] < nums[right] * nums[right] {
                result[k] = nums[right] * nums[right]
                right -= 1
            } else {
                result[k] = nums[left] * nums[left]
                left += 1
            }
            k -= 1
        }
        return result
    }
}
