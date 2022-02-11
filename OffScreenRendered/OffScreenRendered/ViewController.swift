//
//  ViewController.swift
//  OffScreenRendered
//
//  Created by cyd on 2021/4/13.
//

import UIKit
class QTTableItem {
    var title: String?
    var image: String?
    var identifier: String
    init(identifier: String,
         with title: String? = nil,
         image: String? = nil) {
        self.identifier = identifier
        self.title = title
        self.image = image
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
    @IBOutlet weak var tableView: UITableView!
    let mutableItems: [QTTableSectionItem] = [
        .init(with: "设置阴影触发", items: [
            .init(identifier: "ShadowCell")
        ]),
        .init(with: "设置阴影优化", items: [
            .init(identifier: "ShadowOptimizationCell")
        ]),
        .init(with: "圆角触发", items: [
            .init(identifier: "RadiusCell")
        ])
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }

    func registerCell() {
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(UINib(nibName: "ShadowCell", bundle: nil), forCellReuseIdentifier: "ShadowCell")
        
        tableView.register(UINib(nibName: "ShadowOptimizationCell", bundle: nil), forCellReuseIdentifier: "ShadowOptimizationCell")
        
        tableView.register(UINib(nibName: "RadiusCell", bundle: nil), forCellReuseIdentifier: "RadiusCell")
    }
}

extension ViewController: UITableViewDelegate {
    
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mutableItems[section].sectionTitle
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.mutableItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionItem = self.mutableItems[section]
        return sectionItem.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionItem = self.mutableItems[indexPath.section]
        let item = sectionItem.items[indexPath.row]
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let cellCla = NSClassFromString("\(namespace).\(item.identifier)") as? BaseTableViewCell.Type
        let cell = (cellCla?.cell(withIdentifier: item.identifier, tableView: tableView))!
        cell.configureItem(item: item)
        return cell
    }
    
}

