//
//  MUMAttributeMode.swift
//  CornerRadiusDemo
//
//  Created by Chenp on 2018/8/11.
//  Copyright © 2018年 TestDemo. All rights reserved.
//

import UIKit

class MUMAttributeMode: NSObject {
    
    var attributeId:Int = 0
    var attributeName: String = ""
    var selected:Bool = false
    
    override init() {
        super.init()
    }
    
    convenience init(attributeId:Int, attributeName:String) {
        self.init()
        self.attributeId = attributeId
        self.attributeName = attributeName
    }

}
