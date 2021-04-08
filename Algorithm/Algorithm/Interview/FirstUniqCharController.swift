//
//  FirstUniqCharController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/8.
//
/**
 在字符串 s 中找出第一个只出现一次的字符。如果没有，返回一个单空格。 s 只包含小写字母。

 示例:

    s = "abaccdeff"
    返回 "b"

    s = ""
    返回 " "

限制：

    0 <= s 的长度 <= 50000

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/di-yi-ge-zhi-chu-xian-yi-ci-de-zi-fu-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
import UIKit

class FirstUniqCharController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            let first = self.firstUniqChar("aaaaa")
            logDebug(first)
        }
    }
    func firstUniqChar(_ s: String) -> Character {
        // 首先使用key  value保存字符出现的次数
        var dict: [Character: Int] = [:]
        for item in s {
            
            if dict[item] == nil {
                dict[item] = 1
            } else {
                dict[item] = dict[item]! + 1
            }
        }
        // 因为字典是无序的所以
        for item in s {
            if dict[item] == 1 {
                return item
            }
        }
        return " "
    }
}
