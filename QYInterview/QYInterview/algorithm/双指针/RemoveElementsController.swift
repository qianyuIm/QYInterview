//
//  RemoveElementsController.swift
//  QYInterview
//
//  Created by cyd on 2022/1/10.
// 203.移除链表元素
// https://leetcode-cn.com/problems/remove-linked-list-elements/
/**
 给你一个链表的头节点 head 和一个整数 val ，请你删除链表中所有满足 Node.val == val 的节点，并返回 新的头节点 。
 示例 1：
 输入：head = [1,2,6,3,4,5,6], val = 6
 输出：[1,2,3,4,5]

 示例 2：
 输入：head = [], val = 1
 输出：[]

 示例 3：
 输入：head = [7,7,7,7], val = 7
 输出：[]

 */


import UIKit



class RemoveElementsController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let head = ListNodeHelper.creatList(6)
        ListNodeHelper.printList(head)
        let new = removeElements(head, 3)
        ListNodeHelper.printList(new)
    }
    /// 移除链表元素
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        let dummyNode = ListNode()
        dummyNode.next = head
        var currentNode = dummyNode
        while let curNext = currentNode.next {
            if curNext.val == val {
                currentNode.next = curNext.next
            } else {
                currentNode = curNext
            }
        }
        return dummyNode.next
    }
    

}
