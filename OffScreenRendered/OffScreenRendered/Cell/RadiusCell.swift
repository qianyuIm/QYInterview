//
//  RadiusCell.swift
//  OffScreenRendered
//
//  Created by cyd on 2022/2/10.
//

import UIKit

class RadiusCell: BaseTableViewCell {

    @IBOutlet weak var ds_imageView: UIImageView!
    
    @IBOutlet weak var ds_label: UILabel!
    override class func cell(withIdentifier identifier:String, tableView: UITableView) ->  RadiusCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = RadiusCell(style: .default, reuseIdentifier: identifier)
        }
        return cell as! RadiusCell
    }
    override func configureItem(item: QTTableItem) {
        super.configureItem(item: item)
        let imageNamed = item.image ?? "icon_widget_banner_question"
        self.ds_imageView.image = UIImage(named: imageNamed)
        self.ds_label.text = item.title ?? "文字"
        // 图片圆角经过优化 单存设置圆角不会触发离屏渲染 但是不能添加颜色
        self.ds_imageView.layer.cornerRadius = 10
//        self.ds_imageView.backgroundColor = UIColor.red
        self.ds_imageView.layer.masksToBounds = true
        
        
        self.ds_label.layer.cornerRadius = 10
//        self.ds_label.backgroundColor = UIColor.red
        self.ds_label.layer.backgroundColor = UIColor.green.cgColor
        self.ds_label.layer.masksToBounds = true
        
    }
    
}
