//
//  homeNewsRightVideoTableViewCell.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2022/2/16.
//  Copyright © 2022 ljwcode. All rights reserved.
//

import Foundation

protocol TTHomeNewsRightVideoTableViewCellDelegate:NSObjectProtocol{
    func delNewsCellHandle() ->Void
    func playNewsVideoHandle() ->Void
}

class TTHomeNewsRightVideoTableViewCell : UITableViewCell {
    private var newsModel : homeNewsSummaryModel?;
    weak var delegate : TTHomeNewsRightVideoTableViewCellDelegate?
    
    private lazy var newsTitleLabel : SSThemedLabel = {
        let label = SSThemedLabel.init(frame: .zero, fontColor: UIColor.black, fontSize: 18, align: .left)
        label.numberOfLines = 0
        label .setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var newsInfoLabel : SSThemedLabel = {
        let label = SSThemedLabel.init(frame: .zero, fontColor: UIColor.gray, fontSize: 10, align: .left)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var delBtn : UIButton = {
        let btn = UIButton()
        btn .setImage(UIImage.init(named: "close_grade_small"), for: .normal)
        btn .addTarget(self, action: #selector(delNewsCellHandle), for: .touchUpInside)
        return btn
    }()
    
    private lazy var videoCoverView : UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var videoCoverImgView : UIImageView = {
        let imgView = UIImageView()
        
        return imgView
    }()
    
    private lazy var playerBtn : UIButton = {
        let btn = UIButton()
        btn .setImage(UIImage.init(named: "horizontal_play_icon"), for: .normal)
        btn .addTarget(self, action: #selector(playNewsVideoHandle), for: .touchUpInside)
        return btn
    }()
    
    private lazy var videoTimerLabel : SSThemedLabel = {
        let label = SSThemedLabel.init(frame: .zero, fontColor: UIColor.white, fontSize: 10, align: .center)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var bottomLineView : UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.alpha = 0.1
        return view
    }()
    
    @objc func delNewsCellHandle() {
        if (self.delegate != nil) && self.delegate?.delNewsCellHandle() != nil {
            self.delegate? .delNewsCellHandle()
        }
    }
    
    @objc func playNewsVideoHandle() {
        if(self.delegate != nil) && self.delegate?.playNewsVideoHandle() != nil {
            self.delegate? .playNewsVideoHandle()
        }
    }
    
   @objc var newsVideoModel : homeNewsSummaryModel? {
        didSet{
            guard let model = newsVideoModel else{
                return
            }
            self.newsModel = model
            self.newsTitleLabel.text = model.infoModel.title
            let newsPublishTime : String = TT_TimeIntervalConverString .tt_converTimeInterval(toString: model.infoModel.publish_time)
            self.newsInfoLabel.text = String(format: "%@  %@评论 %@", model.infoModel.media_name,model.infoModel.comment_count,newsPublishTime)
            self.videoCoverImgView.sd_setImage(with: URL(string: model.infoModel.middle_image.url))
        }
    }
    
    func createUI() ->Void {
        self.contentView .addSubview(self.newsTitleLabel)
        self.newsTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(5)
            make.width.equalTo(kScreenWidth * 0.7 - 10 * 3)
            make.height.equalTo(80)
        }
        
        self.contentView.addSubview(self.videoCoverView)
        self.videoCoverView.snp.makeConstraints { make in
            make.left.equalTo(self.newsTitleLabel.snp.right).offset(10)
            make.right.equalTo(-10)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
        }
        
        self.videoCoverView.addSubview(self.videoCoverImgView)
        self.videoCoverImgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.contentView .addSubview(self.delBtn)
        self.delBtn.snp.makeConstraints { make in
            make.right.equalTo(self.videoCoverView.snp.left).offset(-10)
            make.bottom.equalTo(-10)
            make.width.height.equalTo(20)
        }
        
        self.contentView .addSubview(self.newsInfoLabel)
        self.newsInfoLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(self.newsTitleLabel.snp.bottom).offset(5)
            make.right.equalTo(self.delBtn.snp.left).offset(-10)
            make.height.equalTo(10)
            make.bottom.equalTo(-10)
        }
        
        self.contentView .addSubview(self.bottomLineView)
        self.bottomLineView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-2)
            make.top.equalTo(self.newsInfoLabel.snp.bottom).offset(10)
            make.height.equalTo(1)
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
