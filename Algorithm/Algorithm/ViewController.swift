//
//  ViewController.swift
//  Algorithm
//
//  Created by cyd on 2021/3/25.
//

import UIKit
func logDebug(_ message: Any,
              separator: String = " ",
              terminator: String = "\n") {
    print(message, separator: separator, terminator: terminator)
}
class QTTableItem {
    var title: String
    var subTitle: String
    var controllerName: String
    init(with title: String,
         subTitle: String,
         controllerName: String) {
        self.title = title
        self.subTitle = subTitle
        self.controllerName = controllerName
    }
}
class QTTableSectionItem {
    var sectionTitle: String
    var items: [QTTableItem]
    init(with sectionTitle: String,
         items: [QTTableItem]) {
        self.sectionTitle = sectionTitle
        self.items = items
    }
}
class ViewController: UIViewController {
    var dataSource: [QTTableSectionItem] = [
        .init(with: "排序算法", items: [
                .init(with: "冒泡排序", subTitle: "冒泡排序", controllerName: "BubbleSortController"),
                .init(with: "选择排序", subTitle: "选择排序", controllerName: "SelectSortController"),
                .init(with: "快速排序", subTitle: "快速排序", controllerName: "QuickSortController"),
                .init(with: "双路快拍", subTitle: "双路快拍", controllerName: "DoubleQuickSortController"),
                .init(with: "希尔排序", subTitle: "希尔排序", controllerName: "ShellSortController"),
                .init(with: "插入排序", subTitle: "插入排序", controllerName: "InsertSortController"),
                .init(with: "归并排序", subTitle: "归并排序", controllerName: "MergeSortController")]),
        .init(with: "查找算法", items: [
                .init(with: "二分查找法", subTitle: "二分查找法", controllerName: "BinarySearchController")]),
        .init(with: "找规律动态规划", items: [
                .init(with: "779.第K个语法符号", subTitle: "779.第K个语法符号", controllerName: "KthGrammarController")]),
        .init(with: "N数之和", items: [
                .init(with: "1.两数之和", subTitle: "两数之和", controllerName: "TwoSumController1"),
                .init(with: "167.两数之和 II - 输入有序数组", subTitle: "167.两数之和 II - 输入有序数组", controllerName: "TwoSumController2"),
                .init(with: "15.三数之和", subTitle: "15.三数之和", controllerName: "ThreeSumController"),
                .init(with: "18.四数之和", subTitle: "18.四数之和", controllerName: "FourSumController"),
                .init(with: "53. 最大子序和", subTitle: "53. 最大子序和", controllerName: "MaxSubArrayController")]),
        .init(with: "链表", items: [
                .init(with: "06.从尾到头打印链表", subTitle: "06.从尾到头打印链表", controllerName: "ReversePrintController"),
                .init(with: " 52. 两个链表的第一个公共节点", subTitle: " 52. 两个链表的第一个公共节点", controllerName: "IntersectionNodeController")]),
        .init(with: "字符串", items: [
                .init(with: "06.字符串压缩", subTitle: "06.字符串压缩", controllerName: "CompressController"),
                .init(with: "05. 替换空格", subTitle: "05. 替换空格", controllerName: "ReplaceSpaceController"),
                .init(with: "344.反转字符串", subTitle: "344.反转字符串", controllerName: "ReverseStringController"),
                .init(with: "345. 反转字符串中的元音字母", subTitle: "345. 反转字符串中的元音字母", controllerName: "ReverseVowelsController"),
                .init(with: "541. 反转字符串 II", subTitle: "541. 反转字符串 II", controllerName: "ReverseString2Controler")]),
        .init(with: "面试", items: [
                .init(with: "最长不含重复字符的子字符串", subTitle: "最长不含重复字符的子字符串", controllerName: "LengthOfLongestSubstringController"),
                .init(with: "删除链表的节点", subTitle: "删除链表的节点", controllerName: "DeleteNodeController"),
                .init(with: "反转单链表", subTitle: "反转单链表", controllerName: "ReverseListController"),
                .init(with: "反转指定位置的链表", subTitle: "反转指定位置的链表", controllerName: "ReverseBetweenController"),
                .init(with: "表中倒数第k个节点", subTitle: "表中倒数第k个节点", controllerName: "KthFromEndController"),
                .init(with: "找字符串里重复次数最多的字符", subTitle: "找字符串里重复次数最多的字符", controllerName: "FindDuplicateStringsController"),
                .init(with: "查找数组中重复的数字", subTitle: "查找数组中重复的数字", controllerName: "FindRepeatNumberController"),
                .init(with: "重复的子字符串", subTitle: "重复的子字符串", controllerName: "RepeatedSubstringPatternController"),
                .init(with: "删除排序链表中的重复元素 II", subTitle: "删除排序链表中的重复元素 II", controllerName: "DeleteDuplicates2Controller"),
                .init(with: "合并两个有序数组", subTitle: "合并两个有序数组", controllerName: "MergesTwoOrderedArraysController"),
                .init(with: "部分排序", subTitle: "部分排序", controllerName: "PartSortController"),
                .init(with: "颜色分类", subTitle: "颜色分类", controllerName: "SortColorsController"),
                .init(with: "跳水板", subTitle: "跳水板", controllerName: "DivingBoardController"),
                .init(with: "斐波那契数", subTitle: "斐波那契数", controllerName: "FibController"),
                .init(with: "种花问题", subTitle: "种花问题", controllerName: "PlaceFlowersController"),
                .init(with: "打印从1到最大的n位数", subTitle: "打印从1到最大的n位数", controllerName: "PrintNumbersController"),
                .init(with: "一维数组的动态和", subTitle: "一维数组的动态和", controllerName: "DynamicSumOfOneDimensionalArrayController"),.init(with: "第一个只出现一次的字符", subTitle: "第一个只出现一次的字符", controllerName: "FirstUniqCharController"),
                .init(with: "翻转单词顺序", subTitle: "翻转单词顺序", controllerName: "ReverseWordsController")])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        logDebug("https://www.jianshu.com/p/e7c702e6f7d8")
        let a = 0
        let b = 1
        let c = a ^ b
        logDebug(c)
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = dataSource[indexPath.section].items[indexPath.row]
        let bundleName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String
        
        var targetClass = NSClassFromString(bundleName! + "." + item.controllerName) as? UIViewController.Type
        if targetClass == nil {
            targetClass = NSClassFromString(item.controllerName) as? UIViewController.Type
        }
        let target = targetClass!.init()
        target.navigationItem.title = item.subTitle
        self.navigationController?.pushViewController(target, animated: true)
    }
}
private let kIdentifier = "kIdentifier"
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource[section].sectionTitle
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: kIdentifier)
        }
        let item = dataSource[indexPath.section].items[indexPath.row]
        cell?.textLabel?.text = "\(item.title) (\(item.controllerName))"
        return cell!
    }
}
