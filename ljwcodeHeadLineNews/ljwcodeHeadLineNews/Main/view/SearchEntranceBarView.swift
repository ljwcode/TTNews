//
//  SearchEntranceBarView.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/9/22.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import UIKit
import SnapKit
import Realm

@objc(searchEntranceBarViewDelegate)
protocol searchEntranceBarViewDelegate : NSObjectProtocol {
    func TT_EntranceBackHandle() ->Void;
    func TT_SearchHandle() -> Void;
}

class SearchEntranceBarView : UIView {
    @objc weak var delegate : searchEntranceBarViewDelegate?
    private lazy var backBtn : UIButton = {
       let backBtn = UIButton()
        backBtn .setImage(UIImage.init(named: "lefterbackicon_titlebar"), for: UIControl.State.normal)
        backBtn .addTarget(self, action: #selector(TT_EntranceBackHandle), for: .touchUpInside)
        
        return backBtn;
    }()
    
    private lazy var SearchBarView : UIView = {
        let searchBarView = UIView()
        searchBarView.layer.cornerRadius = 23
        searchBarView.backgroundColor = UIColor.lightGray
        return searchBarView
    }()
    
    private lazy var searchBarImgView : UIImageView = {
        let searchBarImgView = UIImageView()
        searchBarImgView.image = UIImage.init(named: "icons_search")
        return searchBarImgView
    }()
    
   @objc public lazy var searchTextField : UITextField = {
        let searchTextField = UITextField()
        searchTextField.textAlignment  = .natural
        searchTextField.minimumFontSize = 14
        searchTextField.textColor = UIColor.black
        searchTextField.placeholder = ""
        return searchTextField
    }()
    
    private lazy var searchBtn : UIButton = {
        let searchBtn = UIButton()
        searchBtn .setTitle("搜索", for: .normal)
        searchBtn .setTitleColor(UIColor.red, for: .normal)
//        searchBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        searchBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        searchBtn.titleLabel?.textAlignment = NSTextAlignment.center
        searchBtn .addTarget(self, action: #selector(TT_SearchHandle), for: .touchUpInside)
        return searchBtn
    }()
    
    @objc func TT_EntranceBackHandle(sender : UIButton){
        if delegate != nil {
            delegate?.TT_EntranceBackHandle()
        }
    }
    @objc func TT_SearchHandle(sender: UIButton){
        if delegate != nil {
            delegate?.TT_SearchHandle()
        }
    }
    
    public func createUI(){
        addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.width.height.equalTo(20)
            make.centerY.equalTo(self)
        }
        
        addSubview(SearchBarView)
        SearchBarView.snp.makeConstraints { make in
            make.left.equalTo(backBtn.snp.right).offset(5)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.width.equalTo(self.bounds.size.width - 10 - 20 - 10 - 33 - 20)
        }
        
        SearchBarView .addSubview(searchBarImgView)
        searchBarImgView.snp.makeConstraints { make in
            make.left.equalTo(5)
            make.centerY.equalTo(self.SearchBarView)
            make.width.height.equalTo(20)
        }
        
        SearchBarView.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.left.equalTo(self.searchBarImgView.snp.right).offset(3)
            make.centerY.equalTo(self.SearchBarView)
            make.right.equalTo(-20)
        }
        
        addSubview(searchBtn)
        searchBtn .snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.left.equalTo(SearchBarView.snp.right).offset(5)
            make.centerY.equalTo(self)
            make.height.equalTo(33)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
