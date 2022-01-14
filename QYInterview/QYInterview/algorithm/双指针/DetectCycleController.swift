//
//  DetectCycleController.swift
//  QYInterview
//
//  Created by cyd on 2022/1/13.
// 142.环形链表II
/**
 https://leetcode-cn.com/problems/linked-list-cycle-ii/
 题意： 给定一个链表，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。

 为了表示给定链表中的环，使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。 如果 pos 是 -1，则在该链表中没有环。
 
 */
import UIKit

class DetectCycleController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let head = head()
        ListNodeHelper.printList(head)
        let new = detectCycle(head)
        ListNodeHelper.printList(new)
        exit(1)
    }
    
    func detectCycle(_ head: ListNode?) -> ListNode? {
        var slow: ListNode? = head
        var fast: ListNode? = head
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            if slow == fast {
                // 环内相遇
                var list1: ListNode? = slow
                var list2: ListNode? = head
                while list1 != list2 {
                    list1 = list1?.next
                    list2 = list2?.next
                }
                return list2
            }
        }
        return nil
    }
    
    func head() -> ListNode? {
        return ListNode(3, ListNode(2,ListNode(0,ListNode(-4))))
    }
}
