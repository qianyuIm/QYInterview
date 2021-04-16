//
//  ReverseListController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/13.
//
/**
 206 . 反转一个单链表。

 示例:

 输入: 1->2->3->4->5->NULL
 输出: 5->4->3->2->1->NULL
 进阶:
 你可以迭代或递归地反转链表。你能否用两种方法解决这道题？



 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/reverse-linked-list
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
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
class ReverseListController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
            logDebug("反转后链表")
            self.reverseList1(node1)?.log()
        }
    }
    // 双指针法 或者叫 迭代法
    fileprivate func reverseList(_ head: ListNode?) -> ListNode? {
        var pre: ListNode? = nil
        var cur = head
        // 临时变量
        while cur != nil {
            let next = cur?.next
            cur?.next = pre
            pre = cur
            cur = next
        }
        return pre
    }
    // 递归解法
    // https://leetcode-cn.com/problems/reverse-linked-list/solution/yi-bu-yi-bu-jiao-ni-ru-he-yong-di-gui-si-67c3/
    fileprivate func reverseList1(_ head: ListNode?) -> ListNode? {
        if head == nil {
            return nil
        }
        if head?.next == nil {
            return head
        }
        // 递归获取最新的头结点
        let newHead = reverseList1(head?.next)
        // 反转结点 假设 head  = 1
        // 1 -> 2 -> nil
        //  2 -> 1
        head?.next?.next = head
        // 2 -> 1 -> nil
        head?.next = nil
        logDebug("来了")
        return newHead
    }
}
