//
//  MUMMenuItemView.swift
//  CornerRadiusDemo
//
//  Created by Chenp on 2018/8/10.
//  Copyright © 2018年 TestDemo. All rights reserved.
//

import UIKit

enum MUMTitleTypeStyle: Int {
    case normal = 0        //正常
    case expand = 1        //展开
    case selected = 2      //选中
}

class MUMMenuItemView: UIView {
    
    // 标题
    private var title:String = ""
    // 标题标签
    private var titleLabel:UILabel!
    // 属性
    var attributeMode:[MUMAttributeMode] = [MUMAttributeMode]()
    
    var typeStyle:MUMTitleTypeStyle = MUMTitleTypeStyle.normal {
        didSet {
            switch typeStyle {
            case .normal:
                self.backgroundColor = UIColor.lightGray
                self.layer.cornerRadius = self.frame.size.height / 2
                self.layer.borderColor = UIColor.white.cgColor
                self.layer.borderWidth = 1.0
                self.layer.masksToBounds = true
                self.titleLabel.textColor = UIColor.black
                break
            case .expand:
                self.backgroundColor = UIColor.clear
                self.layer.cornerRadius = self.frame.size.height / 2
                self.layer.borderColor = UIColor.clear.cgColor
                self.layer.borderWidth = 1.0
                self.layer.masksToBounds = true
                if (MUMMenuItemUnilt.isAttributeSelected(attributeModes: self.attributeMode)) {
                    self.titleLabel.textColor = UIColor.yellow
                } else {
                    self.titleLabel.textColor = UIColor.lightGray
                }
                break
            case .selected:
                self.backgroundColor = UIColor.cyan
                self.layer.cornerRadius = self.frame.size.height / 2
                self.layer.borderColor = UIColor.white.cgColor
                self.layer.borderWidth = 1.0
                self.layer.masksToBounds = true
                self.titleLabel.textColor = UIColor.yellow
                break
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect,
                     title: String,
                     style: MUMTitleTypeStyle,
                     attributeMode:[MUMAttributeMode]) {
        
        self.init(frame: frame)
        self.title = title
        self.typeStyle = style
        self.createTitleLabel()
        self.updateTitleLabel(title: title)
        self.attributeMode = attributeMode
        
        self.backgroundColor = UIColor.lightGray
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
    }
    
    fileprivate func createTitleLabel() {
        titleLabel = UILabel()
        titleLabel.frame = CGRect.init(x: 5,
                                       y: 5,
                                       width: self.frame.size.width - 10 ,
                                       height: self.frame.size.height - 10)
        titleLabel.textColor = UIColor.black
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(titleLabel)
    }
    
    func updateTitleLabel(title:String) {
        if (title.count != 0 && title != self.title) {
            self.titleLabel.text = title
        } else {
            self.titleLabel.text = self.title
        }
    }

}
