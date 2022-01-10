//
//  ReplaceSpaceController.swift
//  QYInterview
//
//  Created by cyd on 2022/1/10.
//  剑指Offer 05.替换空格
// https://leetcode-cn.com/problems/ti-huan-kong-ge-lcof/
/**
 请实现一个函数，把字符串 s 中的每个空格替换成"%20"。

 示例 1： 输入：s = "We are happy."
 输出："We%20are%20happy."

 
 */
import UIKit

class ReplaceSpaceController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let s = "We are happy."
        let new = replaceSpace(s)
        logDebug("替换空格 \(new)")
    }
    /// 先转化为数组
    /// 然后数组扩容
    ///
    func replaceSpace(_ s: String) -> String {
        var strArray = Array(s)
        // 计算空格个数
        var count = 0
        for i in strArray {
            if i == " " {
                count += 1
            }
        }
        // 旧数组最后一个元素
        var left = strArray.count - 1
        // 扩容后数组最后一个元素(还没扩容)
        var right = strArray.count + count * 2 - 1
        // 扩容
        for _ in 0..<(count * 2) {
            strArray.append(" ")
        }
        while left < right {
            if strArray[left] == " " {
                strArray[right] = "0"
                strArray[right - 1] = "2"
                strArray[right - 2] = "%"
                left -= 1
                right -= 3
            } else {
                strArray[right] = strArray[left]
                left -= 1
                right -= 1
            }
        }
        return String(strArray)
    }
}
