//
//  ArchiveData.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2022/1/17.
//

import Foundation

// **************************
// *** 要遵守 NSCoding 协议 ***
// **************************
class ArchiveData: NSObject, NSSecureCoding {
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    var name: String?
    var age: NSInteger = 0
    
    override init() {
        super.init()
    }
    
    // 解归档
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        self.age = aDecoder.decodeInteger(forKey: "age")
    }
    
    // 归档
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(age, forKey: "age")
    }
}
