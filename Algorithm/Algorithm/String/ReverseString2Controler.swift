//
//  ReverseString2Controler.swift
//  Algorithm
//
//  Created by cyd on 2021/4/22.
//
/**
 541. 反转字符串 II
 
 给定一个字符串 s 和一个整数 k，你需要对从字符串开头算起的每隔 2k 个字符的前 k 个字符进行反转。

    如果剩余字符少于 k 个，则将剩余字符全部反转。
    如果剩余字符小于 2k 但大于或等于 k 个，则反转前 k 个字符，其余字符保持原样。

 示例:

    输入: s = "abcdefg", k = 2
    输出: "bacdfeg"
  

 提示：

    该字符串只包含小写英文字母。
    给定字符串的长度和 k 在 [1, 10000] 范围内。


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/reverse-string-ii
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
import UIKit

class ReverseString2Controler: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let s = "1234567"
        let k = 2
        logDebug("原始字符串 = \(s)")
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug("反转之后 = \(self.reverseStr(s,k))")
        }
    }
    //每隔 2k 个字符操作一次，所以 index 的步长是 2k
    //如果剩余字符串是大于k的话，那么就反转 k 个字符
    //如果剩余字符串是小于k的话，那么就全部反转
    func reverseStr(_ s: String, _ k: Int) -> String {
        if s.count < 1 {
            return s
        }
        var array = [Character](s)
        var index = 0
        while index < array.count {
            let last = index + k - 1
            if last < array.count {
                reverse(&array, left: index, right: last)
            } else {
                reverse(&array, left: index, right: array.count - 1)
            }
            index = index + 2 * k
        }
        return String(array)
    }
    func reverse(_ array: inout [Character], left: Int, right: Int) {
        var left = left
        var right = right
        while left < right {
            let temp = array[left]
            array[left] = array[right]
            array[right] = temp
            left += 1
            right -= 1
        }
    }
}
