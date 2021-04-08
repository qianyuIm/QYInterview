//
//  PrintNumbersController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/8.
// https://leetcode-cn.com/problems/da-yin-cong-1dao-zui-da-de-nwei-shu-lcof/
/**
 
 输入数字 n，按顺序打印出从 1 到最大的 n 位十进制数。比如输入 3，则打印出 1、2、3 一直到最大的 3 位数 999。

 示例 1:
    输入: n = 1
    输出: [1,2,3,4,5,6,7,8,9]
 说明：
    用返回一个整数列表来代替打印
    n 为正整数
 */
import UIKit

class PrintNumbersController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug(self.printNumbers(2))
        }
        
    }
    
    func printNumbers(_ n: Int) -> [Int] {
        var arr = [Int]()
        var num = "1"
        for _ in 1...n {
            num += "0"
        }
        if let num1 = Int(num) {
            let num2 = num1 - 1
            for item in 1...num2 {
                arr.append(item)
            }
        }
        return arr
    }
    func printNumbers1(_ n: Int) -> [Int] {
        var arr = [Int]()
        let num = Int(pow(10, n).description)!
        for item in 1..<num {
            arr.append(item)
        }
        return arr
    }
    

}
