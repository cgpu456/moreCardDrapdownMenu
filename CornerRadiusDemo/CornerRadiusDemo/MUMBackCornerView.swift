//
//  MUMBackCornerView.swift
//  CornerRadiusDemo
//
//  Created by Chenp on 2018/8/10.
//  Copyright © 2018年 TestDemo. All rights reserved.
//

import UIKit

class MUMBackCornerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.lightGray
        self.layer.cornerRadius = self.frame.size.height / 4
        self.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMaxXMinYCorner]
        self.layer.masksToBounds = true
        
        self.createMinBackCornerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createMinBackCornerView() {
        
        let mincornerView = UIView()
        mincornerView.frame = CGRect.init(x: 0.5,
                                          y: 0.5,
                                          width: self.frame.size.width - 1,
                                          height: self.frame.size.height)
        
        mincornerView.backgroundColor = UIColor.white
        mincornerView.layer.cornerRadius = self.frame.size.height / 4
        mincornerView.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMaxXMinYCorner]
        mincornerView.layer.masksToBounds = true
        self.addSubview(mincornerView)
        
    }
    
}
