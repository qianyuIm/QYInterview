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
                .init(with: "冒泡排序", subTitle: "冒泡排序", controllerName: "BubbleSortController")]),
        .init(with: "面试", items: [
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
