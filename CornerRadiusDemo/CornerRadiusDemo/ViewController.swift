//
//  ViewController.swift
//  CornerRadiusDemo
//
//  Created by Chenp on 2018/8/10.
//  Copyright © 2018年 TestDemo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // menu
    private var menuView:MUMMenuView!
    // menu Attribute Detail View
    private var attributeDetailView:MUMMenuDetailView!
    // indicator View
    private var backGroundView: UIView!
    // current selected menuItem
    private var currentSelectedItem:MUMMenuItemView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weak var weakSelf = self
        menuView  = MUMMenuView.init(frame: CGRect.init(x: 0,
                                                        y: 40,
                                                        width: self.view.frame.size.width,
                                                        height: 40),
                                     titleArray: ["小米","华为","opple","步步高"])
        
        menuView.didClickItemBlock = {
            selectedItem in
            weakSelf?.showAttributeDetailView(showStatus: true)
            weakSelf?.currentSelectedItem = selectedItem
            weakSelf?.attributeDetailView.attributeArray = selectedItem.attributeMode
        }
        
        self.view.addSubview(menuView)
        
        
        
        attributeDetailView = MUMMenuDetailView.init(frame: CGRect.init(x: 0,
                                                                        y: -200,
                                                                        width: self.view.frame.size.width,
                                                                        height: 180))

        attributeDetailView.didChangeAttributeBlock = {
            selectedItems in
            weakSelf?.currentSelectedItem.attributeMode = selectedItems
            weakSelf?.showAttributeDetailView(showStatus: false)
            if (MUMMenuItemUnilt.isAttributeSelected(attributeModes: selectedItems)) {
                weakSelf?.currentSelectedItem.typeStyle = .selected
                weakSelf?.currentSelectedItem.updateTitleLabel(title: MUMMenuItemUnilt.getAttributeSelectedTitle(attributeModes: selectedItems))
            } else {
                weakSelf?.currentSelectedItem.typeStyle = .normal
                weakSelf?.currentSelectedItem.updateTitleLabel(title:"")
            }
            weakSelf?.menuView.updateBackCornerView(hiddenStatus: true)
            
        }
        self.view.insertSubview(attributeDetailView, belowSubview: menuView)
        
        backGroundView = UIView()
        backGroundView.frame = CGRect.init(x: 0,
                                           y: 100,
                                           width: self.view.frame.size.width,
                                           height: self.view.frame.size.height - 100)
        backGroundView.backgroundColor = UIColor.init(white: 0.3, alpha: 0.0)
        
        let tapGuesture = UITapGestureRecognizer.init(target: self,
                                                      action: #selector(hiddenAttributeDetailView))
        backGroundView.isUserInteractionEnabled = true
        tapGuesture.numberOfTapsRequired = 1
        backGroundView.addGestureRecognizer(tapGuesture)
        
    }
    
    @objc func hiddenAttributeDetailView() {
        self.showAttributeDetailView(showStatus: false)
        if (MUMMenuItemUnilt.isAttributeSelected(attributeModes: self.currentSelectedItem.attributeMode)) {
            self.currentSelectedItem.typeStyle = .selected
            self.currentSelectedItem.updateTitleLabel(title: MUMMenuItemUnilt.getAttributeSelectedTitle(attributeModes: self.currentSelectedItem.attributeMode))
        } else {
            self.currentSelectedItem.typeStyle = .normal
            self.currentSelectedItem.updateTitleLabel(title:"")
        }
    }
    
    fileprivate func showAttributeDetailView(showStatus:Bool) {
        if (showStatus) {
            self.view.insertSubview(backGroundView, belowSubview: attributeDetailView)
            UIView.animate(withDuration: 0.3) {
                self.attributeDetailView.frame.origin.y = 100
                self.backGroundView.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.attributeDetailView.frame.origin.y = -200
                self.backGroundView.backgroundColor = UIColor.init(white: 0.3, alpha: 0.0)
                self.menuView.updateBackCornerView(hiddenStatus: true)
            }) { (compelte) in
                self.backGroundView.removeFromSuperview()
            }
        }
    }

}

