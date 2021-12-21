//
//  ViewController.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2021/11/28.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate, UIScrollViewDelegate {
    
    lazy var scrollView: UIScrollView = UIScrollView(frame: self.view.frame)
    
    lazy var imageView = UIImageView(image: UIImage(named: "tower"))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addUIScrollView()
        
        addNormalUILabel()
        
        addSpecialUILabel()
        
        addUiButton()
        
        addUIImageView1()
        
        addUIImageView2()
        
//        addZoomUIImageView()
        
        addUITextField()
        
        addUISwitchView1()
        addUISwitchView2()
        addUISwitchView3()
        
        addUIPageControlView()
        
        addUISegmentedControlView()
    }
    
    func addUIScrollView() {
        // 设置 UIScrollView 的代理为当前视图控制器本身
        scrollView.delegate = self

        // 设置 UIScrollView 的背景色
        scrollView.backgroundColor = UIColor.white
        // 设置 UIScrollView 的内容尺寸
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height * 1.5)
//        scrollView.contentSize = self.view.frame.size
        
        // 设置 UIScrollView 始终开启竖直方向的回弹效果
        scrollView.alwaysBounceVertical = true
        // 设置 UIScrollView 始终开启水平方向的回弹效果
        scrollView.alwaysBounceHorizontal = true
        
        // 设置 UIScrollView 显示竖直方向的滚动条
        scrollView.showsVerticalScrollIndicator = true
        // 设置 UIScrollView 显示水平方向的滚动条
        scrollView.showsHorizontalScrollIndicator = true
        
        // 设置 UIScrollView 自动定位分页效果
        scrollView.isPagingEnabled = true
        
        // 设置 UIScrollView 最小缩放比例
        scrollView.minimumZoomScale = 0.8
        // 设置 UIScrollView 最大缩放比例
        scrollView.maximumZoomScale = 1.6
        
        // 添加 UIScrollView
        self.view.addSubview(scrollView)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // 添加简单的 UILabel
    func addNormalUILabel() {
        // 创建 UILabel 控件
        let label = UILabel(frame: CGRect(x: 10, y: 30, width: 375, height: 130))
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
        scrollView.addSubview(label)
    }
    
    // 添加个性化的 UILabel
    func addSpecialUILabel() {
        let label = UILabel(frame: CGRect(x: 10, y: 150, width: 375, height: 60))
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
        
        scrollView.addSubview(label)
    }
    
    /**
     * 添加 UIButton
     */
    func addUiButton() {
        
        let uiButton = UIButton(type: UIButton.ButtonType.system)
        // UIButton 设置位置
        uiButton.frame = CGRect(x: 10, y: 230, width: 360, height: 38)
        // UIButton 设置颜色
        uiButton.backgroundColor = UIColor.cyan
        // UIButton 设置标题
        uiButton.setTitle("UIButton title", for: .normal)
        // UIButton 设置标题文字颜色
        uiButton.setTitleColor(UIColor.black, for: .normal)
        
        // UIButton 添加点击事件
        uiButton.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        // 添加 UIButton 到视图上
        scrollView.addSubview(uiButton)
        
        let uiButton2 = UIButton(type: UIButton.ButtonType.custom)
        uiButton2.frame = CGRect(x: 10, y: 280, width: 360, height: 80)
        uiButton2.backgroundColor = UIColor.cyan
        uiButton2.setTitle("Content Image", for: .normal)
        uiButton2.setTitleColor(UIColor.black, for: .normal)
        // UIButton 设置内容图片
        uiButton2.setImage(UIImage(named: "demo"), for: .normal)
        scrollView.addSubview(uiButton2)
        
        let uiButton3 = UIButton(type: UIButton.ButtonType.custom)
        uiButton3.frame = CGRect(x: 10, y: 370, width: 360, height: 80)
        uiButton3.backgroundColor = UIColor.cyan
        uiButton3.setTitle("Background Image", for: .normal)
        uiButton3.setTitleColor(UIColor.black, for: .normal)
        // UIButton 设置背景图片
        uiButton3.setBackgroundImage(UIImage(named: "demo"), for: .normal)
        scrollView.addSubview(uiButton3)
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
        imageView.frame = CGRect(x: 30, y: 460, width: 80, height: 80)
        scrollView.addSubview(imageView)
    }
    
    // 添加缩放 UIImageView
    func addZoomUIImageView() {
        imageView.frame = self.view.frame
        scrollView.addSubview(imageView)
    }
    
    // 添加 UIImageView，播放帧动画
    func addUIImageView2() {
        var imageArray = Array<UIImage>()
        for index in 1...15 {
            let uiImage = UIImage(named: "shark\(index)")
            imageArray.append(uiImage!)
        }
       
        let imageView = UIImageView(frame: CGRect(x: 150, y: 460, width: 80, height: 80))
        // 设置 UIImageView 的动画图片数组
        imageView.animationImages = imageArray
        // 设置 UIImageView 动画播放时长
        imageView.animationDuration = 3
        // 设置 UIImageView 动画播放次数，0 代表无限循环播放
        imageView.animationRepeatCount = 0
        scrollView.addSubview(imageView)
        
        imageView.startAnimating()
    }
    
    func addUITextField() {
        // 创建 UITextField
        let textField = UITextField(frame: CGRect(x: 30, y: 550, width: 300, height: 40))
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
        
        scrollView.addSubview(textField)
    }
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//
//    }
    
    func addUISwitchView1() {
        // 创建开关控件
        let si = UISwitch()
        // 设置位置
        si.center = CGPoint(x: 50, y: 620)
        // 设置 UISwitch 开启状态的颜色
        si.onTintColor = UIColor.green
        // 设置 UISwitch 普通状态的边框颜色
        si.tintColor = UIColor.red
        // 设置 UISwitch 滑块的颜色
        si.thumbTintColor = UIColor.white
        // 设置 UISwitch 初始状态
        si.isOn = true
        // 设置 UISwitch 开关样式
        si.preferredStyle = UISwitch.Style.automatic
        
        // 监听 UISwitch 开关状态变化
        si.addTarget(self, action: #selector(change), for: UIControl.Event.valueChanged)
        
        scrollView.addSubview(si)
    }
    
    @objc func change(si: UISwitch) {
        print("开关状态：\(si.isOn)")
    }
    
    func addUISwitchView2() {
        // 创建开关控件
        let si = UISwitch()
        // 设置位置
        si.center = CGPoint(x: 120, y: 620)
        // 设置 UISwitch 开启状态的颜色
        si.onTintColor = UIColor.green
        // 设置 UISwitch 普通状态的边框颜色
        si.tintColor = UIColor.red
        // 设置 UISwitch 滑块的颜色
        si.thumbTintColor = UIColor.white
        // 设置 UISwitch 初始状态
        si.isOn = false
        // 设置 UISwitch 开关样式
        si.preferredStyle = UISwitch.Style.sliding
        scrollView.addSubview(si)
    }
    
    func addUISwitchView3() {
        // 创建开关控件
        let si = UISwitch()
        // 设置位置
        si.center = CGPoint(x: 190, y: 620)
        // 设置 UISwitch 开启状态的颜色
        si.onTintColor = UIColor.green
        // 设置 UISwitch 普通状态的边框颜色
        si.tintColor = UIColor.red
        // 设置 UISwitch 滑块的颜色
        si.thumbTintColor = UIColor.white
        // 设置 UISwitch 初始状态
        si.isOn = true
        // 设置 UISwitch 开关样式
        si.preferredStyle = UISwitch.Style.checkbox
        scrollView.addSubview(si)
    }
    
    func addUIPageControlView() {
        // 创建分页控制器
        let pageControl = UIPageControl(frame: CGRect(x: 25, y: 650, width: 280, height: 30))
        // 设置 UIPageControl 页数
        pageControl.numberOfPages = 6
        // 设置 UIPageControl 背景色
        pageControl.backgroundColor = UIColor.gray
        // 设置 UIPageControl 页码点背景色
        pageControl.pageIndicatorTintColor = UIColor.white
        // 设置 UIPageControl 选中的页码点背景色
        pageControl.currentPageIndicatorTintColor = UIColor.red
        // 设置 UIPageControl 选中的页码数
        pageControl.currentPage = 2
        
        pageControl.addTarget(self, action: #selector(pageChange), for: UIControl.Event.valueChanged)
        
        scrollView.addSubview(pageControl)
    }
    
    @objc func pageChange(pc: UIPageControl) {
        print("分页控制器当前页码：\(pc.currentPage)")
        if (clearAll) {
            addUISegmentedControlView()
            insertCart = false
            insertMine = false
            insertClear = false
            clearAll = false
            updateImage = false
            updateTitle = false
        }
    }
    
    func addUISegmentedControlView() {
        // 创建分段控制器
//        let segmentedControl = UISegmentedControl(items: ["Home", "Circle", "Cart", "Mine"])
        let segmentedControl = UISegmentedControl(items: ["Home", "Circle"])

        // 设置 UISegmentedControl 控件位置
        segmentedControl.frame = CGRect(x: 25, y: 700, width: 340, height: 38)
        // 设置 UISegmentedControl 风格颜色
        segmentedControl.tintColor = UIColor.gray
        // 监听 UISegmentedControl 事件
        segmentedControl.addTarget(self, action: #selector(selectChange), for: UIControl.Event.valueChanged)
        
        scrollView.addSubview(segmentedControl)
    }
    
    var insertCart = false
    var insertMine = false
    var insertClear = false
    var clearAll = false
    
    var updateImage = false
    var updateTitle = false
    
    @objc func selectChange(sc: UISegmentedControl) {
        // 选中状态会消失
//        sc.isMomentary = true
        print("分段控制器当前页码：\(sc.selectedSegmentIndex)")
        if (sc.selectedSegmentIndex == 1 && !insertCart) {
            insertCart = true
            // UISegmentedControl 动态插入文字 item
            sc.insertSegment(withTitle: "Cart", at: 2, animated: true)
        } else if (sc.selectedSegmentIndex == 2 && !insertMine) {
            insertMine = true
            // UISegmentedControl 动态插入图片 item
            sc.insertSegment(with: UIImage(named: "portrait")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), at: 3, animated: false)
        } else if (sc.selectedSegmentIndex == 3) {
            if (clearAll) {
                // UISegmentedControl 删除所有 item
                sc.removeAllSegments()
                return
            }
            if (!insertClear) {
                insertClear = true
                // UISegmentedControl 动态插入图片 item
                sc.insertSegment(with: UIImage(named: "clear")?.withRenderingMode(UIImage.RenderingMode.automatic), at: 4, animated: true)
                // 设置 UISegmentedControl item 宽度 40
                sc.setWidth(40, forSegmentAt: 4)
            }
        } else if (insertCart && insertMine && insertClear && !updateImage) {
            // UISegmentedControl 修改指定位置的图片
            sc.setImage(UIImage(named: "EyeInvisible")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), forSegmentAt: 3)
            updateImage = true
        } else if (insertCart && insertMine && insertClear && !updateTitle) {
            // UISegmentedControl 修改指定位置的文本
            sc.setTitle("Recommend", forSegmentAt: 1)
            // 设置 UISegmentedControl 自适应内容的宽度
            sc.apportionsSegmentWidthsByContent = true
            updateTitle = true
        } else if (sc.selectedSegmentIndex == 4) {
            // UISegmentedControl 删除指定 item
            sc.removeSegment(at: 3, animated: true)
            clearAll = true
        }
        
    }
    
}

