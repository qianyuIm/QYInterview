//
//  ReverseVowelsController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/22.
//
/**
 编写一个函数，以字符串作为输入，反转该字符串中的元音字母。

 示例 1：

    输入："hello"
    输出："holle"
 示例 2：

    输入："leetcode"
    输出："leotcede"
  

 提示：

    元音字母不包含字母 "y" 。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/reverse-vowels-of-a-string
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */
import UIKit

class ReverseVowelsController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let s = "leetcode"
        let s = "aA"
//        let s = ".,"
//        let s = "a."
        logDebug("原始字符串 = \(s)")
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug("反转之后 = \(self.reverseVowels(s))")
        }
    }
    
    // 元音字母 a e i o u
    func reverseVowels(_ s: String) -> String {
        if s.count < 1{
            return s
        }
        let vowels: [Character] = ["a","e","i","o","u","A","E","I","O","U"]
        var sArray = Array(s)
        var left = 0
        var right = sArray.count - 1
        let count = s.count - 1
        
        while left < right {
            // 判断是否为元音字母 不是则跳过 还有边界条件
            while !vowels.contains(sArray[left]) && left < count {
                left += 1
            }
            while !vowels.contains(sArray[right]) && right > 0 {
                right -= 1
            }
            // 需要放置交换之后 重复进入 所以加一个前置条件
            if left < right {
                sArray.swapAt(left, right)
                left += 1
                right -= 1
            }
        }
        return String(sArray)
        
    }

}
