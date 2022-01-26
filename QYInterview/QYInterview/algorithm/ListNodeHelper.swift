//
//  ListNodeHelper.swift
//  QYInterview
//
//  Created by cyd on 2022/1/10.
//

import Foundation

class ListNode {
    var val: Int
    var next: ListNode?
    init() { self.val = 0; self.next = nil; }
    init(_ val: Int) { self.val = val; self.next = nil; }
    init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

extension ListNode: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(val)
        hasher.combine(ObjectIdentifier(self))
    }
    static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs === rhs
    }
}

class ListNodeHelper {
    class func printList(_ head: ListNode?) {
        var temp: ListNode? = head
        logDebug("list is:", separator: " ", terminator: " ")
        while temp != nil {
            logDebug(temp!.val, separator: " ", terminator: " -> ")

            temp = temp?.next
        }
        logDebug("null", separator: " ", terminator: "\n")

    }
    /// 创建单链表
    /// - Parameter count:
    class func creatList(_ deep: Int) -> ListNode? {
        // 头结点
        var head: ListNode? = nil
        // 尾结点
        var cur: ListNode? = nil
        for index in 1...deep {
            let node = ListNode(index)
            if head == nil {
                head = node
            } else {
                cur?.next = node
            }
            cur = node
        }
        return head
    }
}
