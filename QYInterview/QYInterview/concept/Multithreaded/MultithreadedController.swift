//
//  MultithreadedController.swift
//  QYInterview
//
//  Created by cyd on 2021/3/10.
//

import UIKit

class MultithreadedController: UIViewController {
    var dataSource: [QTTableSectionItem] = [
        .init(with: "GCD", items: [
                .init(with: "栅栏函数", subTitle: "栅栏函数", controllerName: "GCDBarrierController"),
                .init(with: "GCD优先级", subTitle: "GCD优先级", controllerName: "GCDController")
        ]),
        .init(with: "NSOperationQueue", items: [
                .init(with: "Operation", subTitle: "Operation", controllerName: "OperationController")])]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }


}
extension MultithreadedController: UITableViewDelegate {
    
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
extension MultithreadedController: UITableViewDataSource {
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
