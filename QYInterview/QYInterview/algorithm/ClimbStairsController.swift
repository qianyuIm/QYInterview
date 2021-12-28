//
//  ClimbStairsController.swift
//  QYInterview
//
//  Created by cyd on 2021/10/9.
//  - 爬楼梯算法（斐波那契数列）
/***
 
 假设你正在爬楼梯。需要 n 阶你才能到达楼顶。
 每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？
 注意：给定 n 是一个正整数。
 示例 1：
 输入： 2
 输出： 2
 解释： 有两种方法可以爬到楼顶。

 1 阶 + 1 阶
 2 阶

 示例 2：
 输入： 3
 输出： 3
 解释： 有三种方法可以爬到楼顶。

 1 阶 + 1 阶 + 1 阶
 1 阶 + 2 阶
 2 阶 + 1 阶

 示例 3：
 输入： 4
 输出： 5
 解释： 有五种方法可以爬到楼顶。

 1 阶 + 1 阶 + 1 阶+ 1 阶
 1 阶 + 1 阶 + 2 阶
 1 阶 + 2 阶 + 1 阶
 2 阶 + 1 阶 + 1 阶
 2 阶 + 2 阶

 很明显，这是一个斐波那契数列，即a[n] = a[n-2] + a[n-1]。n的结果都是由前两个值相加得到的。

 作者：我是一个无情的代码杀
 链接：https://juejin.cn/post/7003524501115764743
 来源：稀土掘金
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 
 
 */

import UIKit

class ClimbStairsController: BaseViewController {
    /// 思路是，传入n的值，从0开始计算0-n的值，
    ///  每次计算的时候将n-1和n-2的值都存起来给下次计算使用。
    /// 优点：时间复杂度O(n)，空间复杂度为O(1)，比用闭包思路节省了不少内存空间
    func climbStairs(n: Int) -> Int{
        if (n == 0) {
            return 0;
        } else if (n == 1){
            return 1;
        } else{
            var one = 0
            var two = 1
            var result = 0
            for _ in 0..<n {
                result = one + two;
                one = two;
                two = result;
            }
        return result;
        }
    };

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            let n = 5
            logDebug("输入 => \(n)")
            let result = self.climbStairs(n: n)
            logDebug("输出 => \(result)")
            
        }
    }
    

}
