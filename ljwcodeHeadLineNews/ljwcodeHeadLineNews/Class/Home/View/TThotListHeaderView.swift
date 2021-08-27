//
//  TThotListHeaderView.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/8/11.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import Foundation
import UIKit

class TThotListHeaderView : UIView,UIGestureRecognizerDelegate{
    
    private lazy var hotSpotTitleImgView : UIImageView = {
        let hotSpotTitleImgView = UIImageView()
        hotSpotTitleImgView.image = UIImage.init(named: "hot_search_words");
        return hotSpotTitleImgView
    }()
    
    private lazy var hotSpotTitleLabel : UILabel = {
        let hotSpotTitleLabel = UILabel()
        hotSpotTitleLabel.text = "每天来热搜，看天下大事"
        hotSpotTitleLabel.textColor = UIColor.gray
        hotSpotTitleLabel.font = UIFont.systemFont(ofSize: 13)
        hotSpotTitleLabel.textAlignment = NSTextAlignment.center
        hotSpotTitleLabel.adjustsFontSizeToFitWidth = true
        return hotSpotTitleLabel
    }()
    
    public func createUI(){
        addSubview(hotSpotTitleImgView)
        hotSpotTitleImgView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
        
        addSubview(hotSpotTitleLabel)
        hotSpotTitleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(10)
            make.height.equalTo(hotSpotTitleImgView)
            make.width.equalTo(self.bounds.width * 0.3)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
    }
}
