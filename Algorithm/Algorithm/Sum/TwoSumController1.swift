//
//  TwoSumController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/13.
//
/**
 给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 的那 两个 整数，并返回它们的数组下标。

 你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。

 你可以按任意顺序返回答案。
 示例 1：

    输入：nums = [2,7,11,15], target = 9
    输出：[0,1]
    解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。
 示例 2：

    输入：nums = [3,2,4], target = 6
    输出：[1,2]
 示例 3：

    输入：nums = [3,3], target = 6
    输出：[0,1]
  

 提示：

    2 <= nums.length <= 103
    -109 <= nums[i] <= 109
    -109 <= target <= 109
    只会存在一个有效答案

 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/two-sum
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */
import UIKit

class TwoSumController1: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let nums = [2,5,11,7,2,15,1]
//        let nums = [3,3]
        let nums = [3,2,4]

        let target = 6
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug(self.twoSum1(nums, target))
        }
    }
    // 暴力枚举
    // 时间复杂度: O(n^2)
    // 控件复杂度： O(1)
    func twoSum(_ nums: [Int],
                _ target: Int) -> [Int] {
        for i in 0..<nums.count {
            for j in (i + 1)..<nums.count {
                if nums[i] + nums[j] == target {
                    return [i, j]
                }
            }
        }
        return []
    }
    
    // 哈希查找
    // 时间复杂度: O(n)
    // 控件复杂度： O(n)
    func twoSum1(_ nums: [Int],
                _ target: Int) -> [Int] {
        // 预处理放入字典中 只需要一个有效答案 则只需要保留一份即可
        var dict: [Int: Int] = [:]
        for (index,num) in nums.enumerated() {
            dict[num] = index
        }
        for index in 0..<nums.count {
            let num = nums[index]
            if dict.keys.contains(target - num) {
                // 获取下标数组
                let j = dict[target - num]!
                // 同一元素不能使用两次
                if index != j {
                    return [index, j]
                }
            }
        }
        return []
    }
    func twoSum2(_ nums: [Int], _ target: Int) -> [Int] {
            guard nums.count > 1 else {
                return []
            }
            var map = [Int : Int]()
            for i in 0..<nums.count {
                let another = target - nums[i]
                if let j = map[another] {
                    return [i, j]
                }
                map[nums[i]] = i
            }
            return []
        }

    
}
