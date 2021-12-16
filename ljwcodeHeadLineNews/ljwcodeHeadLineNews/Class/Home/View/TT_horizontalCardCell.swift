//
//  TT_horizontalCardCell.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/9/1.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import UIKit

@objc(TT_horizontalCardCell)

class TT_horizontalCardCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

   @objc public var newsModel = microVideoDetailModel() {
        didSet{
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsModel.microInfoModel.data.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = "TTHorizontalHuoShanVideoCollectionCell"
        let collectionViewCell : TTHorizontalHuoShanVideoCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TTHorizontalHuoShanVideoCollectionCell
        collectionViewCell.newsModel = newsModel
        return collectionViewCell
    }
    
    private lazy var TTHorizontalHuoShanVideoCollectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let itemWith = self.bounds.width * 2 / 3
        let itemHeight = self.bounds.height
        flowLayout.itemSize = CGSize(width: itemWith, height:itemHeight)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 5)
        
        let TTHorizonalHuoShanVideoCollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: itemWith, height: itemHeight), collectionViewLayout: flowLayout)
        TTHorizonalHuoShanVideoCollectionView.delegate = self
        TTHorizonalHuoShanVideoCollectionView.dataSource = self
        
        TTHorizonalHuoShanVideoCollectionView.delete(self)
        
        TTHorizonalHuoShanVideoCollectionView .register(TTHorizontalHuoShanVideoCollectionCell.classForCoder(), forCellWithReuseIdentifier: "TTHorizontalHuoShanVideoCollectionCell")
        
        
        return TTHorizonalHuoShanVideoCollectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
