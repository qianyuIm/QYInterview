//
//  DeleteNodeController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/13.
//
/**
 给定单向链表的头指针和一个要删除的节点的值，定义一个函数删除该节点。

 返回删除后的链表的头节点。

 注意：此题对比原题有改动

 示例 1:

 输入: head = [4,5,1,9], val = 5
 输出: [4,1,9]
 解释: 给定你链表中值为 5 的第二个节点，那么在调用了你的函数之后，该链表应变为 4 -> 1 -> 9.
 示例 2:

 输入: head = [4,5,1,9], val = 1
 输出: [4,5,9]
 解释: 给定你链表中值为 1 的第三个节点，那么在调用了你的函数之后，该链表应变为 4 -> 5 -> 9.
  

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/shan-chu-lian-biao-de-jie-dian-lcof
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
class DeleteNodeController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            logDebug("删除之后的链表")
            self.deleteNode(node1, 4)?.log()
        }
    }
    
    fileprivate func deleteNode(_ head: ListNode?,
                                _ val: Int) -> ListNode? {
        if head == nil {
            return nil
        }
        if head?.val == val {
            return head?.next
        }
        var cur = head
        while cur?.next != nil {
            if cur?.next?.val == val {
                cur?.next = cur?.next?.next
                return head
            } else {
                cur = cur?.next
            }
        }
        return head
       
    }
}
