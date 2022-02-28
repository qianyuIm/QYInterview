//
//  ViewController.swift
//  QYInterview
//
//  Created by cyd on 2021/1/13.
//

import UIKit
func logDebug(_ message: Any,
              separator: String = " ",
              terminator: String = "\n") {
    print(message, separator: separator, terminator: terminator)
}
class BaseViewController: UIViewController {
    var touchesBeganBlock: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        let label = UILabel(frame: .zero)
        label.text = "点击屏幕查看输出"
        label.textColor = .red
        label.sizeToFit()
        label.center = view.center
        view.addSubview(label)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchesBeganBlock?()
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
        .init(with: "Swift", items: [
                .init(with: "Class和Struct", subTitle: "Class和Struct", controllerName: "ClassAndStructController"),
                .init(with: "Swift KVO", subTitle: "Swift KVO", controllerName: "SwiftKVOViewController"),
                .init(with: "defer 的作用", subTitle: "defer 的作用", controllerName: "DeferViewController"),
                .init(with: "闭包", subTitle: "闭包", controllerName: "ClosureController"),
                .init(with: "计算属性和存储属性", subTitle: "计算属性和存储属性", controllerName: "PropertiesController"),
                .init(with: "类型相关", subTitle: "类型相关", controllerName: "TypeController"),
                .init(with: "swift weak", subTitle: "swift weak", controllerName: "SwiftWeakController"),
                .init(with: "访问控制", subTitle: "访问控制", controllerName: "AccessControlController")
                .init(with: "OC调用Swift", subTitle: "OC调用Swift", controllerName: "OCCallSwiftController")
        ]),
        .init(with: "Bug", items: [
            .init(with: "UITextFieldDelegate代理不走", subTitle: "UITextFieldDelegate代理不走", controllerName: "TextFieldViewController")
        ]),
        .init(with: "链表", items: [
            .init(with: "24. 两两交换链表中的节点", subTitle: "24. 两两交换链表中的节点", controllerName: "SwapPairsController"),
        ]),
        .init(with: "哈希", items: [
            .init(with: "242. 有效的字母异位词", subTitle: "242. 有效的字母异位词", controllerName: "AnagramController")
        ]),
        .init(with: "数组", items: [
            .init(with: "二分查找", subTitle: "二分查找", controllerName: "BinarySearchController"),
            .init(with: "27.移除元素", subTitle: "27.移除元素", controllerName: "RemoveElementArrayController"),
            .init(with: "977.有序数组的平方", subTitle: "977.有序数组的平方", controllerName: "SortedSquaresArrayController"),
            .init(with: "209.长度最小的子数组", subTitle: "209.长度最小的子数组", controllerName: "MinSubArrayLenController"),
            .init(with: "59. 螺旋矩阵 II", subTitle: "59. 螺旋矩阵 II", controllerName: "GenerateMatrixController")
            
        ]),
        .init(with: "双指针", items: [
            .init(with: "移除元素", subTitle: "移除元素", controllerName: "RemoveElementsController"),
            .init(with: "反转字符串", subTitle: "反转字符串", controllerName: "ReverseStringController"),
            .init(with: "替换空格", subTitle: "替换空格", controllerName: "ReplaceSpaceController"),
            .init(with: "翻转字符串里的单词", subTitle: "翻转字符串里的单词", controllerName: "ReverseWordsController"),
            .init(with: "反转一个单链表", subTitle: "反转一个单链表", controllerName: "ReverseListController"),
            .init(with: "19. 删除链表的倒数第 N 个结点", subTitle: "19. 删除链表的倒数第 N 个结点", controllerName: "RemoveNthFromEndController"),
            .init(with: "链表相交", subTitle: "链表相交", controllerName: "IntersectionNodeController"),
            .init(with: "142.环形链表II", subTitle: "142.环形链表II", controllerName: "DetectCycleController"),
            .init(with: "15.三数之和", subTitle: "15.三数之和", controllerName: "ThreeSumController")
                        
        ]),
        .init(with: "算法", items: [
                .init(with: "爬楼梯", subTitle: "爬楼梯", controllerName: "ClimbStairsController"),
                .init(with: "寻找最近公共父类", subTitle: "寻找最近公共父类", controllerName: "NearlyFatherController"),
                
                .init(with: "反转单链表", subTitle: "反转单链表", controllerName: "ReverseSingListController"),
                .init(with: "有序数组合并", subTitle: "有序数组合并", controllerName: "OrderedArrayMergeController"),
                .init(with: "求无序数组中的中位数", subTitle: "求无序数组中的中位数", controllerName: "MedianUnorderedArrayController"),
                .init(with: "求数组逆序数", subTitle: "求数组逆序数", controllerName: "NumOfReverseArrayController"),
                .init(with: "二叉树相关", subTitle: "二叉树相关", controllerName: "BinaryTreeController"),
                ]),
        
