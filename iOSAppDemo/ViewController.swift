//
//  ViewController.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2021/11/28.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addNormalUILabel()
        
        addSpecialUILabel()
        
        addUiButton()
        
        addUIImageView1()
        
        addUIImageView2()
        
        addUITextField()
    }
    
    // 添加简单的 UILabel
    func addNormalUILabel() {
        // 创建 UILabel 控件
        let label = UILabel(frame: CGRect(x: 0, y: 30, width: 375, height: 130))
        // UILabel 设置文本
        label.text = "自定义简单的便签控件：设置长文本，字体加粗，字号18，颜色为蓝色，阴影为橙色，位置偏移参数为2，文字对齐模式居左，显示行数为4行"
        // UILabel 设置字体，字号22，加粗
        label.font = UIFont.boldSystemFont(ofSize: 18)
        // UILabel 设置字体颜色
        label.textColor = UIColor.blue
        // UILabel 设置阴影颜色
        label.shadowColor = UIColor.orange
        // UILabel 设置阴影位置偏移参数 3
        label.shadowOffset = CGSize(width: 3, height: 3)
        // UILabel 设置文字对齐模式，靠左对齐
        label.textAlignment = NSTextAlignment.left
        // UILabel 设置文本显示行数，为 0 表示不限制行数
        label.numberOfLines = 4
        
        // 添加控件到视图上
        self.view.addSubview(label)
    }
    
    // 添加个性化的 UILabel
    func addSpecialUILabel() {
        let label = UILabel(frame: CGRect(x: 15, y: 160, width: 375, height: 60))
        // UILabel 设置默认字体，字号12，加粗
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        
        // 设置可变属性文本
        let attStr = NSMutableAttributedString(string: "可变属性字符串，可以分段设置字体、颜色、下划线、阴影和超链接。")
        
        // 1. 设置下标范围为 [0,1] 的文本为字体22，颜色为黑色
        attStr.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30), NSAttributedString.Key.foregroundColor:UIColor.black], range: NSRange(location: 0, length: 2))
        
        // 2. 设置下标范围为 [2,4] 的文本为字体16，颜色为红色
        attStr.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22), NSAttributedString.Key.foregroundColor:UIColor.red], range: NSRange(location: 2, length: 3))
        
        // 3. 给下标范围为 [20,22] 的文本添加下划线，设置下划线颜色
        attStr.addAttributes([NSAttributedString.Key.underlineStyle: NSNumber.init(value: 1), NSAttributedString.Key.underlineColor: UIColor.red], range: NSRange(location: 20, length: 3))
        
        // 4. 给下标范围为 [24,25] 的文本添加阴影，设置阴影颜色
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 2, height: 2)
        shadow.shadowColor = UIColor.cyan
        attStr.addAttributes([NSAttributedString.Key.shadow: shadow], range: NSRange(location: 24, length: 2))
        
        // 5. 给下标范围为 [27,29] 的文本添加超链接
        let link = NSString(string: "https://www.baidu.com")
        attStr.addAttributes([NSAttributedString.Key.link: link], range: NSRange(location: 27, length: 3))
        
        // 设置可变文本
        label.attributedText = attStr
        
        self.view.addSubview(label)
    }
    
    /**
     * 添加 UIButton
     */
    func addUiButton() {
        
        let uiButton = UIButton(type: UIButton.ButtonType.system)
        // UIButton 设置位置
        uiButton.frame = CGRect(x: 10, y: 240, width: 360, height: 40)
        // UIButton 设置颜色
        uiButton.backgroundColor = UIColor.cyan
        // UIButton 设置标题
        uiButton.setTitle("UIButton title", for: .normal)
        // UIButton 设置标题文字颜色
        uiButton.setTitleColor(UIColor.black, for: .normal)
        
        // UIButton 添加点击事件
        uiButton.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        // 添加 UIButton 到视图上
        self.view.addSubview(uiButton)
        
        let uiButton2 = UIButton(type: UIButton.ButtonType.custom)
        uiButton2.frame = CGRect(x: 10, y: 290, width: 360, height: 100)
        uiButton2.backgroundColor = UIColor.cyan
        uiButton2.setTitle("Content Image", for: .normal)
        uiButton2.setTitleColor(UIColor.black, for: .normal)
        // UIButton 设置内容图片
        uiButton2.setImage(UIImage(named: "demo"), for: .normal)
        self.view.addSubview(uiButton2)
        
        let uiButton3 = UIButton(type: UIButton.ButtonType.custom)
        uiButton3.frame = CGRect(x: 10, y: 400, width: 360, height: 100)
        uiButton3.backgroundColor = UIColor.cyan
        uiButton3.setTitle("Background Image", for: .normal)
        uiButton3.setTitleColor(UIColor.black, for: .normal)
        // UIButton 设置背景图片
        uiButton3.setBackgroundImage(UIImage(named: "demo"), for: .normal)
        self.view.addSubview(uiButton3)
    }
    
    @objc func touchUpInside() {
        print("按钮被按下，并且在控件区域内抬起")
    }
    
    // 添加 UIImageView
    func addUIImageView1() {
        let uiImage = UIImage(named: "demo")
        let size = uiImage?.size
        print(size?.width.description as Any, size?.height.description as Any)
        
        let imageView = UIImageView(image: uiImage)
        // 设置 UIImageView 的尺寸和位置
        imageView.frame = CGRect(x: 30, y: 510, width: 100, height: 100)
        self.view.addSubview(imageView)
    }
    
    // 添加 UIImageView，播放帧动画
    func addUIImageView2() {
        var imageArray = Array<UIImage>()
        for index in 1...15 {
            let uiImage = UIImage(named: "shark\(index)")
            imageArray.append(uiImage!)
        }
       
        let imageView = UIImageView(frame: CGRect(x: 150, y: 510, width: 100, height: 100))
        // 设置 UIImageView 的动画图片数组
        imageView.animationImages = imageArray
        // 设置 UIImageView 动画播放时长
        imageView.animationDuration = 3
        // 设置 UIImageView 动画播放次数，0 代表无限循环播放
        imageView.animationRepeatCount = 0
        self.view.addSubview(imageView)
        
        imageView.startAnimating()
    }
    
    func addUITextField() {
        // 创建 UITextField
        let textField = UITextField(frame: CGRect(x: 30, y: 620, width: 300, height: 40))
        // 设置 UITextField 的边框风格
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        // 设置 UITextField 的文字颜色
        textField.textColor = UIColor.black
        // 设置 UITextField 的文字对齐方式
        textField.textAlignment = NSTextAlignment.left
        // 设置 UITextField 的提示文字
        textField.placeholder = "please input your name"
                
        // 设置 UITextField 的左视图
        let leftImageView = UIImageView(image: UIImage(named: "portrait"))
        leftImageView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        textField.leftView = leftImageView
        
        // 设置 UITextField 的右视图
        let rightImageView = UIImageView(image: UIImage(named: "EyeInvisible"))
        rightImageView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        textField.rightView = rightImageView
        
        // 设置 UITextField 的左视图显示模式为一直显示
        textField.leftViewMode = UITextField.ViewMode.always
        // 设置 UITextField 的右视图显示模式为不处于编辑状态时才显示
        textField.rightViewMode = UITextField.ViewMode.unlessEditing
        
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        // 设置 UITextField 的代理为当前视图控制器
//        textField.delegate = self as UITextViewDelegate
        
        self.view.addSubview(textField)
    }
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//
//    }
    
}

