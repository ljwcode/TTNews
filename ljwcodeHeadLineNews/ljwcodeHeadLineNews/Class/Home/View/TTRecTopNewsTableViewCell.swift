//
//  TTRecTopNewsTableViewCell.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2022/2/23.
//  Copyright © 2022 ljwcode. All rights reserved.
//

import Foundation
import UIKit
import libwebp

class TTRecTopNewsTableViewCell : UITableViewCell {
    private var newsModel : homeNewsSummaryModel!

    private lazy var newsTitleLabel : SSThemedLabel = {
        let label = SSThemedLabel.init(frame: .zero, fontColor: .black, fontSize: 18, align: .left)
        label.numberOfLines = 0
        label .setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var newsInfoLabel : SSThemedLabel = {
        let label = SSThemedLabel.init(frame: .zero, fontColor: .gray, fontSize: 10, align: .left)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var bottomLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.alpha = 0.1
        return view
    }()
    
    func createUI(){
        self.contentView .addSubview(self.newsTitleLabel)
        self.newsTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(5)
            make.right.equalTo(-10)
            make.height.equalTo(30)
        }
        
        self.contentView.addSubview(self.newsInfoLabel)
        self.newsInfoLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(self.newsTitleLabel.snp.bottom).offset(5)
            make.height.equalTo(10)
            make.bottom.equalTo(-5)
        }
        
        self.contentView .addSubview(self.bottomLineView)
        self.bottomLineView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(self.newsInfoLabel.snp.bottom).offset(10)
            make.bottom.equalTo(-2)
            make.height.equalTo(1)
        }
    }
    
    @objc var summaryModel : homeNewsSummaryModel? {
        didSet{
            guard let model = summaryModel else{
                return
            }
            
            self.newsModel = model
            self.newsTitleLabel.text = model.infoModel.title
           
            self.newsInfoLabel.text = String.init(format: "%@ %@评论", model.infoModel.media_name,model.infoModel.comment_count)
            
        }
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}
