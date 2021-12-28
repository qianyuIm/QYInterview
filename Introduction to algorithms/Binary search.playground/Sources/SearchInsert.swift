import Foundation

/**
 给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。
 
 请必须使用时间复杂度为 O(log n) 的算法。
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/search-insert-position
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

public func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    if (nums.count < 1) {
        return 0
    }
    var left = 0
    var right = nums.count - 1
    var mid = 0
    var value = 0
    while left <= right {
        mid = (left + right) / 2
        value = nums[mid]
        if target < value {
            right = mid - 1
        } else if target > value {
            left = mid + 1
        } else {
            print("left1 => \(left),right => \(right)")
            return mid
        }
    }
    print("left => \(left),right => \(right)")
    return left
}
