//
//  IntersectionNodeController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/15.
//
/**
 剑指 Offer 52. 两个链表的第一个公共节点
 输入两个链表，找出它们的第一个公共节点。
 
    intersectVal = 2, listA = [0,9,1,2,4], listB = [3,2,4]
    intersectVal = 0, listA = [2,6,4], listB = [1,5]
 
 https://leetcode-cn.com/problems/liang-ge-lian-biao-de-di-yi-ge-gong-gong-jie-dian-lcof/solution/ji-he-shuang-zhi-zhen-deng-3chong-jie-jue-fang-shi/
 */
import UIKit
fileprivate class ListNode: Equatable {
    static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.val == rhs.val
    }
    
    var val: Int
    var next: ListNode?
    init() {
        self.val = 0
        self.next = nil
    }
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    // 1,2,3
    class func creat(_ array: [Int]) -> ListNode {
        var head = ListNode()
        var next = ListNode()
        next = head
        for val in array {
            let node = ListNode(val)
            next.next = node
            next = node
        }
        if head.next != nil {
            head = head.next!
        }
        return head
    }
    func log() {
        var node: ListNode?  = self
        while node != nil {
            print(node!.val)
            node = node?.next
        }
    }
    func length() -> Int {
        var head: ListNode? = self
        var count = 0
        while head != nil {
            count += 1
            head = head?.next
        }
        return count
    }
}
class IntersectionNodeController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        intersectVal = 2, listA = [0,9,1,2,4], listB = [3,2,4]

        // Do any additional setup after loading the view.
        
        let headA = ListNode.creat([0,9,1,2,4])
//        let headA = ListNode.creat([1,5,6])

        let headB = ListNode.creat([3,2,4])

        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug(self.getIntersectionNode1(headA,headB)?.val ?? 1000 )
        }
    }
    // 第一种方法： 判断两个链表长度是否一致，不一致的话长链表先走
    // 一直走到与短链表长度先等的位置，
    // 相交位置之后的链表数据相同
    fileprivate func getIntersectionNode(_ headA: ListNode,
                                         _ headB: ListNode) -> ListNode? {
        
        var headALength = headA.length()
        var headBLength = headB.length()
        var headA: ListNode? = headA
        var headB: ListNode? = headB
        // 使两个链表长度相等
        while headALength != headBLength {
            if headALength > headBLength {
                headA = headA?.next
                headALength -= 1
            }
            if headALength < headBLength {
                headB = headB?.next
                headBLength -= 1
            }
        }
        while headA != headB {
            headA = headA?.next
            headB = headB?.next
        }
        //走到最后，最终会有两种可能，一种是headA为空，
        //也就是说他们俩不相交。还有一种可能就是headA
        //不为空，也就是说headA就是他们的交点

        return headA
    }
    // 第二种方式
    // headA 长度为 a
    // headB 长度为 b
    // 假设有个相交点node 位置为 c
    // 则相对于headA来说 需要走 a - c 步 才能到达 node
    // 则相对于headB来说 需要走 b - c 步 才能到达 node
    // 如果 headA 与 headB 长度不同的话 同时走是不会相交的
    // 可以走完自己的再走别人的  这样长度就一致了
    // (a - c) + b = (b - c) + a
    fileprivate func getIntersectionNode1(_ headA: ListNode,
                                         _ headB: ListNode) -> ListNode? {
        var tempA: ListNode? = headA
        var tempB: ListNode? = headB
        while tempA != tempB {
            tempA = (tempA == nil) ? headB : tempA?.next
            tempB = (tempB == nil) ? headA : tempB?.next
        }
        return tempA
    }

}
