//
//  ReverseStringController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/22.
//
/**
 编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 char[] 的形式给出。

 不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。

 你可以假设数组中的所有字符都是 ASCII 码表中的可打印字符。

 示例 1：

    输入：["h","e","l","l","o"]
    输出：["o","l","l","e","h"]

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/reverse-string
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
import UIKit

class ReverseStringController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var s: [Character] = ["H","a","n","n","a","h"]
        logDebug("原始字符串 = \(s)")
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            self.reverseString(&s)
            logDebug("反转之后 = \(s)")
        }
    }
    // 双指针 交换即可  边界条件注意设置为 <
    func reverseString(_ s: inout [Character]) {
        if s.count < 1 {
            return
        }
        var left = 0
        var right = s.count - 1
        while left < right {
            let temp = s[left]
            s[left] = s[right]
            s[right] = temp
            left += 1
            right -= 1
        }
        
        
    }
}
