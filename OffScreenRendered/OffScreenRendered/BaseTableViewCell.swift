//
//  BaseTableViewCell.swift
//  OffScreenRendered
//
//  Created by cyd on 2022/2/10.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    var item: QTTableItem?
    
    class func cell(withIdentifier identifier:String, tableView: UITableView) ->  BaseTableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = BaseTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        return cell as! BaseTableViewCell
    }
    func configureItem(item: QTTableItem){
        self.item = item
    }
    

}
