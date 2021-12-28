import UIKit
import Darwin

/// 二分查找
var b_nums = [1,3,5,6,7,9,10]
var b_target: Int = 5
let b_index = binarySearch(b_nums, b_target)

///// 第一个错误版本
//var version = Int(pow(2.0, 4.0))
//var badVersion = firstBadVersion(version)
//
///// 搜索插入位置
//searchNums = [1,3,5]
//target = 3
//targetIndex = searchInsert(searchNums, target)
