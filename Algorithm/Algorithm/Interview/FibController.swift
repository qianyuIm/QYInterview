//
//  FibController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/8.
// https://leetcode-cn.com/problems/fibonacci-number/
/***
 斐波那契数，通常用 F(n) 表示，形成的序列称为 斐波那契数列 。该数列由 0 和 1 开始，后面的每一项数字都是前面两项数字的和。也就是：

    F(0) = 0，F(1) = 1
    F(n) = F(n - 1) + F(n - 2)，其中 n > 1
 给你 n ，请计算 F(n) 。

 示例 1：
    输入：2
    输出：1
    解释：F(2) = F(1) + F(0) = 1 + 0 = 1
 示例 2：
    输入：3
    输出：2
    解释：F(3) = F(2) + F(1) = 1 + 1 = 2
 示例 3：
    输入：4
    输出：3
    解释：F(4) = F(3) + F(2) = 2 + 1 = 3
 示例 4：
    输入：5
    输出：5
    解释：F(5) = F(4) + F(3) = 3 + 2 = 5
 
 

 提示：
    0 <= n <= 30

 */
import UIKit

class FibController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug(self.fib(3))
            
        }
    }
    // 刚开始 开辟出全部N的数组 数组都为1
    // N小于2 为常量 0 or 1  直接返回
    // 剩余大于等于2 的则根据公式 F(n) = F(n - 1) + F(n - 2)，其中 n > 1
    // 动态规划
    func fib(_ n: Int) -> Int {
        if n < 2 {
            return n
        }
        var arr = [Int](repeating: 1, count: n)
        for i in 2..<n {
            arr[i] =  arr[i-1] + arr[i-2]
        }
        return arr[n - 1]
        
    }
}
