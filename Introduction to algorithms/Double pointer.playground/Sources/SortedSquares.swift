import Foundation
/*
 给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。
 输入：nums = [-4,-1,0,3,10]
 输出：[0,1,9,16,100]
 解释：平方后，数组变为 [16,1,0,9,100]
 排序后，数组变为 [0,1,9,16,100]
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/squares-of-a-sorted-array
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */
/*
 数组其实是有序的， 只不过负数平方之后可能成为最大数了。

 那么数组平方的最大值就在数组的两端，不是最左边就是最右边，不可能是中间。

 此时可以考虑双指针法了，i指向起始位置，j指向终止位置。

 */

/// 双指针
/// - Parameter nums:
/// - Returns:
public func sortedSquares(_ nums: [Int]) -> [Int] {
    // 指向新数组最后一个元素
    var k = nums.count - 1
    // 指向原数组第一个元素
    var i = 0
    // 指向原数组最后一个元素
    var j = nums.count - 1
    // 初始化新数组(用-1填充)
    var result = Array<Int>(repeating: -1, count: nums.count)
//    print("初始值 => \(result)")
    // [-4,-1,0,3,10]
    for _ in 0..<nums.count {
        if nums[i] * nums[i] < nums[j] * nums[j] {
            result[k] = nums[j] * nums[j]
            j -= 1
        } else {
            result[k] = nums[i] * nums[i]
            i += 1
        }
        k -= 1
//        print(result)
    }
    
    return result
    
    
}


/// 暴力排序
/// - Parameter nums:
/// - Returns:
public func sortedSquares1(_ nums: [Int]) -> [Int] {
    let newNums = nums.map { num in
        return num * num
    }
    return newNums.sorted()
}
