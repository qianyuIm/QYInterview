//
//  KthGrammarController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/15.
//
/**
 779. 第K个语法符号
 在第一行我们写上一个 0。接下来的每一行，将前一行中的0替换为01，1替换为10。

 给定行数 N 和序数 K，返回第 N 行中第 K个字符。（K从1开始）
 例子:

    输入: N = 1, K = 1
    输出: 0

    输入: N = 2, K = 1
    输出: 0

    输入: N = 2, K = 2
    输出: 1

    输入: N = 4, K = 5
    输出: 1

 解释:
    第一行: 0
    第二行: 01
    第三行: 0110
    第四行: 01101001

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/k-th-symbol-in-grammar
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
import UIKit

class KthGrammarController: BaseViewController {
    #warning("没写出来")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let N = 10
        let K = 10
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug(self.kthGrammar(N,K))
        }
    }
    
    func kthGrammar(_ N: Int, _ K: Int) -> Int {
            
       return 0
    }

}
