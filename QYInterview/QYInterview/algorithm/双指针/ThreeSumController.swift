//
//  ThreeSumController.swift
//  QYInterview
//
//  Created by cyd on 2022/1/13.
// 第15题. 三数之和
/**
 https://leetcode-cn.com/problems/3sum/
 
 给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有满足条件且不重复的三元组。

 注意： 答案中不可以包含重复的三元组。

 示例：

 给定数组 nums = [-1, 0, 1, 2, -1, -4]，

 满足要求的三元组集合为： [ [-1, 0, 1], [-1, -1, 2] ]

 
 */

import UIKit

class ThreeSumController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nums = [-1, 0, 1, 2, -1, -4]
        let new = threeSum(nums)
        exit(1)
    }
    func threeSum(_ nums: [Int]) -> [[Int]] {
        
        return []
    }
}
