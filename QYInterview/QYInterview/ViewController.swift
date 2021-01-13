//
//  ViewController.swift
//  QYInterview
//
//  Created by cyd on 2021/1/13.
//

import UIKit
func logDebug(_ message: Any) {
    print(message)
}
class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    deinit {
        logDebug("\(self) 移除了")
    }
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
        .init(with: "算法", items: [
                .init(with: "寻找最近公共父类", subTitle: "寻找最近公共父类", controllerName: "NearlyFatherController"),
                .init(with: "反转字符串", subTitle: "反转字符串", controllerName: "ReverseStringController"),
                .init(with: "反转单链表", subTitle: "反转单链表", controllerName: "ReverseSingListController"),
                .init(with: "有序数组合并", subTitle: "有序数组合并", controllerName: "OrderedArrayMergeController"),
                .init(with: "求无序数组中的中位数", subTitle: "求无序数组中的中位数", controllerName: "MedianUnorderedArrayController"),
                .init(with: "求数组逆序数", subTitle: "求数组逆序数", controllerName: "NumOfReverseArrayController"),
                .init(with: "判断平衡二叉树", subTitle: "判断平衡二叉树", controllerName: "")]),
        .init(with: "概念", items: [
                .init(with: "Class和Struct", subTitle: "Class和Struct", controllerName: "TTTTViewController")]),
        .init(with: "网络相关", items: [
                .init(with: "TCP协议跟UDP协议有什么区别", subTitle: "TCP协议跟UDP协议有什么区别", controllerName: "TCPUDPController"),
                .init(with: "HTTPS协议原理", subTitle: "HTTPS协议原理", controllerName: "HTTPSController")])]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "面试总结"
        
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
let kIdentifier = "kIdentifier"
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
