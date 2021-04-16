//
//  LengthOfLongestSubstringController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/13.
//
/**
 请从字符串中找出一个最长的不包含重复字符的子字符串，计算该最长子字符串的长度。

  

 示例 1:
    输入: "abcabcbb"
    输出: 3
    解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
 
 示例 2:
    输入: "bbbbb"
    输出: 1
    解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
 
 示例 3:
 
    输入: "pwwkew"
    输出: 3
    解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
      请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/zui-chang-bu-han-zhong-fu-zi-fu-de-zi-zi-fu-chuan-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/zui-chang-bu-han-zhong-fu-zi-fu-de-zi-zi-fu-chuan-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */
import UIKit

class LengthOfLongestSubstringController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let string = "abcabcbb"
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug(self.lengthOfLongestSubstring(string))
        }
        
    }
    /*遍历字符串放入数组
    *1.当前字符在数组中之前是否出现过
    *2.出现过，删除之前一个字符包含它之前的
    *3.添加当前字符到数组中
    *4.最大值是否>当前无重复字符串数组的元素个数
*/

    func lengthOfLongestSubstring(_ s: String) -> (String, Int) {
        // 创建个数组存储
        var charArray:[Character] = []
        // 创建个子串
        var subString = ""
        var maxLength = 0
        for char in s {
            // 判断数组中是否包含
            if charArray.contains(char) {
                // 重复出现的位置
                let oldIndex = charArray.firstIndex(of: char)!
                // 移除
                charArray.removeFirst(oldIndex + 1)
            }
            // 记录
            charArray.append(char)
            if maxLength < charArray.count {
                maxLength = charArray.count
                subString = ""
                for char in charArray {
                    subString.append(char)
                }
            }
        }
        return (subString,maxLength)
    }
}
