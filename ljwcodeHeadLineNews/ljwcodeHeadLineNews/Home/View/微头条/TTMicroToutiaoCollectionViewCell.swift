//
//  TTMicroToutiaoCollectionViewCell.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2022/2/23.
//  Copyright © 2022 ljwcode. All rights reserved.
//

import Foundation
import UIKit

class TTMicroToutiaoCollectionViewCell : UICollectionViewCell {
    
    private lazy var imgView : UIImageView = {
        let imgView = UIImageView()
        
        return imgView
    }()
    
    @objc var imgCoverModel : detail_cover_list! {
        didSet{
            guard let model = imgCoverModel else {
                return
            }
//            imgView.sd_setImage(with: URL.init(string: url))
            imgView.sd_setImage(with: URL.init(string: model.url))
        }
    }
    
    func createUI() {
        self.addSubview(self.imgView)
        self.imgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
