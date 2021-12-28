import Foundation

/**
 给定一个 n 个元素有序的（升序）整型数组 nums 和一个目标值 target  ，写一个函数搜索 nums 中的 target，如果目标值存在返回下标，否则返回 -1。


 示例 1: 输入: nums = [-1,0,3,5,9,12], target = 9
 输出: 4
 解释: 9 出现在 nums 中并且下标为 4

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/binary-search
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/// 二分查找法
/// - Parameters:
///   - nums: 有序数组
///   - target: 目标值
/// - Returns: 目标值下标
public func binarySearch(_ nums: [Int], _ target: Int) -> Int {
    var lowerBound = 0
    var upperBound = nums.count
    while lowerBound < upperBound {
        let midIndex = lowerBound + (upperBound - lowerBound) / 2
        print("midIndex = \(midIndex)")
        print("midValue = \(nums[midIndex])")
        if nums[midIndex] == target {
            return midIndex
        } else if nums[midIndex] < target {
            lowerBound = midIndex + 1
        } else {
            upperBound = midIndex
        }
    }
    return -1
}
