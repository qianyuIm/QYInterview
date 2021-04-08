//
//  ReverseWordsController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/8.
//
/**
 输入一个英文句子，翻转句子中单词的顺序，但单词内字符的顺序不变。为简单起见，标点符号和普通字母一样处理。例如输入字符串"I am a student. "，则输出"student. a am I"。



 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/fan-zhuan-dan-ci-shun-xu-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
import UIKit

class ReverseWordsController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            let first = self.reverseWords(" the sky is blue! ")
            logDebug(first)
        }
    }
    func reverseWords(_ s: String) -> String {
        var arr = s.components(separatedBy: " ")
        arr = arr.reversed()
        var arr1 = [String]()
        for item in arr {
            if item != "" {
                arr1.append(item)
            }
        }
        let str = arr1.joined(separator: " ")
        return str

    }
    func reverseWords1(_ s: String) -> String {
        return s.split(separator: " ")
                    .reversed()
                    .joined(separator: " ")
        
    }
}
