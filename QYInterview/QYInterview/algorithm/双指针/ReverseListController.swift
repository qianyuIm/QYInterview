//
//  ReverseListController.swift
//  QYInterview
//
//  Created by cyd on 2022/1/11.
//  206.反转链表
/**
 https://leetcode-cn.com/problems/reverse-linked-list/
 题意：反转一个单链表。

 示例: 输入: 1->2->3->4->5->NULL 输出: 5->4->3->2->1->NULL

 */

import UIKit

class ReverseListController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let head = ListNodeHelper.creatList(6)
        ListNodeHelper.printList(head)
        let new = reverseList(head)
        ListNodeHelper.printList(new)
    }
    /// 双指针法 (迭代)
    func reverseList(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        var pre: ListNode? = nil
        var cur = head
        var temp: ListNode? = nil
        while cur != nil {
            temp = cur?.next
            cur?.next = pre
            pre = cur
            cur = temp
        }
        return pre
    }
    /// 递归
    /// - Parameter head: 头结点
    /// - Returns: 翻转后的链表头结点
    func reverseList2(_ head: ListNode?) -> ListNode? {
        return reverse(pre: nil, cur: head)
    }
    func reverse(pre: ListNode?, cur: ListNode?) -> ListNode? {
        if cur == nil {
            return pre
        }
        let temp: ListNode? = cur?.next
        cur?.next = pre
        return reverse(pre: cur, cur: temp)
    }
}
