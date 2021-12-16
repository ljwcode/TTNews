//
//  TTHorizontalHuoShanVideoCollectionCell.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/9/1.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import UIKit
import SnapKit

@objc(TTHorizontalHuoShanVideoCellDelegate)
protocol TTHorizontalHuoShanVideoCellDelegate : NSObjectProtocol {
    func TTCloseHandle() -> Void
}

@objc(TTHorizontalHuoShanVideoCollectionCell)
class TTHorizontalHuoShanVideoCollectionCell: UICollectionViewCell {
    @objc public var newsModel = microVideoDetailModel()  {
        didSet{
            
        }
    }
    @objc weak var delegate : TTHorizontalHuoShanVideoCellDelegate?
    private lazy var closeBtn : TTAlphaThemeButton = {
        let closeBtn = TTAlphaThemeButton()
        closeBtn .addTarget(self, action: #selector(TTCloseHandle), for: .touchUpInside)
        
        return closeBtn
    }()
    
    private lazy var converImgView : UIImageView = {
        let converImgView = UIImageView()
        
        return converImgView
    }()
    
    private lazy var rich_titleLabel : SSThemedLabel = {
        let titleLabel = SSThemedLabel()
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        
        return titleLabel
    }()
    
    func createUI() -> Void{
        
        addSubview(converImgView)
        converImgView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.left.right.top.height.equalTo(0)
        }
        
        converImgView.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.right.equalTo(-10)
            make.width.height.equalTo(20)
        }
        
        converImgView.addSubview(rich_titleLabel)
        rich_titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(10)
            make.height.equalTo(self.bounds.height/6)
        }
        
    }
    
    @objc func TTCloseHandle(Sender: UIButton){
        if delegate?.TTCloseHandle() != nil {
            delegate?.TTCloseHandle()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
