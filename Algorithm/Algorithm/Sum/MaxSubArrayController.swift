//
//  MaxSubArrayController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/16.
//
/**
 53. 最大子序和
 给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。

 示例 1：

    输入：nums = [-2,1,-3,4,-1,2,1,-5,4]
    输出：6
    解释：连续子数组 [4,-1,2,1] 的和最大，为 6 。
 示例 2：

    输入：nums = [1]
    输出：1
示例 3：

    输入：nums = [0]
    输出：0
 示例 4：

    输入：nums = [-1]
    输出：-1
 示例 5：

    输入：nums = [-100000]
    输出：-100000
  

 提示：

 1 <= nums.length <= 3 * 104
 -105 <= nums[i] <= 105
  

 进阶：如果你已经实现复杂度为 O(n) 的解法，尝试使用更为精妙的 分治法 求解。



 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/maximum-subarray
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */
import UIKit

class MaxSubArrayController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nums = [-2,1,-3,4,-1,2,1,-5,4]
//        let nums = [-2,1,-3]
//        let nums = [-1,-2]

        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug(self.maxSubArray2(nums))
        }
    }
    
    // 第一种暴力法
    func maxSubArray(_ nums: [Int]) -> Int {
        if nums.count == 1 {
            return nums[0]
        }
        var sum = Int.min
        var cur = 0
        for i in 0..<nums.count {
            cur = 0
            for j in i..<nums.count {
                cur += nums[j]
                sum = sum > cur ? sum : cur
            }
        }
        return sum
    }
    // 贪心
    // 若当前指针所指元素之前的和小于0，则丢弃当前元素之前的序列
    func maxSubArray1(_ nums: [Int]) -> Int {
            // [-2,1,-3,4,-1,2,1,-5,4]
        var cur : Int = 0
        var max = Int.min
        for i in 0..<nums.count {
            cur += nums[i]
            max = max > cur ? max : cur
            cur = cur < 0 ? 0 : cur
        }
        return max
    }
    // 动态规划
    // 查看上一个数是否为正增益
    func maxSubArray2(_ nums: [Int]) -> Int {
        // 原始数字组: [-2, 1, -3, 4, -1, 2, 1, -5, 4]
        // 和数组 ：   [-2, 1, -2, 4, 3, 5, 6, 1, 5]
        var nums = nums
        for i in 1..<nums.count {
            if nums[i - 1] > 0 {
                nums[i] = nums[i] + nums[i - 1]
            }
        }
        logDebug(nums)
        return nums.max() ?? 0
    }

}
