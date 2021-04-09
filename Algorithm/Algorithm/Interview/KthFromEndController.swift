//
//  KthFromEndController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/9.
//
/**
 输入一个链表，输出该链表中倒数第k个节点。为了符合大多数人的习惯，本题从1开始计数，即链表的尾节点是倒数第1个节点。

 例如，一个链表有 6 个节点，从头节点开始，它们的值依次是 1、2、3、4、5、6。这个链表的倒数第 3 个节点是值为 4 的节点。
  
 示例：

    给定一个链表: 1->2->3->4->5, 和 k = 2.

    返回链表 4->5.

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/lian-biao-zhong-dao-shu-di-kge-jie-dian-lcof
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
  
}
class KthFromEndController: BaseViewController {

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
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            let first = self.getKthFromEnd1(node1, 2)
            logDebug(first?.val)
        }
    }
    
    fileprivate func getKthFromEnd(_ head: ListNode?,
                                   _ k: Int) -> ListNode? {
        guard let head = head else { return nil }
        // 将node 放入数组中
        var list = [ListNode]()
        var temp: ListNode?  = head
        while temp != nil {
            list.append(temp!)
            temp = temp?.next
        }
        return list[list.count - k]
    }
    fileprivate func getKthFromEnd1(_ head: ListNode?,
                                   _ k: Int) -> ListNode? {
        // 快慢指针，快指针先走k步，然后快慢指针同步走。
        // 当快指针为空时，当前慢指针就是想要倒数第k个节点。
        guard let head = head else { return nil }
        var fast: ListNode? = head
        var slow: ListNode? = head
        var fastK = k
        while fastK != 0 {
            fast = fast?.next
            fastK -= 1
        }
        while fast != nil {
            fast = fast?.next
            slow = slow?.next
        }
        return slow
    }
}
