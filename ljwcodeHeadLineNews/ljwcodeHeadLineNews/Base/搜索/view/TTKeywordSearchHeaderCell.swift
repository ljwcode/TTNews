//
//  TTKeywordSearchHeaderCell.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2022/2/8.
//  Copyright © 2022 ljwcode. All rights reserved.
//

import UIKit

class TTKeywordSearchHeaderCell : UICollectionViewCell {
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//extension TTKeywordSearchHeaderCell : UICollectionViewFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
//
//}
