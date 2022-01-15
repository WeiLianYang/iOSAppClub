//
//  AutoLayoutViewController.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2022/1/15.
//

import UIKit

class AutoLayoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 要使用自动布局，需要设置 translatesAutoresizingMaskIntoConstraints 为 false
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.brown
        // 添加约束之前，先添加到父 View 上
        self.view.addSubview(view)
        
        // 1. 创建约束对象
        // item: 要添加约束的视图
        // attribute: 需设置为约束的属性
        // relatedBy: 约束方式
        // toItem: 约束需要参照的另一个视图
        // attribute: 约束的属性
        // multiplier: 约束的比例
        // constant: 约束值
        let constraint1 = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        
        let constraint2 = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        
        let constraint3 = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        
        let constraint4 = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        
        // 在父视图中心添加一个宽高为 100 的 View
        self.view.addConstraints([constraint1, constraint2, constraint3, constraint4])
        
        
        // 2. 使用格式化语言创建约束(VFL: visual format language)
        let view2 = UIView()
        view2.translatesAutoresizingMaskIntoConstraints = false
        view2.backgroundColor = UIColor.blue
        self.view.addSubview(view2)
        
        // 设置水平方向的约束，左右间距设置为 100
        let strHorizontal = "H:|-100-[view]-100-|"
        
        // 设置竖直方向的约束，顶部间距为 100，高度为 100
        let strVertical = "V:|-100-[view(100)]"
        
        let constraintH = NSLayoutConstraint.constraints(withVisualFormat: strHorizontal, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["view": view2])
        
        let constraintV = NSLayoutConstraint.constraints(withVisualFormat: strVertical, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["view": view2])
        
        self.view.addConstraints(constraintH)
        self.view.addConstraints(constraintV)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
