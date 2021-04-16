//
//  TwoSumController2.swift
//  Algorithm
//
//  Created by cyd on 2021/4/13.
//
/**
 给定一个已按照 升序排列  的整数数组 numbers ，请你从数组中找出两个数满足相加之和等于目标数 target 。

 函数应该以长度为 2 的整数数组的形式返回这两个数的下标值。numbers 的下标 从 1 开始计数
 ，所以答案数组应当满足 1 <= answer[0] < answer[1] <= numbers.length 。

 你可以假设每个输入只对应唯一的答案，而且你不可以重复使用相同的元素。

  
 示例 1：

    输入：numbers = [2,7,11,15], target = 9
    输出：[1,2]
    解释：2 与 7 之和等于目标数 9 。因此 index1 = 1, index2 = 2 。
 
 示例 3：
    输入：numbers = [-1,0], target = -1
    输出：[1,2]
 
 提示：

    2 <= numbers.length <= 3 * 104
    -1000 <= numbers[i] <= 1000
    numbers 按 递增顺序 排列
    -1000 <= target <= 1000
    仅存在一个有效答案


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/two-sum-ii-input-array-is-sorted
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
import UIKit

class TwoSumController2: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nums = [2,7,11,15]
        let target = 26
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug(self.twoSum2(nums, target))
        }
    }
    // 暴力法
    // 时间复杂度: O(n^2)
    // 控件复杂度： O(1)
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        for i in 0..<numbers.count {
            for j in (i + 1)..<numbers.count {
                if numbers[i] + numbers[j] == target {
                    return [i+1, j+1]
                }
            }
        }
        return []
    }
    // 二分查找
    // 时间复杂度: O(n logN)
    // 控件复杂度： O(1)
    func twoSum1(_ numbers: [Int], _ target: Int) -> [Int] {
        for i in 0..<numbers.count {
            let first = numbers[i]
            // 在 [i+1 , numbers.count - 1] 区间查找
            let index = binarySearch(numbers, left: i + 1, right: numbers.count - 1, target: target - first)
            if index != -1 {
                return [i + 1, index + 1]
            }
        }
        return []
    }
    // 二分查找 O(logN)
    func binarySearch(_ numbers: [Int],left: Int, right: Int, target: Int) -> Int {
        var left = left
        var right = right
        while left <= right {
            let mid = left + (right - left)/2
            if numbers[mid] == target {
                return mid
            } else if numbers[mid] > target {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        return -1
    }
    // 双指针 有序数组
    // 时间复杂度: O(n)
    // 控件复杂度： O(1)
    func twoSum2(_ numbers: [Int], _ target: Int) -> [Int] {
        // 定义两个指针
        // 左侧开始
        var left = 0
        // 右侧开始
        var right = numbers.count - 1
        while left < right {
            let sum = numbers[left] + numbers[right]
            if sum == target {
                return [left+1, right+1]
            } else if sum < target {
                // 相加小于target 则增大左侧指针
                left += 1
            } else {
                right -= 1
            }
        }
        return [-1,-1]
    }
}
