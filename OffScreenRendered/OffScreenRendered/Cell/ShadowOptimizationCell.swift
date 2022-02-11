//
//  ShadowOptimizationCell.swift
//  OffScreenRendered
//
//  Created by cyd on 2022/2/10.
//

import UIKit

class ShadowOptimizationCell: BaseTableViewCell {

    @IBOutlet weak var ds_imageView: UIImageView!
    
    @IBOutlet weak var ds_label: UILabel!
    override class func cell(withIdentifier identifier:String, tableView: UITableView) ->  ShadowOptimizationCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = ShadowOptimizationCell(style: .default, reuseIdentifier: identifier)
        }
        return cell as! ShadowOptimizationCell
    }
    override func configureItem(item: QTTableItem) {
        super.configureItem(item: item)
        let imageNamed = item.image ?? "icon_widget_banner_question"
        self.ds_imageView.image = UIImage(named: imageNamed)
        self.ds_label.text = item.title ?? "文字"
        
        self.ds_imageView.layer.shadowColor = UIColor.red.cgColor
        self.ds_imageView.layer.shadowOpacity = 0.5
        self.ds_imageView.layer.shadowRadius = 5
        self.ds_imageView.layer.masksToBounds = false
        
        let path = UIBezierPath(rect: CGRect(x: 7, y: 7, width: self.ds_imageView.bounds.width + 3, height: self.ds_imageView.bounds.height + 3))
        self.ds_imageView.layer.shadowPath = path.cgPath
        
        self.ds_imageView.layer.maskedCorners
    }
    
}
