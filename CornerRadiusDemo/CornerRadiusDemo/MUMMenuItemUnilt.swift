//
//  MUMMenuItemUnilt.swift
//  CornerRadiusDemo
//
//  Created by Chenp on 2018/8/11.
//  Copyright © 2018年 TestDemo. All rights reserved.
//

import UIKit

class MUMMenuItemUnilt: NSObject {
    
    class func isAttributeSelected(attributeModes:[MUMAttributeMode]) -> Bool {
        var status : Bool = false
        for item in attributeModes {
            if (item.selected == true) {
                status = true
                break
            }
        }
        
        return status
    }
    
    class func getAttributeSelectedTitle(attributeModes:[MUMAttributeMode]) -> String {
        var title : String = ""
        for item in attributeModes {
            if (item.selected == true) {
                if (title.count == 0) {
                    title = item.attributeName
                } else {
                    title = title + "," + item.attributeName
                }
            }
        }
        
        print(title)
        
        return title
    }

}
