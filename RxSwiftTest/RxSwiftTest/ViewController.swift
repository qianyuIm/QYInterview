//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by cyd on 2021/4/9.
//  https://juejin.cn/post/6844904118432202759

import UIKit
import RxCocoa
import RxSwift



struct ListItem {
    var title: String
    var subTitle: String
    var name: String
}
struct ListItemViewModel {
    let data = Observable.just([
                                
        ListItem(title: "Observable",subTitle: "13",name: "ObservableController"),
        ListItem(title: "Subjects", subTitle: "Subjects", name: "SubjectsController")
    ])
    
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let dataSource = ListItemViewModel()
    //负责对象销毁
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataSource.data
            .bind(to: tableView.rx
                    .items) { (tableView, _, element) in
                var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
                if (cell == nil) {
                    cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
                }
                cell?.textLabel?.text = element.title
                cell?.detailTextLabel?.text = element.name
                return cell!
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(ListItem.self).subscribe(onNext: { item in
            let bundleName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String
            var targetClass = NSClassFromString(bundleName! + "." + item.name) as? UIViewController.Type
            if targetClass == nil {
                targetClass = NSClassFromString(item.name) as? UIViewController.Type
            }
            let target = targetClass!.init()
            target.navigationItem.title = item.subTitle
            self.navigationController?.pushViewController(target, animated: true)
        }).disposed(by: disposeBag)
        
        
    }


}

