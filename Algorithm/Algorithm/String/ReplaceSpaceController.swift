//
//  ReplaceSpaceController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/16.
//
/**
 剑指 Offer 05. 替换空格
 请实现一个函数，把字符串 s 中的每个空格替换成"%20"。

  

 示例 1：

 输入：s = "We are happy."
 输出："We%20are%20happy."
  

 限制：

    0 <= s 的长度 <= 10000
 
 https://leetcode-cn.com/problems/ti-huan-kong-ge-lcof/
 */
import UIKit

class ReplaceSpaceController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let string = "We are happy."
        logDebug("原始字符串 = \(string)")
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug("替换之后 = \(self.replaceSpace(string))")
        }
    }
    

    func replaceSpace(_ s: String) -> String {
        if s.isEmpty {
            return s
        }
        let aa = s.components(separatedBy: " ")
        var new = ""
        for i in 0..<aa.count {
            let item = aa[i]
            if i == aa.count - 1 {
                new.append(item)
            } else {
                new.append("\(item)%20")
            }
        }
        return new
    }
    // 双指针 扩容  因为要操作数组和字符的转换 反而变慢了 0.0
    func replaceSpace1(_ s: String) -> String {
        
        // 双指针 扩容
        // 字符不好操作，换为数组
        var chars = Array(s)
        // 存储之前大小
        let preCount = chars.count
        for item in chars {
            // 遇到一个空格则扩大两个长度，
            // %20 是三个长度
            if item == " " {
                chars.append(" ")
                chars.append(" ")
            }
        }
        // 指向新字符串结尾
        var i = chars.count - 1
        // 指向老字符串结尾
        var j = preCount - 1
        while i >= 0 && j >= 0 {
            // 如果老数组不为空格 则直接平移
            if chars[j] != " " {
                chars[i] = chars[j]
            } else {
                chars[i] = "0"
                chars[i - 1] = "2"
                chars[i - 2] = "%"
                j -= 2
            }
            i -= 1
            j -= 1
        }
        return String(chars)
    }


}
