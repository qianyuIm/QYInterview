//
//  RepeatedSubstringPatternController.swift
//  Algorithm
//
//  Created by cyd on 2021/3/25.
//  https://leetcode-cn.com/problems/repeated-substring-pattern/

/*
 * 给定一个非空的字符串，判断它是否可以由它的一个子串重复多次构成。
 * 给定的字符串只含有小写英文字母，并且长度不超过10000。
 *
 */

import UIKit

class RepeatedSubstringPatternController: BaseViewController {

    let s = "aabbccdd"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug("\(self.s) -- \(self.repeatedSubstringPattern(self.s))")
        }
    }
    // 思路： 使用拼接法，两个s拼接，去掉首尾，如果截取后的字符串还包含s，则说明s是个重复字符串，如果s长度小于1直接false
    // 假如  s = "abab" 则 两个 s ss = "abababab" 去掉首尾 成为 "bababa" 包含 s = "abab" 说明 s是重复字符串
    func repeatedSubstringPattern(_ s: String) -> Bool {
        // 直接false
        if s.count <= 1 {
            return false
        }
        var result = s + s;
        // 去掉首尾
//        let range =
        result = String(result[result.index(result.startIndex, offsetBy: 1)..<result.index(result.endIndex, offsetBy: -1)])

        return result.contains(s)
    }

}
