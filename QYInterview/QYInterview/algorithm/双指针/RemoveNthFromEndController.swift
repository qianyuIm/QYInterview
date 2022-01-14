//
//  RemoveNthFromEndController.swift
//  QYInterview
//
//  Created by cyd on 2022/1/12.
// 19. 删除链表的倒数第 N 个结点
/**
 https://leetcode-cn.com/problems/remove-nth-node-from-end-of-list/
 给你一个链表，删除链表的 **倒数**  第 n 个结点，并且返回链表的头结点。
 输入：head = [1,2,3,4,5], n = 2
 输出：[1,2,3,5]
 */

import UIKit

class RemoveNthFromEndController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let head = ListNodeHelper.creatList(6)
        ListNodeHelper.printList(head)
        let n = 1
        let new = removeNthFromEnd(head, n)
        ListNodeHelper.printList(new)
    }
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        if head == nil || n == 0 {
            return head
        }
        // 设置虚拟节点
        let dummyHead = ListNode(-1, head)
        var fast: ListNode?  = dummyHead
        var slow: ListNode? = dummyHead
        // fast 前移 n
        for _ in 0..<n {
            fast = fast?.next
        }
        while fast?.next != nil {
            fast = fast?.next
            slow = slow?.next
        }
        slow?.next = slow?.next?.next
        return dummyHead.next
    }
}
