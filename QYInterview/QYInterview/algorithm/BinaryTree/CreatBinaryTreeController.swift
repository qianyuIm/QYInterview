//
//  CreatBinaryTreeController.swift
//  QYInterview
//
//  Created by cyd on 2021/1/14.
//

import UIKit
private class BinaryTreeNode {
    var value: String
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    init(_ value: String) {
        self.value = value
        self.left = nil
        self.right = nil
    }
    init(_ value: String,
         left: BinaryTreeNode?,
         right: BinaryTreeNode?) {
        self.value = value
        self.left = left
        self.right = right
    }
}
private class BinaryTree {
    var root: BinaryTreeNode?
    private var items: [String]
    private var index: Int = -1
    init(_ items: [String]) {
        self.items = items
        root = preOrderCreateTree()
    }
    /// 以先序递归的方式创建二叉树
    /// - Returns:
    func preOrderCreateTree() -> BinaryTreeNode? {
        self.index = self.index + 1
        if index < self.items.count && index >= 0 {
            let item = self.items[index]
            if item == "" {
                return nil
            } else {
                let node = BinaryTreeNode(item)
                // 递归创建左子树
                node.left = preOrderCreateTree()
                // 递归创建右子树
                node.right = preOrderCreateTree()
                return node
            }
        }
        return nil
    }
    /**
     先序遍历：先遍历根节点，再遍历左子树，最后遍历右子树
     */
    func preOrderTraverse() {
        logDebug("先序遍历：先遍历根节点，再遍历左子树，最后遍历右子树")
        preOrderTraverse(root)
        logDebug("\n")
    }
    private func preOrderTraverse(_ node: BinaryTreeNode?) {
        guard let node = node else {
            logDebug("空", separator: "", terminator: " ")
            return
        }
        logDebug(node.value, separator: "", terminator: " ")
        //递归遍历左子树
        preOrderTraverse(node.left)
        //递归遍历右子树
        preOrderTraverse(node.right)
    }
    /**
     中序遍历：先遍历左子树，再遍历根节点，最后遍历右子树
     */
    func inOrderTraverse() {
        logDebug("中序遍历：先遍历左子树，再遍历根节点，最后遍历右子树")
        inOrderTraverse(root)
        logDebug("\n")
    }
    private func inOrderTraverse(_ node: BinaryTreeNode?) {
        guard let node = node else {
            logDebug("空", separator: "", terminator: " ")
            return
        }
        //递归遍历左子树
        inOrderTraverse(node.left)
        logDebug(node.value, separator: "", terminator: " ")
        //递归遍历右子树
        inOrderTraverse(node.right)
    }
    /**
     后序遍历：先遍历左子树，再遍历右子树，最后遍历根节点
     */
    func afterOrderTraverse() {
        logDebug("后序遍历：先遍历左子树，再遍历右子树，最后遍历根节点")
        afterOrderTraverse(root)
        logDebug("\n")
    }
    private func afterOrderTraverse(_ node: BinaryTreeNode?) {
        guard let node = node else {
            logDebug("空", separator: "", terminator: " ")
            return
        }
        //递归遍历左子树
        afterOrderTraverse(node.left)
        //递归遍历右子树
        afterOrderTraverse(node.right)
        logDebug(node.value, separator: "", terminator: " ")
    }
    
}
class CreatBinaryTreeController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let items = ["A", "B", "D", "", "", "E", "", "", "C", "","F", "", ""]
        let binaryTree = BinaryTree(items)
        binaryTree.preOrderTraverse()
        binaryTree.inOrderTraverse()
        binaryTree.afterOrderTraverse()
    }
}
