//
//  MUMMenuView.swift
//  CornerRadiusDemo
//
//  Created by Chenp on 2018/8/10.
//  Copyright © 2018年 TestDemo. All rights reserved.
//

import UIKit

let padding:CGFloat = 8
let itemPerLine:CGFloat = 4
let itemWidth:CGFloat = (UIScreen.main.bounds.size.width - padding*5) / itemPerLine
let itemHeight:CGFloat = 30

typealias didSelctedItemBlock = (_ selectedItem: MUMMenuItemView) -> ()

class MUMMenuView: UIView {
    
    private var titleArray:[String] = [String]()
    
    private var titleLabelArray:[MUMMenuItemView] = [MUMMenuItemView]()
    
    private var backCornorView: MUMBackCornerView!
    private var bottomline: UIView!
    
    var didClickItemBlock:didSelctedItemBlock?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, titleArray: [String]) {
        self.init(frame: frame)
        self.titleArray = titleArray
        self.createBottomLine()
        self.createBackCornerView()
        self.createTitleLabels()
    }
    
    fileprivate func createTitleLabels() {
        
        for i in stride(from: 0, to: self.titleArray.count, by: 1) {
            
            let title = self.titleArray[i] as String
            
            var attributeModeArray:[MUMAttributeMode] = [MUMAttributeMode]()
            for j in stride(from: 0, to: self.titleArray.count, by: 1) {
                let attributeMode = MUMAttributeMode.init(attributeId: j,
                                                          attributeName: String.init(format: "%@_%d", title,j))
                attributeModeArray.append(attributeMode)
            }
            
            let originX = padding + (padding + itemWidth) * CGFloat(i).truncatingRemainder(dividingBy:itemPerLine)
            
            let titleLabel = MUMMenuItemView.init(frame: CGRect.init(x: originX,
                                                                     y: 5,
                                                                     width: itemWidth,
                                                                     height: itemHeight),
                                                  title: title,
                                                  style: MUMTitleTypeStyle.normal,
                                                  attributeMode: attributeModeArray)
            titleLabel.tag = i
            
            let tapGuesture = UITapGestureRecognizer.init(target: self,
                                                          action: #selector(titleLabelTapGuestureAction(_:)))
            titleLabel.isUserInteractionEnabled = true
            tapGuesture.numberOfTapsRequired = 1
            titleLabel.addGestureRecognizer(tapGuesture)
            
            self.addSubview(titleLabel)
            
            titleLabelArray.append(titleLabel)
            
        }
    }
    
    @objc func titleLabelTapGuestureAction(_ guesture: UITapGestureRecognizer) {
        
        let titleLabel = guesture.view as! MUMMenuItemView
        let index = titleLabel.tag
        
        for item in self.titleLabelArray {
            if (item.tag == index) {
                item.typeStyle = .expand
            } else {
                if (MUMMenuItemUnilt.isAttributeSelected(attributeModes: item.attributeMode)) {
                    item.typeStyle = .selected
                    item.updateTitleLabel(title: MUMMenuItemUnilt.getAttributeSelectedTitle(attributeModes: item.attributeMode))
                } else {
                    item.typeStyle = .normal
                    item.updateTitleLabel(title: "")
                }
            }
        }
        
        backCornorView.isHidden = false
        backCornorView.frame = CGRect.init(x: titleLabel.frame.origin.x,
                                           y: titleLabel.frame.origin.y,
                                           width: itemWidth,
                                           height: itemHeight + 5)
        
        if (self.didClickItemBlock != nil) {
            self.didClickItemBlock!(titleLabel)
        }
        
    }
    
    func updateBackCornerView(hiddenStatus:Bool) {
        self.backCornorView.isHidden = hiddenStatus
    }
    
    fileprivate func createBottomLine() {
        
        let lineView = UIView()
        
        lineView.frame = CGRect.init(x: 0,
                                     y: self.frame.size.height - 0.5,
                                     width: self.frame.size.width,
                                     height: 0.5)
        lineView.backgroundColor = UIColor.lightGray
        self.addSubview(lineView)
        self.bottomline = lineView
        
    }
    
    fileprivate func createBackCornerView() {
        
        backCornorView = MUMBackCornerView.init(frame: CGRect.init(x: 0,
                                                                   y: 0,
                                                                   width: itemWidth,
                                                                   height: itemHeight + 5))
        backCornorView.isHidden = true
        self.insertSubview(backCornorView, aboveSubview: self.bottomline)
        
    }

}
