//
//  ReverseWordsController.swift
//  QYInterview
//
//  Created by cyd on 2022/1/11.
//  151.翻转字符串里的单词
/**
 https://leetcode-cn.com/problems/reverse-words-in-a-string/
 给定一个字符串，逐个翻转字符串中的每个单词。

 示例 1：
 输入: "the sky is blue"
 输出: "blue is sky the"

 示例 2：
 输入: "  hello world!  "
 输出: "world! hello"
 解释: 输入字符串可以在前面或者后面包含多余的空格，但是反转后的字符不能包括。

 示例 3：
 输入: "a good   example"
 输出: "example good a"
 解释: 如果两个单词间有多余的空格，将反转后单词间的空格减少到只含一个。
 
 */

import UIKit

class ReverseWordsController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let s = "the  sky  is blue "
        let new = reverseWords(s)
        logDebug("反转字符串为\(new)")
    }
    
    func reverseWords(_ s: String) -> String {
        // 1. 移除多余的空格
        var stringArray = removeSpace(s)
        // 2. 反转整个字符串
        reverseString(&stringArray,
                      startIndex: 0,
                      endIndex: stringArray.count - 1)
        // 3.再次将字符串里面的单词反转
        reverseWord(&stringArray)
        return String(stringArray)
    }
    // 1.
    func removeSpace(_ s: String) -> [Character] {
        let ch = Array(s)
        var left = 0
        var right = ch.count - 1
        // 忽略字符串前面的所有空格
        while ch[left] == " " {
            left += 1
        }
        // 忽略字符串后面的所有空格
        while ch[right] == " " {
            right -= 1
        }
        // 接下来就是要处理中间的多余空格
        var lastArr = Array<Character>()
        while left <= right {
            // 准备加到新字符串当中的字符
            let char = ch[left]
            // 新的字符串的最后一个字符；
            // 或者原字符串中，准备加到新字符串的那个字符；
            // 这两个字符当中，只要有一个不是空格，就可以加到新的字符串当中
            if char != " " || lastArr[lastArr.count - 1] != " "  {
                lastArr.append(char)
            }
            left += 1
        }
        return lastArr
    }
    // 2.
    func reverseString(_ s: inout [Character],
                       startIndex: Int,
                       endIndex: Int) {
        var start = startIndex
        var end = endIndex
        while start < end {
            (s[start], s[end]) = (s[end], s[start])
            start += 1
            end -= 1
        }
    }
    /// 3、再次将字符串里面的单词反转
    func reverseWord(_ s: inout [Character]) {
        var start = 0
        var end = 0
        var entry = false

        for i in 0..<s.count {
            if !entry {
                start = i
                entry = true
            }
          
            if entry && s[i] == " " && s[i - 1] != " " {
                end = i - 1
                entry = false
                reverseString(&s, startIndex: start, endIndex: end)
            }

            if entry && (i == s.count - 1) && s[i] != " " {
                end = i
                entry = false
                reverseString(&s, startIndex: start, endIndex: end)
            }
        }
    }
}
