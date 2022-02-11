//
//  ShadowCell.swift
//  OffScreenRendered
//
//  Created by cyd on 2022/2/10.
//

import UIKit

class ShadowCell: BaseTableViewCell {
    
    @IBOutlet weak var ds_imageView: UIImageView!
    
    @IBOutlet weak var ds_label: UILabel!
    
    override class func cell(withIdentifier identifier:String, tableView: UITableView) ->  ShadowCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = ShadowCell(style: .default, reuseIdentifier: identifier)
        }
        return cell as! ShadowCell
    }
    override func configureItem(item: QTTableItem) {
        super.configureItem(item: item)
        let imageNamed = item.image ?? "icon_widget_banner_question"
        self.ds_imageView.image = UIImage(named: imageNamed)
        self.ds_label.text = item.title ?? "文字"
        
        self.ds_imageView.layer.shadowColor = UIColor.red.cgColor
        self.ds_imageView.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.ds_imageView.layer.shadowOpacity = 0.5
        self.ds_imageView.layer.shadowRadius = 5
        self.ds_imageView.layer.masksToBounds = false
    }
}
