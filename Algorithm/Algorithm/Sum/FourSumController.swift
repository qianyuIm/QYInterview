//
//  FourSumController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/13.
//
/**
 给定一个包含 n 个整数的数组 nums 和一个目标值 target，判断 nums 中是否存在四个元素 a，b，c 和 d ，使得 a + b + c + d 的值与 target 相等？找出所有满足条件且不重复的四元组。

 注意：答案中不可以包含重复的四元组。

    输入：nums = [1,0,-1,0,-2,2], target = 0
    输出：[[-2,-1,1,2],[-2,0,0,2],[-1,0,0,1]]
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/4sum
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */
import UIKit

class FourSumController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nums = [-2,-1,-1,1,1,2,2]
//        let nums = [2,2,2,2,2]
        
        let target = 0
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug(self.fourSum(nums,target))
        }
    }
    // 双指针
    // 先定位两个数
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        if nums.isEmpty || nums.count < 4 {
            return []
        }
        var array: [[Int]] = []
        // 先排序  O(nlogn)
        let nums = nums.sorted()
        //  O(n^3)
        for i in 0..<nums.count - 3 {
            // 去重
            if i > 0 && nums[i] == nums[i - 1] {
                continue
            }
            for j in (i+1)..<nums.count - 2 {
                // 去重
                if j > i + 1 && nums[j] == nums[j - 1] {
                    continue
                }
                var left = j + 1
                var right = nums.count - 1
                let partSum = nums[i] - nums[j]
                while left < right {
                    let sum = partSum + nums[left] + nums[right]
                    if sum == target {
                        array.append([nums[i], nums[j], nums[left], nums[right]])
                        // 去重
                        while left < right && nums[left] == nums[(left + 1)] {
                            left += 1
                        }
                        while left < right && nums[right] == nums[(right - 1)] {
                            right -= 1
                        }
                        left += 1
                        right -= 1
                    } else if sum < target {
                        // 增大
                        left += 1
                    } else {
                        // 减小
                        right -= 1
                    }
                }
            }
        }
        return array
    }

}
