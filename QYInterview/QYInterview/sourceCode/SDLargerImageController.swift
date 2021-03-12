//
//  SDLargerImageController.swift
//  QYInterview
//
//  Created by cyd on 2021/2/22.
//

import UIKit
import SnapKit
import SDWebImage
class SDLargerImageController: BaseViewController {

    lazy var imageView: UIImageView = {
        let imageV = UIImageView()
        return imageV
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
//        let imageString = "http://www.onegreen.net/maps/Upload_maps/201412/2014120107280906.jpg"
        let imageString = "http://img3.imgtn.bdimg.com/it/u=965183317,1784857244&fm=27&gp=0.jpg"
        let imageUrl = URL(string: imageString)
        imageView.sd_setImage(with: imageUrl, placeholderImage: nil, options: [])
    }

}
