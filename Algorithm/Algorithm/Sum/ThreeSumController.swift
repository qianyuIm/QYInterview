//
//  ThreeSumController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/13.
//
/**
 给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有和为 0 且不重复的三元组。

 注意：答案中不可以包含重复的三元组。
 示例 1：

    输入：nums = [-1,0,1,2,-1,-4]
    输出：[[-1,-1,2],[-1,0,1]]
    示例 2：
 示例 2：
    输入：nums = []
    输出：[]
 示例 3：

 输入：nums = [0]
 输出：[]

 提示：

    0 <= nums.length <= 3000
    -105 <= nums[i] <= 105
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/3sum
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */
import UIKit

class ThreeSumController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let nums = [3,0,-2,-1,1,2]
        let nums = [-1,0,1,2,-1,-4]
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug(self.threeSum2(nums))
        }
    }
    // 暴力解法
    // 时间复杂度: O(n^3)
    // 控件复杂度： O(1)
    func threeSum(_ nums: [Int]) -> [[Int]] {
        // 暴力
        guard nums.count > 2 else { return [] }
        // 去重
        var sumSet: Set<[Int]> = []
        
        // 小优化
//        nums.sort()

        for i in 0..<nums.count {
            for j in (i+1)..<nums.count {
                for k in (j+1)..<nums.count {
                    if nums[i] + nums[j] + nums[k] == 0 {
                        var temp = [nums[i],nums[j],nums[k]]
                        temp.sort()
                        sumSet.insert(temp)
                    }
                }
            }
        }
        return sumSet.map{$0}
    }
    // 双指针
    func threeSum1(_ nums: [Int]) -> [[Int]] {
        // 先排序
        let nums = nums.sorted() // O(nlogn)
        var sumSet: Set<[Int]> = []
        // O(n^2)
        for i in 0..<nums.count {
            // 双指针
            var left = i + 1
            var right = nums.count - 1
            // 在[left...right]中查找target
            let target = -nums[i]
            while left < right {
                let temp = nums[left] + nums[right]
                if temp == target {
                    sumSet.insert([-target, nums[left], nums[right]])
                    left += 1
                    right -= 1
                } else if temp < target{
                    left += 1
                } else {
                    right -= 1
                }
            }
        }
        return sumSet.map{$0} //  O(n)
    }
    // 双指针 去重优化
    func threeSum2(_ nums: [Int]) -> [[Int]] {
        // 先排序
        let nums = nums.sorted() // O(nlogn)
        var sumSet: [[Int]] = []
        // O(n^2)
        for i in 0..<nums.count {
            // 去重 当前数和之后相同的话 求出来的left 与 righ 也相同
            if i > 0 && nums[i] == nums[i - 1] { continue }
            // 双指针
            var left = i + 1
            var right = nums.count - 1
            // 在[left...right]中查找target
            let target = -nums[i]
            while left < right {
                let temp = nums[left] + nums[right]
                if temp == target {
                    sumSet.append([-target, nums[left], nums[right]])
                    
                    while left < right && nums[left] == nums[(left + 1)] {
                        left += 1
                    }
                    while left < right && nums[right] == nums[(right - 1)] {
                        right -= 1
                    }
                    left += 1
                    right -= 1

                } else if temp < target{
                    left += 1
                } else {
                    right -= 1
                }
            }
        }
        return sumSet
    }
}
