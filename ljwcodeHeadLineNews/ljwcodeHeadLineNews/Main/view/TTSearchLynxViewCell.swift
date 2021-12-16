//
//  TTSearchLynxViewCell.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/9/27.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import UIKit
import SnapKit
import Foundation

class TTSearchLynxViewCell : UITableViewCell {
    
    let kScreenWidth : CGFloat = UIScreen.main.bounds.size.width
    let kScreenHeight : CGFloat = UIScreen.main.bounds.size.height
    
    let titleArray : [String] = ["猜你想搜","头条热搜","免费小说"]
    
    @objc public lazy var recArray : NSArray = {
        var  recArray = NSArray()
        recArray = UserDefaults.standard.object(forKey: "recSearchWords") as! NSArray
        return recArray
    }()
    
    private lazy var titleView : UIView = {
        let titleView = UIView()
        titleView.backgroundColor = UIColor.white
        return titleView
    }()
    
    private lazy var hideView : UIView = {
        let hideView = UIView()
        hideView.backgroundColor = UIColor.white
        return hideView
    }()
    
    private lazy var hideImgView : UIImageView = {
        let hideImgView = UIImageView()
        hideImgView.image = UIImage.init(named: "eye-line")
        return hideImgView
    }()
    
    private lazy var recSuperView : UIView = {
        let recSuperView = UIView()
        recSuperView.backgroundColor = UIColor.white
        return recSuperView
    }()
    
    private lazy var recBtn : UIButton = {
        let recBtn = UIButton()
        recBtn.backgroundColor = UIColor.white
        recBtn .setTitleColor(UIColor.black, for: .normal)
        recBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return recBtn
    }()
    
    func createTitleView(){
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(50)
        }
        
        for i in 0..<3{
            let titleSubView : UIView = {
                let titleSubView = UIView()
                titleSubView.backgroundColor = UIColor.black
                return titleSubView
            }()
            
            let titleBtn : UIButton  = {
                let titleBtn = UIButton()
                titleBtn .setTitle(titleArray[i], for: .normal)
                titleBtn .setTitleColor(UIColor.black, for: .normal)
                titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                titleBtn.titleLabel?.adjustsFontSizeToFitWidth = true
                titleBtn.titleLabel?.textAlignment = NSTextAlignment.center
                return titleBtn
            }()
            
            let titleLineView : UIView = {
                let titleLineView = UIView()
                titleLineView.backgroundColor = UIColor.black
                return titleLineView
            }()
            
            titleView.addSubview(titleSubView)
            titleSubView.snp.makeConstraints { make in
                make.left.equalTo(15 + i * (70 + 15))
                make.top.equalTo(15)
                make.width.equalTo(kScreenWidth / 3)
                make.height.equalTo(50)
            }
            
            titleSubView.addSubview(titleLineView)
            titleLineView.snp.makeConstraints { make in
                make.left.equalTo(20)
                make.bottom.equalTo(-1)
                make.width.equalTo(30)
                make.height.equalTo(1.5)
            }
        }
        
        
        
        titleView.addSubview(hideView)
        hideView.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.equalTo(15)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        hideView.addSubview(hideImgView)
        hideImgView.snp.makeConstraints { make in
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.width.height.equalTo(15)
        }
        
    }
    
    func createUI() {
        addSubview(recSuperView)
        recSuperView.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.top.equalTo(titleView.snp.bottom).offset(0)
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(kScreenHeight * 0.5)
        }
        
        for i in 0..<6 {
            for j in 0..<2 {
                let recSubView = UIView()
                recSubView.backgroundColor = UIColor.black
                recSubView.layer.borderColor = UIColor.blue.cgColor
                recSubView.layer.borderWidth = 1
                recSuperView.addSubview(recSubView)

                recSubView.snp.makeConstraints { make in
                    make.left.equalTo(10 + j * (Int(kScreenWidth)/2))
                    make.top.equalTo(titleView.snp.bottom).offset(20 + (i * (40 + 10)))
                    make.width.equalTo(kScreenWidth/2 - 20)
                    make.height.equalTo(40)
                }


                let recLineView = UIView()
                recLineView.backgroundColor = UIColor.gray
                recSubView.addSubview(recLineView)

                recLineView.snp.makeConstraints { make in
                    make.top.equalTo(10)
                    make.centerX.equalTo(self.recSuperView)
                    make.width.equalTo(1)
                    make.height.equalTo(20)
                }
                
                let recBtn = UIButton()
                let recSubviewWidth = Int(recSubView.bounds.size.width)
                recBtn .setTitleColor(UIColor.black, for: .normal)
                recBtn.backgroundColor = UIColor.orange
                recBtn.setTitle(recArray[i] as? String, for: .normal)
                recBtn.titleLabel?.font = UIFont .systemFont(ofSize: 15)
                recBtn.titleLabel?.lineBreakMode = NSLineBreakMode.byTruncatingTail
                recSubView.addSubview(recBtn)
                recBtn.snp.makeConstraints { make in
                    make.left.equalTo(j * recSubviewWidth)
                    make.top.equalTo(titleView.snp.bottom).offset(20 + (i * (40 + 10)))
                    make.width.equalTo(kScreenWidth/2 - 20)
                    make.height.equalTo(40)
                }
                
            }
            print(String(i))
            
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createTitleView()
        createUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
