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
        let imageUrl = URL(string: "http://www.onegreen.net/maps/Upload_maps/201412/2014120107280906.jpg")
        imageView.sd_setImage(with: imageUrl, placeholderImage: nil, options: [.retryFailed])
    }

}
