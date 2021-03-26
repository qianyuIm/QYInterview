//
//  MergesTwoOrderedArraysController.swift
//  Algorithm
//
//  Created by cyd on 2021/3/26.
// https://leetcode-cn.com/problems/merge-sorted-array/

import UIKit
// 给你两个有序整数数组 nums1 和 nums2，请你将 nums2 合并到 nums1 中，使 nums1 成为一个有序数组。

// 初始化 nums1 和 nums2 的元素数量分别为 m 和 n 。你可以假设 nums1 的空间大小等于 m + n，这样它就有足够的空间保存来自 nums2 的元素。

/*
 解题思路：
 1.设置两个指针分别指向num1和num2最后一个元素，再用一个指针指向num1最后一个位置
 2. 拿num1 和 num2 最后一个元素对比，将较大者放入num1最后一位指针处，并将该指针向前移动一位，并将较大值数组的指针也向前一位。
 3. 循环上述步骤，直到num2数组下标为0，则排序完成
 4. 如果num1 数组下标小于0，则只需要将num2数组一次赋值给num1即可
 
 */

class MergesTwoOrderedArraysController: BaseViewController {

    var array1 = [1,3,5,5,7,0,0,0,0,0]
    let array2 = [1,2,4,6,8]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            self.merge(&self.array1, 5, self.array2, 5)
        }
    }
    func merge(_ nums1: inout [Int],
               _ m: Int,
               _ nums2: [Int],
               _ n: Int) {

        var l1 = m - 1
        var l2 = n - 1
        var cur = m + n - 1
        while l2 >= 0 {
            if l1 >= 0 && nums1[l1] > nums2[l2] {
                nums1[cur] = nums1[l1]
                l1 -= 1
            } else { // l1 < 0 || nums2[l2] >= nums1[l1]
                nums1[cur] = nums2[l2]
                l2 -= 1
            }
            cur -= 1
        }
        logDebug(nums1)
    }
    

}
