//
//  SwapPairsController.swift
//  QYInterview
//
//  Created by cyd on 2022/1/24.
// 24. 两两交换链表中的节点
// https://leetcode-cn.com/problems/swap-nodes-in-pairs/
/**
 给定一个链表，两两交换其中相邻的节点，并返回交换后的链表。

 你不能只是单纯的改变节点内部的值，而是需要实际的进行节点交换。
 
 输入：head = [1,2,3,4]
 输出：[2,1,4,3]
 
 */
 
import UIKit

class SwapPairsController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let head = ListNodeHelper.creatList(4)
        ListNodeHelper.printList(head)
        self.touchesBeganBlock = { [weak self] in
            let new = self?.swapPairs(head)
            ListNodeHelper.printList(new)
        }
        
        
    }
    // https://leetcode-cn.com/problems/swap-nodes-in-pairs/solution/dai-ma-sui-xiang-lu-dai-ni-xue-tou-lian-r063e/
    func swapPairs(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
                return head
        }
        // 创建虚拟头结点指向头结点
        let dummyHead: ListNode = ListNode(-1, head)
        var current: ListNode? = dummyHead
        while current?.next != nil && current?.next?.next != nil {
            let temp1 = current?.next
            let temp2 = current?.next?.next?.next
            
            current?.next = current?.next?.next
            current?.next?.next = temp1
            current?.next?.next?.next = temp2
            // cur移动两位，准备下一轮交换
            current = current?.next?.next
        }
        return dummyHead.next
    }
}
