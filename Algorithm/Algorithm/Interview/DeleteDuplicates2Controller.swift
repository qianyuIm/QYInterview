//
//  DeleteDuplicates2Controller.swift
//  Algorithm
//
//  Created by cyd on 2021/3/25.
//

import UIKit
fileprivate class ListNode {
    
    var val: Int
    var next: ListNode?
    init() {
        self.val = 0;
        self.next = nil;
    }
    init(_ val: Int) {
        self.val = val;
        self.next = nil;
    }
    init(_ val: Int, _ next: ListNode?) {
        self.val = val;
        self.next = next;
    }
    func log() {
        var temp: ListNode? = self
        while temp != nil {
            logDebug(temp!.val)
            if temp!.next == nil {
                break
            }
            temp = temp!.next
        }
    }
}
class DeleteDuplicates2Controller: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 创建
        let head = initListNodeFromTail([1,2,3,4,4,5,5,6])
        logDebug("去重之前")
        head.log()
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else {
                return
            }
            let node = self.deleteDuplicates(head)
            logDebug("去重之后")
            node?.log()
        }
    }
    fileprivate func initListNodeFromTail(_ array: [Int]) -> ListNode {
        var node = ListNode()
        var tail = ListNode()
        tail = node
        for data in array {
            let tempNode = ListNode()
            tempNode.val = data
            tail.next = tempNode
            tail = tempNode
        }
        if node.next != nil {
            node = node.next!
        }
        return node
    }
    // 存在一个按升序排列的链表，给你这个链表的头节点 head ，请你删除链表中所有存在数字重复情况的节点，只保留原始链表中 没有重复出现 的数字。
    // 解题思路： 因为是升序链表，所以有相同数则一定连续存在

    fileprivate func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        var result = head
        // 判断head符合条件
        if let current = result, let next = current.next {
            // 判断之后是否有相同
            if current.val == next.val {
                // 相同
                var end: ListNode? = next
                // 直接跳过相同值
                while end != nil && current.val == end!.val {
                    end = end?.next
                }
                result = deleteDuplicates(end)
            } else {
                // 不相同
                current.next = deleteDuplicates(next)
            }
        }
        return result
    }

}
