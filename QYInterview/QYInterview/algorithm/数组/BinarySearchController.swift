//
//  BinarySearchController.swift
//  QYInterview
//
//  Created by cyd on 2021/1/14.
//  - 二分查找法
// 优点:1.速度快 2.比较次数少 3.性能好
// 缺点: 1.必须是一个有序的数组（升序或者降序）,数组中无重复元素
//      2.适用范围：适用不经常变动的数组
// https://leetcode-cn.com/problems/binary-search/

import UIKit

class BinarySearchController: BaseViewController {

    let nums = [1,3,5,7,9,11,13,16,17]
    let undefinedIndex: Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            let target: Int = 17
            let index = self.binarySearch(self.nums, target: target)
            logDebug("\(target) 在数组中的下标为\(index)")
        }
    }
    // https://programmercarl.com/0704.%E4%BA%8C%E5%88%86%E6%9F%A5%E6%89%BE.html#%E6%80%9D%E8%B7%AF
    /// 左闭右闭区间
    func binarySearch(_ nums: [Int], target: Int) -> Int {
        // 1. 先定义区间。这里的区间是[left, right]
        var left = 0
        var right = nums.count - 1
        // 因为taeget是在[left, right]中，包括两个边界值
        // ，所以这里的left == right是有意义的
        while left <= right {
            // 2. 计算区间中间的下标
            //    （如果left、right都比较大的情况下，left + right就有可能会溢出）
            // let middle = (left + right) / 2
            // 防溢出：
            let middle = left + (right - left) / 2
            // 3. 判断
            if target < nums[middle] {
                // 当目标在区间左侧，就需要更新右边的边界值，新区间为[left, middle - 1]
                right = middle - 1
            } else if target > nums[middle] {
                // 当目标在区间右侧，就需要更新左边的边界值，新区间为[middle + 1, right]
                left = middle + 1
            } else {
                return middle
            }
        }
        // 如果找不到目标，则返回-1
        return undefinedIndex
    }
    // （版本二）左闭右开区间
    func binarySearch2(_ nums: [Int], target: Int) -> Int {
        var left = 0
        var right = nums.count
        while left < right {
            let middle = left + ((right - left) >> 1)
            if target < nums[middle] {
                right = middle
            } else if target > nums[middle] {
                left = middle + 1
            } else {
                return middle
            }
        }
        return -1
    }
    func binarySearch3(_ nums: [Int], target: Int) -> Int {
        var left = 0
        var right = nums.count
        while left < right {
            let middle = left + (right - left) / 2
            if (target > nums[middle]) {
                left = middle + 1
            } else if (target < nums[middle]) {
                right = middle
            } else {
                return middle
            }
        }
        return -1
    }
}
