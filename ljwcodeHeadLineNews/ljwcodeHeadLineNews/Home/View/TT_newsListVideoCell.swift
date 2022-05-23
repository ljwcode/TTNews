//
//  TT_newsListVideoCell.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/8/31.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import UIKit
import SnapKit

@objc(TT_newsListVideoDelegate)
protocol TT_newsListVideoDelegate : NSObjectProtocol {
    func TT_videoPlayHandle() -> Void
    func TT_closeHandle() -> Void
}

@objc(TT_newsListVideoCell)
class TT_newsListVideoCell : UITableViewCell {
    
    var newsModel = homeNewsSummaryModel() {
        didSet {
            self.titleLabel.text = newsModel.infoModel.title
            self.videoConverImgView .sd_setImage(with: NSURL.init(string: newsModel.infoModel.video_detail_info.detail_video_large_image.url) as URL?)
            self.videoDurationLabel.text = String.init(format: "%d:%d", newsModel.infoModel.video_duration/60,newsModel.infoModel.video_duration%60)
            self.videoInfoLabel.text = String.init(format: "%@ %d评论 %@",newsModel.infoModel.media_name,newsModel.infoModel.comment_count,[TT_TimeIntervalConverString .tt_converTimeInterval(toString: newsModel.infoModel.publish_time)])
        }
    }
    
    @objc weak var delegate : TT_newsListVideoDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = NSTextAlignment.center
        
        return titleLabel
    }()
    
    private lazy var videoConverView : UIView = {
        let videoConverView = UIView()
        
        return videoConverView
    }()
    
    private lazy var videoConverImgView : UIImageView = {
        let videoConverImgView = UIImageView()
        
        return videoConverImgView
    }()
    
    private lazy var videoPlayBtn : UIButton = {
        let videoPlayBtn = UIButton()
        videoPlayBtn .setImage(UIImage.init(named: "horizontal_play_icon"), for: .normal)
        videoPlayBtn .backgroundColor = UIColor.clear
        videoPlayBtn .addTarget(self, action: #selector(TT_videoPlayHandle), for: .touchUpInside)
        
        return videoPlayBtn
    }()
    
    private lazy var videoDurationLabel : UILabel = {
        let videoDurationLabel = UILabel()
        videoDurationLabel.textColor = UIColor.white
        videoDurationLabel.textAlignment = NSTextAlignment.center
        videoDurationLabel.adjustsFontSizeToFitWidth = true
        videoDurationLabel.font = UIFont.systemFont(ofSize: 10)
        
        return videoDurationLabel
    }()
    
    private lazy var videoInfoLabel : UILabel = {
        let videoInfoLabel = UILabel()
        videoInfoLabel.textColor = UIColor.white
        videoInfoLabel.textAlignment = NSTextAlignment.center
        videoInfoLabel.font = UIFont.systemFont(ofSize: 10)
        videoInfoLabel.adjustsFontSizeToFitWidth = true
        
        return videoInfoLabel
    }()
    
    private lazy var closeBtn : UIButton = {
        let closeBtn = UIButton()
        closeBtn .setImage(UIImage.init(named: "tsv_combined_Shape_close"), for: .normal)
        closeBtn .addTarget(self, action: #selector(TT_closeHandle), for: .touchUpInside)
        closeBtn .backgroundColor = UIColor.clear
        return closeBtn
    }()
    
    @objc func TT_videoPlayHandle(sender: UIButton){
        if delegate?.TT_videoPlayHandle() != nil {
            delegate?.TT_videoPlayHandle()
        }
    }
    
    @objc func TT_closeHandle(sender: UIButton){
        if delegate?.TT_closeHandle() != nil {
            delegate?.TT_closeHandle()
        }
    }
    
    func createUI(){
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.right.equalTo(-10)
            make.height.greaterThanOrEqualTo(50)
        }
        
        addSubview(videoConverView)
        videoConverView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.right.equalTo(titleLabel)
            make.height.equalTo(self.bounds.height * 0.7)
        }
        
        videoConverView.addSubview(videoConverImgView)
        videoConverImgView.snp.makeConstraints { (make) in
            make.center.equalTo(videoConverView)
            make.width.height.equalTo(videoConverView)
        }
        
        videoConverImgView.addSubview(videoPlayBtn)
        videoPlayBtn.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(videoConverImgView)
            make.height.width.equalTo(50)
        }
        
        videoConverImgView.addSubview(videoDurationLabel)
        videoDurationLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.bottom.equalTo(-10)
            make.height.equalTo(20)
            make.width.equalTo(80)
        }
        
        addSubview(videoInfoLabel)
        videoInfoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(videoConverView.snp.bottom).offset(5)
            make.height.equalTo(20)
            make.width.equalTo((self.bounds.width - 20)/2)
        }
        
    }
}

