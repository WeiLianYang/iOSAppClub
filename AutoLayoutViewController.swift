//
//  AutoLayoutViewController.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2022/1/15.
//

import UIKit
import SnapKit

class AutoLayoutViewController: UIViewController, UITextViewDelegate {
    
    lazy var view3 = UIView()
    lazy var view4 = UIView()
    
    lazy var textView = UITextView()
    
    let contentMaxHeight = CGFloat(80)

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
        
        // 3. 使用 SnapKit
        
        view3.backgroundColor = UIColor.red
        self.view.addSubview(view3)
        
        // 设置宽高 50，位置居中
        view3.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
            make.center.equalTo(self.view)
        }
        
        view4 = UIView()
        view4.backgroundColor = UIColor.red
        self.view.addSubview(view4)
        
        // 设置宽高 50，位置居中
        view4.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(150)
            make.right.equalTo(-150)
            make.top.equalTo(240)
            make.bottom.equalTo(-510)
        }
        
        
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.delegate = self
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        self.view.addSubview(textView)
        
        textView.snp.makeConstraints { make in
            make.leading.equalTo(150)
            make.trailing.equalTo(-150)
            make.top.equalTo(500)
            make.height.equalTo(30)
        }
        
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 更新约束
        view4.snp.updateConstraints { make in
            make.left.equalTo(100)
            make.right.equalTo(-100)
        }
        
        // 移除所有约束
        view3.snp.removeConstraints()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("bounds.size.height: ", textView.bounds.size.height, ", contentSize.height: ", textView.contentSize.height)
        if textView.bounds.size.height >= contentMaxHeight {
            if (textView.contentSize.height < textView.bounds.size.height) {
                // 当视图高度超过了最大高度，且文本高度小于视图高度，则更新约束高度为文本高度。
                // 会在逐行删除时回调
                print("case 1")
                textView.snp.updateConstraints { make in
                    make.height.equalTo(textView.contentSize.height)
                }
            }
        }
        if (textView.contentSize.height != textView.bounds.size.height) && textView.bounds.size.height < contentMaxHeight {
            // 当 文本高度 和 视图高度不一致，且视图高度小于最大高度时，设置约束高度为 文本的高度，并使用动画过渡
            // 会在持续输入文本内容时回调
            print("case 2")
            textView.snp.updateConstraints { make in
                make.height.equalTo(textView.contentSize.height)
            }
            // 布局变化使用动画过渡
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        return true
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
