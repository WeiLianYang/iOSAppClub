//
//  TableCellData.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2022/1/6.
//

import Foundation

// 自定义数据
class TableCellData: NSObject {
    var title: String = ""
    var subTitle: String = ""
    var imageName: String = ""
    
    
    override init() {
        super.init()
    
        title = "title"
        subTitle = "sub title"
        imageName = "demo"
    }
    
    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
    
    init(title: String, subTitle: String, imageName: String) {
        self.title = title
        self.subTitle = subTitle
        self.imageName = imageName
    }
}
