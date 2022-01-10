//
//  ReverseSingListController.swift
//  QYInterview
//
//  Created by cyd on 2021/1/13.
// - 反转单链表
// 
import UIKit

fileprivate class SingListNode {
    var val: Int
    var next: SingListNode?
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}
class ReverseSingListController: BaseViewController {

    let deep: Int = 6
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let head = ListNodeHelper.creatList(6)
        ListNodeHelper.printList(head)
//        let reverse = recursiveReverseList(head)
//        printList(reverse)

    }
    // 反转单链表
    fileprivate func reverseList(_ head: SingListNode?) -> SingListNode? {
        var pre: SingListNode? = nil
        var cur: SingListNode? = nil
        if head == nil {
            return nil
        }
        var head = head
        while head != nil {
            cur = head
            head = head?.next
            cur?.next = pre
            pre = cur
        }
        return pre
    }
    // 递归
    fileprivate func recursiveReverseList(_ head: SingListNode?) -> SingListNode? {
        return reList(nil, cur: head)
    }
    fileprivate func reList(_ pre: SingListNode?,
                            cur: SingListNode?) -> SingListNode? {
        guard let _cur = cur else {
            return pre
        }
        let res = reList(_cur, cur: _cur.next)
        _cur.next = pre
        return res
    }
    
    fileprivate func creatList() -> SingListNode? {
        // 头结点
        var head: SingListNode? = nil
        // 尾结点
        var cur: SingListNode? = nil
        for index in 1..<deep {
            let node = SingListNode(index)
            if head == nil {
                head = node
            } else {
                cur?.next = node
            }
            cur = node
        }
        return head
    }
    fileprivate func printList(_ head: SingListNode?) {
        var temp: SingListNode? = head
        logDebug("list is:")
        while temp != nil {
            logDebug(temp!.val)
            temp = temp?.next
        }
        logDebug("null")
    }
}
