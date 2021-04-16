//
//  CompressController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/14.
//
/**
 字符串压缩。利用字符重复出现的次数，编写一种方法，实现基本的字符串压缩功能。比如，字符串aabcccccaaa会变为a2b1c5a3。若“压缩”后的字符串没有变短，则返回原先的字符串。你可以假设字符串中只包含大小写英文字母（a至z）。

 示例1:
    输入："aabcccccaaa"
    输出："a2b1c5a3"
 示例2:

    输入："abbccd"
    输出："abbccd"
    解释："abbccd"压缩后为"a1b2c2d1"，比原字符串长度更长。
 提示：

 字符串长度在[0, 50000]范围内。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/compress-string-lcci
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */
import UIKit

class CompressController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let string = "aabcccccaaa"
        logDebug("原始字符串 = \(string)")
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug("压缩之后 = \(self.compressString(string))")
        }
    }
    // 暴力  数组更省时
    func compressString(_ string: String) -> String {
        if string.count < 1 {
            return string
        }
        let array = Array(string)
        // 标记重复字符
        var last = array[0]
        var lastNum = 1
        var new = ""
        for i in 1..<array.count {
            if array[i] == last {
                lastNum += 1
            } else {
                new.append("\(last)\(lastNum)")
                last = array[i]
                lastNum = 1
            }
        }
        // 拼接最后一个
        if lastNum != 0 {
            new.append("\(last)\(lastNum)")
        }
        return new.count < string.count ? new : string
    }
    // 暴力  数组更省时
    func compressString1(_ string: String) -> String {
        if string.count < 1 {
            return string
        }
        // 标记重复字符
        var last: Character? = nil
        var lastNum = 0
        var new = ""
        for sub in string {
            if last == nil {
                last = sub
                lastNum = 1
                continue
            }
            if last == sub {
                lastNum += 1
            } else {
                new.append("\(last!)\(lastNum)")
                last = sub
                lastNum = 1
            }
            
        }
        // 拼接最后一个
        if lastNum != 0 {
            new.append("\(last!)\(lastNum)")
        }
        return new.count < string.count ? new : string
    }
    
}
