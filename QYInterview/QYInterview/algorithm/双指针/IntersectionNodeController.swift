//
//  IntersectionNodeController.swift
//  QYInterview
//
//  Created by cyd on 2022/1/12.
// 面试题 02.07. 链表相交
/**
 https://leetcode-cn.com/problems/intersection-of-two-linked-lists-lcci/
 给你两个单链表的头节点 headA 和 headB ，请你找出并返回两个单链表相交的起始节点。如果两个链表没有交点，返回 null 。
 
 */

import UIKit

class IntersectionNodeController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let headA = headA()
        let headB = headB()
        ListNodeHelper.printList(headA)
        ListNodeHelper.printList(headB)
        
    }
    func headA() -> ListNode? {
        return ListNode(4, ListNode(1,ListNode(8,ListNode(4,ListNode(5,nil)))))
    }
    func headB() -> ListNode? {
        return ListNode(5, ListNode(0,ListNode(1,ListNode(8,ListNode(4,ListNode(5,nil))))))
    }
}
