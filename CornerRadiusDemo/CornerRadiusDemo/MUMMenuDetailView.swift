//
//  MUMMenuDetailView.swift
//  CornerRadiusDemo
//
//  Created by Chenp on 2018/8/11.
//  Copyright © 2018年 TestDemo. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width

typealias didSelctedDetailItemBlock = (_ selectedItems: [MUMAttributeMode]) -> ()

class MUMMenuDetailView: UIView, UICollectionViewDelegate, UICollectionViewDataSource{
    
    private var collectionView: UICollectionView!
    
    var attributeArray: [MUMAttributeMode] = [MUMAttributeMode]() {
        didSet {
            self.tempAttributeArray = self.tempDeepCopy(originArray: attributeArray)
            self.collectionView.reloadData()
        }
    }
    
    private var tempAttributeArray:[MUMAttributeMode] = [MUMAttributeMode]()
    
    var didChangeAttributeBlock:didSelctedDetailItemBlock?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.createCollectionView()
        self.createBottomLineView()
        self.createAttributeResetButton()
        self.createAttributeSureButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func createCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10)
        // item的间隔
        layout.minimumInteritemSpacing = 8.0;
        // 设置行间距
        layout.minimumLineSpacing = 8.0
        // item size
        layout.itemSize = CGSize.init(width: (SCREEN_WIDTH - 30)/2, height: 30)
        // colllectionView
        collectionView = UICollectionView(frame: CGRect.init(x:0,
                                                             y:0,
                                                             width:SCREEN_WIDTH,
                                                             height:self.frame.size.height - 41),
                                          collectionViewLayout: layout)
        //注册一个cell
        collectionView.register(MUMMenuDetailCollectionCellCollectionViewCell.self, forCellWithReuseIdentifier:"cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        
        self.addSubview(collectionView)
        
    }
    
    //MARK: - Public Methods
    
    
    //MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tempAttributeArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! MUMMenuDetailCollectionCellCollectionViewCell
        let titleMode = self.tempAttributeArray[indexPath.row]

        cell.titleLabel.text = titleMode.attributeName
        if(titleMode.selected) {
           cell.titleLabel.backgroundColor = UIColor.cyan
        } else {
           cell.titleLabel.backgroundColor = UIColor.white
        }

        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let titleMode = self.tempAttributeArray[indexPath.row]
        titleMode.selected = !titleMode.selected
        collectionView.reloadData()
    }
    
    fileprivate func createBottomLineView() {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        lineView.frame = CGRect.init(x: 0,
                                    y: self.frame.size.height - 41,
                                    width: self.frame.size.width,
                                    height: 1)
        
        self.addSubview(lineView)
    }
    
    fileprivate func createAttributeResetButton() {
        
        let resetButton = UIButton()
        resetButton.backgroundColor = UIColor.white
        resetButton.frame = CGRect.init(x: 0,
                                        y: self.frame.size.height - 40,
                                        width: self.frame.size.width/2,
                                        height: 40)
        resetButton.setTitle("重置", for: UIControlState.normal)
        resetButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        resetButton.addTarget(self, action: #selector(resetButtonAction), for: UIControlEvents.touchUpInside)
        self.addSubview(resetButton)
        
    }
    
    fileprivate func createAttributeSureButton() {
        let sureButton = UIButton()
        sureButton.backgroundColor = UIColor.blue
        sureButton.frame = CGRect.init(x: self.frame.size.width/2,
                                        y: self.frame.size.height - 40,
                                        width: self.frame.size.width/2,
                                        height: 40)
        sureButton.setTitle("确定", for: UIControlState.normal)
        sureButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        sureButton.addTarget(self, action: #selector(sureButtonAction), for: UIControlEvents.touchUpInside)
        self.addSubview(sureButton)
    }
    
    fileprivate func tempDeepCopy(originArray:[MUMAttributeMode]) -> [MUMAttributeMode] {
        var deepCopyAttributeArray = [MUMAttributeMode]()
        
        for item in originArray {
            let attributeMode = MUMAttributeMode()
            attributeMode.attributeId = item.attributeId
            attributeMode.attributeName = item.attributeName
            attributeMode.selected = item.selected
            deepCopyAttributeArray.append(attributeMode)
        }
        return deepCopyAttributeArray
    }
    
    @objc func resetButtonAction() {
        
        for item in self.tempAttributeArray {
            item.selected = false
        }
        collectionView.reloadData()
    }
    
    @objc func sureButtonAction() {
        
        self.attributeArray = self.tempAttributeArray
        
        if (self.didChangeAttributeBlock != nil) {
            self.didChangeAttributeBlock!(self.attributeArray)
        }
        
    }

}
