//
//  ReverseBetweenController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/13.
//
/**
 92. 反转链表 II
 给你单链表的头指针 head 和两个整数 left 和 right ，其中 left <= right 。
 请你反转从位置 left 到位置 right 的链表节点，返回 反转后的链表。
 例子1:
    输入：head = [1,2,3,4,5], left = 2, right = 4
    输出：[1,4,3,2,5]
 例子2:
    输入：head = [5], left = 1, right = 1
    输出：[5]
 链表中节点数目为 n
 1 <= n <= 500
 -500 <= Node.val <= 500
 1 <= left <= right <= n

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/reverse-linked-list-ii
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
class ReverseBetweenController: BaseViewController {

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
            logDebug("反转后链表")
            self.reverseBetween(node1, 2, 4)?.log()
        }
    }
    // 递归
    // https://leetcode-cn.com/problems/reverse-linked-list-ii/solution/yi-bu-yi-bu-jiao-ni-ru-he-yong-di-gui-si-lowt/
    fileprivate func reverseBetween(_ head: ListNode?,
                                    _ left: Int,
                                    _ right: Int) -> ListNode? {
        if left == 1 {
            return reverseTopRight(head, right)
        }
        let between = reverseBetween(head?.next, left - 1, right - 1)
        head?.next = between
        return head
    }
    fileprivate var topRightSuccessor: ListNode? = nil
    fileprivate func reverseTopRight(_ head: ListNode?,
                                     _ right: Int) -> ListNode? {
        if right == 1 {
            topRightSuccessor = head?.next
            return head
        }
        let newHead = reverseTopRight(head?.next, right - 1)
        head?.next?.next = head
        head?.next = topRightSuccessor
        return newHead
    }

}
