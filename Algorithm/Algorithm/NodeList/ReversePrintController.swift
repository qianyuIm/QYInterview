//
//  ReversePrintController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/13.
//
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
fileprivate class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    func log() {
        var node: ListNode?  = self
        while node != nil {
            print(node!.val)
            node = node?.next
        }
    }
}
class ReversePrintController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let node1 = ListNode(1)
        let node2 = ListNode(2)
        let node3 = ListNode(3)
        let node4 = ListNode(4)
        let node5 = ListNode(5)
        let node6 = ListNode(6)

        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        node5.next = node6

        logDebug("原始链表")
        node1.log()
        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug("打印链表")
            logDebug(self.reversePrint1(node1))
        }
    }
    
    fileprivate func reversePrint(_ head: ListNode?) -> [Int] {
        if head == nil {
            return []
        }
        var listNodes: [Int] = []
        var cur = head
        while cur != nil {
            listNodes.insert(cur!.val, at: 0)
            cur = cur?.next
        }
//        listNodes.reverse()
        return listNodes
    }
    fileprivate func reversePrint1(_ head: ListNode?) -> [Int]  {
        guard let head = head else {
            logDebug("one")
            return []
        }
        logDebug("two")

        var result = reversePrint1(head.next)

        result.append(head.val)
        return result
        
    }
    


    
}
