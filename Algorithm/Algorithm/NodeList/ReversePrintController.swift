//
//  ReversePrintController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/13.
// 剑指 Offer 06. 从尾到头打印链表
/**
 
 输入一个链表的头节点，从尾到头反过来返回每个节点的值（用数组返回）。

 示例 1：
    输入：head = [1,3,2]
    输出：[2,3,1]
 限制：

        0 <= 链表长度 <= 10000
 https://leetcode-cn.com/problems/cong-wei-dao-tou-da-yin-lian-biao-lcof/
 */
import UIKit

class ReversePrintController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let head = ListNodeHelper.creatList(6)
        ListNodeHelper.printList(head)
        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            
        }
    }
    func reversePrint(_ head: ListNode) {
        
    }
    
    
}
