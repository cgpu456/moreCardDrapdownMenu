//
//  MUMMenuDetailCollectionCellCollectionViewCell.swift
//  CornerRadiusDemo
//
//  Created by Chenp on 2018/8/11.
//  Copyright © 2018年 TestDemo. All rights reserved.
//

import UIKit

class MUMMenuDetailCollectionCellCollectionViewCell: UICollectionViewCell {
    
    var titleLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createContentUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createContentUI() {
        
        titleLabel = UILabel(frame: CGRect.init(x: 0,
                                                y: 0,
                                            width: (SCREEN_WIDTH - 30)/2,
                                           height: 30))
        titleLabel.layer.cornerRadius = 4
        titleLabel.layer.borderWidth = 0.5
        titleLabel.layer.masksToBounds = true
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.lightGray
        
        self .addSubview(titleLabel)
    }
}
