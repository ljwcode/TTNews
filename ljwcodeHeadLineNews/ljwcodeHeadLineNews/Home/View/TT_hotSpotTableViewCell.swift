//
//  TT_hotSpotTableViewCell.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/8/30.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import UIKit
import SnapKit

@objc(TT_hotSpotDelegate)
protocol TT_hotSpotDelegate : NSObjectProtocol{
    func TT_hotSpotMoreInfo() -> Void
}



@objc(TT_hotSpotTableViewCell)
class TT_hotSpotTableViewCell: UITableViewCell {
    @objc weak var delegate : TT_hotSpotDelegate?
    var Tag : String
    var tagBgColor : UIColor
    var isHotbands : Bool
    var tagsTextColor : UIColor
    
    private lazy var tagLabel : UILabel = {
        let tagLabel = UILabel()
        tagLabel.text = Tag
        tagLabel.textColor = tagsTextColor
        tagLabel.backgroundColor = tagBgColor
        tagLabel.font = UIFont.systemFont(ofSize: 15)
        tagLabel.adjustsFontSizeToFitWidth = true
        
        return tagLabel
    }()
    
    private lazy var textDetailLabel : UILabel = {
        let textDetailLabel = UILabel()
        textDetailLabel.text = ""
        textDetailLabel.font = UIFont.systemFont(ofSize: 15)
        textDetailLabel.textColor = UIColor.black
        
        return textDetailLabel
    }()
    
    private lazy var hotBandImg : UIImageView = {
        let hotBandImg = UIImageView()
        
        return hotBandImg
    }()
    
    private lazy var rightArrorMoreBtn : UIButton = {
        let rightArrorMoreBtn = UIButton()
        rightArrorMoreBtn .setImage(UIImage.init(named: "right_discover"), for: UIControl.State.normal)
        rightArrorMoreBtn .addTarget(self, action: #selector(TT_hotSpotMoreInfoHandle), for: .touchUpInside)
        
        return rightArrorMoreBtn
    }()
    
    private lazy var lineView : UIView = {
        let lineView  = UIView()
        lineView.backgroundColor = UIColor.gray
        return lineView
    }()
    
    func createUI() -> Void{
        addSubview(tagLabel)
        tagLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(self)
            make.width.height.equalTo(self.bounds.height/2)
        }
        
        addSubview(textDetailLabel)
        textDetailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(tagLabel.snp.right).offset(20)
            make.centerY.equalTo(self)
            make.height.equalTo(tagLabel)
            make.width.equalTo(self.bounds.width * 0.6)
        }
        
        if(isHotbands){
            addSubview(hotBandImg)
            hotBandImg.snp.makeConstraints { (make) in
                make.left.equalTo(textDetailLabel.snp.right).offset(5)
                make.width.height.equalTo(tagLabel)
                make.centerY.equalTo(self)
            }
        }
        
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-1)
            make.height.equalTo(1)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
    }
    
   @objc convenience init(style: UITableViewCell.CellStyle, reuseIdentifier: String?,tagColor:UIColor, isHotBand:Bool,tag:Int,tagTextColor:UIColor) {
        self.init(style:style,reuseIdentifier:reuseIdentifier)
        tagBgColor = tagColor
        isHotbands = isHotBand
        Tag = "0"
        tagsTextColor = tagTextColor
        
    }
    
    @objc func TT_hotSpotMoreInfoHandle(rightArrorMoreBtn : UIButton){
        if delegate?.TT_hotSpotMoreInfo() != nil {
            delegate?.TT_hotSpotMoreInfo()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.tagBgColor = UIColor.clear
        self.isHotbands = true
        self.Tag = "0"
        self.tagsTextColor = UIColor.clear
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
}