        .init(with: "源码相关", items: [.init(with: "SDWebImage下载大图", subTitle: "SDWebImage下载大图", controllerName: "SDLargerImageController")]),
        .init(with: "概念", items: [
                .init(with: "子类为什么可以通过类方法调用NSObject 中的实例方法", subTitle: "子类为什么可以通过类方法调用NSObject 中的实例方法", controllerName: "ChildFatherNSObjectController"),
                .init(with: "load", subTitle: "load", controllerName: "LoadController"),
                .init(with: "通知是同步的", subTitle: "通知是同步的", controllerName: "NotificationSyncController"),
                .init(with: "Tagged Pointer", subTitle: "Tagged Pointer", controllerName: "TaggedPointerController"),
                .init(with: "copy修饰", subTitle: "copy修饰", controllerName: "CopyController"),
                .init(with: "iOS中的几种锁", subTitle: "锁的使用场景", controllerName: "LockController"),
                .init(with: "内存偏移", subTitle: "内存偏移", controllerName: "MemoryMigrationController"),
                
                .init(with: "Block修改内部值", subTitle: "Block修改内部值", controllerName: "BlockChangeController"),
                .init(with: "KVO", subTitle: "KVO", controllerName: "KVOController"),
                .init(with: "KVC", subTitle: "KVC", controllerName: "KVCController"),
                .init(with: "性能优化", subTitle: "性能优化", controllerName: ""),
                .init(with: "map,flatMap,compactMap", subTitle: "map,flatMap,compactMap", controllerName: "MapController"),
                .init(with: "初始化方法", subTitle: "初始化方法", controllerName: "InitController"),
                .init(with: "响应者链", subTitle: "响应者链", controllerName: "TouchController"),
                .init(with: "Super和Self", subTitle: "Super和Self", controllerName: "SuperSelfController"),
                .init(with: "RunLoop", subTitle: "RunLoop", controllerName: "RunLoopController"),
                .init(with: "Runtime", subTitle: "Runtime", controllerName: "RuntimeController"),
                .init(with: "对象初始化相关", subTitle: "对象初始化相关", controllerName: "AllocInitController"),
                .init(with: "多线程", subTitle: "多线程", controllerName: "MultithreadedController"),
                .init(with: "内存管理", subTitle: "内存管理", controllerName: "MemoryController"),
                .init(with: "响应者链", subTitle: "响应者链", controllerName: "ResponderChainController"),
                .init(with: "Codable", subTitle: "Codable", controllerName: "CodableController")]),
        .init(with: "网络相关", items: [
                .init(with: "TCP协议跟UDP协议有什么区别", subTitle: "TCP协议跟UDP协议有什么区别", controllerName: "TCPUDPController"),
                .init(with: "HTTPS协议原理", subTitle: "HTTPS协议原理", controllerName: "HTTPSController")]),
        .init(with: "项目优化", items: [
                .init(with: "if else 多层判断优化", subTitle: "if else 多层判断优化", controllerName: "IfElseController")]),
        .init(with: "Hook", items: [.init(with: "Hook", subTitle: "Hook", controllerName: "HookController")])]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "面试总结"
        
    }
}

extension ViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        logDebug(scrollView.bounds)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = dataSource[indexPath.section].items[indexPath.row]
        let bundleName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String
        
        var targetClass = NSClassFromString(bundleName! + "." + item.controllerName) as? UIViewController.Type
        if targetClass == nil {
            targetClass = NSClassFromString(item.controllerName) as? UIViewController.Type
        }
        let target = targetClass!.init()
        // 16
//        NSLog(@"stu --- %zd", malloc_size((__bridge const void *)stu));
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
