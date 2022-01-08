//
//  WaterFallLayout.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2022/1/8.
//  瀑布流布局：关键是对 UICollectionViewLayoutAttributes 进行运算与配置
//

import UIKit

class WaterFallFlowLayout: UICollectionViewFlowLayout {

    let itemCount: Int
    
    var attributeArray: Array<UICollectionViewLayoutAttributes> = Array<UICollectionViewLayoutAttributes>()
    
    required init?(coder: NSCoder) {
        itemCount = 0
        super.init(coder: coder)
    }
    
    init(itemCount: Int) {
        self.itemCount = itemCount
        super.init()
    }
    
    // 准备布局，进行自定义布局设置
    override func prepare() {
        super.prepare()
        
        // 设置为竖直布局
        self.scrollDirection = .vertical
        
        // 计算item高度
        let width = (UIScreen.main.bounds.size.width - self.minimumInteritemSpacing) / 2
        // 定义每一列的动态高度
        var columnHeight:(one: Int, two: Int) = (0, 0)
        
        for index in 0..<self.itemCount {
            // 设置1个分区
            let indexPath = IndexPath(item: index, section: 0)
            // 创建布局属性
            let attris = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            // 设置随机高度 [50, 200)
            let randomHeight = Int(arc4random() % 150 + 50)
            
            // 标记 列位置 和 高度
            var column = 0
            if columnHeight.one <= columnHeight.two {
                columnHeight.one += (randomHeight + Int(self.minimumInteritemSpacing))
                column = 0
            } else {
                columnHeight.two += (randomHeight + Int(self.minimumInteritemSpacing))
                column = 1
            }
            
            // 设置 item 位置
            let tempY = column == 0 ? columnHeight.one - randomHeight : columnHeight.two - randomHeight
            
            attris.frame = CGRect(x: (self.minimumInteritemSpacing + width) * CGFloat(column), y: CGFloat(tempY), width: width, height: CGFloat(randomHeight))
            
            attributeArray.append(attris)
            
            // 以最大一列高度作为计算每个item平均高度的中间值，保证滑动范围的正确性
            if columnHeight.one < columnHeight.two {
                self.itemSize = CGSize(width: width, height: CGFloat(columnHeight.two * 2 / self.itemCount) - self.minimumLineSpacing)
            } else {
                self.itemSize = CGSize(width: width, height: CGFloat(columnHeight.one * 2 / self.itemCount) - self.minimumLineSpacing)
            }
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributeArray
    }
    
}
