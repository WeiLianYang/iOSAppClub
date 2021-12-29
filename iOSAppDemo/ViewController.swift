//
//  ViewController.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2021/11/28.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate, CallbackProtocol {
    
    lazy var scrollView: UIScrollView = UIScrollView(frame: self.view.frame)
    
    lazy var imageView = UIImageView(image: UIImage(named: "tower"))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "控件列表视图"
        
        initNavigationBar()
        
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
        
        addUISliderView1()
        
        addUISliderView2()
        
        addUIActivityIndicatorView()
        
        addUIProgressView()
        
        addUIStepperView()
        
        addUIPickerView()
        
        addUIDatePicker()
        
        addUISearchBar()
    }
    
    func initNavigationBar() {
        let item = UIBarButtonItem(title: "Pop", style: UIBarButtonItem.Style.plain, target: self, action: #selector(popViewController))
        self.navigationItem.rightBarButtonItem = item
    }
    
    @objc func popViewController() {
        print("pop ViewController")
        self.navigationController?.popViewController(animated: true)
    }
    
    func addUIScrollView() {
        // 设置 UIScrollView 的代理为当前视图控制器本身
        scrollView.delegate = self

        // 设置 UIScrollView 的背景色
        scrollView.backgroundColor = UIColor.white
        // 设置 UIScrollView 的内容尺寸
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height * 2)
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
        scrollView.isPagingEnabled = false
        
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
        uiButton2.addTarget(self, action: #selector(intoLifecyclePage), for: .touchUpInside)
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
        
        let viewController = UILabelViewController(data: "从上一个界面传过来的文本")
        
        // 设置协议回调接口
        viewController.delegate = self
        
        // 设置闭包
        viewController.callback = {(data: String) in
            print("返回的内容：", data) // 返回的内容： 利用闭包回传值
        }
        
//        viewController.data = "从上一个界面传过来的文本"
        self.present(viewController, animated: true) {
            print("present complete")
        }
    }
    
    func callback(data: String) {
        print("返回的内容：", data) // 返回的内容： 利用协议回传值
    }
    
    @objc func intoLifecyclePage() {
        let viewController = LifecycleViewController()
        viewController.data = "测试 UIViewController 生命周期"
        self.present(viewController, animated: true) {
            print("present LifecycleViewController complete")
        }
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
    
    var insertCart = false, insertMine = false, insertClear = false
    var clearAll = false, updateImage = false, updateTitle = false
    
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
    
    func addUISliderView1() {
        // 创建 UISlider
        let slider = UISlider(frame: CGRect(x: 25, y: 750, width: 340, height: 30))
        // 设置 UISlider 的最大值
        slider.maximumValue = 100
        // 设置 UISlider 的最小值
        slider.minimumValue = 0
        // 设置 UISlider 初始值
        slider.value = 30
        // 设置 UISlider 滑块左侧进度条的颜色
        slider.minimumTrackTintColor = UIColor.green
        // 设置 UISlider 滑块右侧进度条的颜色
        slider.maximumTrackTintColor = UIColor.gray
        // 设置 UISlider 滑块颜色
        slider.thumbTintColor = UIColor.red
        
        // 监听 UISlider 滑块变化的值
        slider.addTarget(self, action: #selector(changeSlider), for: UIControl.Event.valueChanged)
        
        scrollView.addSubview(slider)
    }
    
    @objc func changeSlider(slider: UISlider) {
        print("UISlider value: \(slider.value)")
    }
    
    func addUISliderView2() {
        // 创建 UISlider
        let slider = UISlider(frame: CGRect(x: 25, y: 780, width: 340, height: 30))
        // 设置 UISlider 的最大值
        slider.maximumValue = 100
        // 设置 UISlider 的最小值
        slider.minimumValue = 0
        // 设置 UISlider 初始值
        slider.value = 30
        
        // 设置 UISlider 滑块图片
        slider.setThumbImage(UIImage(named: "portrait"), for: UIControl.State.normal)
        // 设置 UISlider 滑块左侧进度图片
        slider.setMinimumTrackImage(UIImage(named: "left-progress"), for: UIControl.State.normal)
        // 设置 UISlider 滑块右侧进度图片
        slider.setMaximumTrackImage(UIImage(named: "right-progress"), for: UIControl.State.normal)
        
        // 监听 UISlider 滑块变化的值
        slider.addTarget(self, action: #selector(changeSlider), for: UIControl.Event.valueChanged)
        // 设置 UISlider 连续回调监听事件（滑动结束后回调）
        slider.isContinuous = false
        
        scrollView.addSubview(slider)
    }
    
    // 活动指示器控件
    func addUIActivityIndicatorView() {
        // 创建 UIActivityIndicatorView
        let activity1 = UIActivityIndicatorView(style: .medium)
        // 设置 UIActivityIndicatorView 的位置
        activity1.center = self.view.center
        // 开始播放动画效果
        activity1.startAnimating()
        self.view.addSubview(activity1)
        
        let activity2 = UIActivityIndicatorView(style: .large)
        // 设置 UIActivityIndicatorView 的颜色
        activity2.color = UIColor.red
        activity2.center = scrollView.center
        // 开始播放动画效果
        activity2.startAnimating()
        scrollView.addSubview(activity2)
    }
    
    // 进度条控件
    func addUIProgressView() {
        // 创建 UIProgressView
        let progress1 = UIProgressView(progressViewStyle: UIProgressView.Style.default)
        // 设置 UIProgressView 的位置
        progress1.frame = CGRect(x: 25, y: 820, width: 340, height: 20)
        // 设置 UIProgressView 的进度 [0,1]
        progress1.progress = 0.3
        // 设置 UIProgressView 的已走过进度的进度条颜色
        progress1.progressTintColor = UIColor.green
        // 设置 UIProgressView 的未走过进度的进度条颜色
        progress1.trackTintColor = UIColor.gray
        
        scrollView.addSubview(progress1)
        
        // 创建 UIProgressView
        let progress2 = UIProgressView(progressViewStyle: UIProgressView.Style.default)
        // 设置 UIProgressView 的位置
        progress2.frame = CGRect(x: 25, y: 840, width: 340, height: 20)
        // 设置 UIProgressView 的进度 [0,1]
        progress2.progress = 0.5
        // 设置 UIProgressView 的已走过进度的进度条图片
        progress2.progressImage = UIImage(named: "left-progress")
        // 设置 UIProgressView 的未走过进度的进度条图片
        progress2.trackImage = UIImage(named: "right-progress")
        
        scrollView.addSubview(progress2)
        
        // 创建 UIProgressView
        let progress3 = UIProgressView(progressViewStyle: UIProgressView.Style.bar)
        // 设置 UIProgressView 的位置
        progress3.frame = CGRect(x: 25, y: 860, width: 340, height: 20)
        // 设置 UIProgressView 的进度 [0,1]
        progress3.progress = 0.85
        // 设置 UIProgressView 的已走过进度的进度条颜色
        progress3.progressTintColor = UIColor.green
        // 设置 UIProgressView 的未走过进度的进度条颜色
        progress3.trackTintColor = UIColor.gray
        
        scrollView.addSubview(progress3)
    }
    
    // 添加步进器控件
    func addUIStepperView() {
        // 创建 UIStepper
        let stepper = UIStepper(frame: CGRect(x: 25, y: 880, width: 0, height: 0))
        // 设置 UIStepper 颜色
        stepper.tintColor = UIColor.red
        // 设置 UIStepper 最小值
        stepper.minimumValue = 1
        // 设置 UIStepper 最大值
        stepper.maximumValue = 10
        // 设置 UIStepper 步长
        stepper.stepValue = 1
        
        // 设置 UIStepper 是否连续触发事件
        stepper.isContinuous = true
        // 设置 UIStepper 值自动叠加
        stepper.autorepeat = false
        // 设置 UIStepper 值是否循环
        stepper.wraps = true
        
        // 设置 UIStepper 交互事件
        stepper.addTarget(self, action:#selector(stepperChange), for: UIControl.Event.valueChanged)
        
        scrollView.addSubview(stepper)
        
        // 创建 UIStepper
        let stepper2 = UIStepper(frame: CGRect(x: 150, y: 880, width: 0, height: 0))
        // 设置 UIStepper 颜色
        stepper2.tintColor = UIColor.red
        // 设置 UIStepper 最小值
        stepper2.minimumValue = 1
        // 设置 UIStepper 最大值
        stepper2.maximumValue = 10
        // 设置 UIStepper 步长
        stepper2.stepValue = 1
        
        // 设置 UIStepper 背景图片
//        stepper2.setBackgroundImage(UIImage(named: "rectangle"), for: UIControl.State.normal)
        // 设置 UIStepper 分割线图片
        stepper2.setDividerImage(UIImage(named: "divider"), forLeftSegmentState: UIControl.State.normal, rightSegmentState: UIControl.State.normal)
        // 设置 UIStepper 增加按钮图片
        stepper2.setIncrementImage(UIImage(named: "plus"), for: UIControl.State.normal)
        // 设置 UIStepper 减少按钮图片
        stepper2.setDecrementImage(UIImage(named: "minus"), for: UIControl.State.normal)
        
        // 设置 UIStepper 交互事件
        stepper2.addTarget(self, action:#selector(stepperChange), for: UIControl.Event.valueChanged)
        
        scrollView.addSubview(stepper2)
    }
    
    @objc func stepperChange(stepper: UIStepper) {
        print("stepper value: \(stepper.value)")
    }
    
    // 添加选择器控件
    func addUIPickerView() {
        // 创建 UIPickerView
        let pickerView = UIPickerView(frame: CGRect(x: 15, y: 900, width: 350, height: 150))
        // 设置 UIPickerView 代理
        pickerView.delegate = self
        // 设置 UIPickerView 数据源
        pickerView.dataSource = self
        
        // 打印 UIPickerView 的组数
        print("numberOfComponents: \(pickerView.numberOfComponents)")
        // 打印 UIPickerView 的指定组的行数
        print("numberOfRows: \(pickerView.numberOfRows(inComponent: 0))")
        // 打印 UIPickerView 的指定组的行尺寸
        print("rowSize: \(pickerView.rowSize(forComponent: 1))")
        // 获取 UIPickerView 的指定组，指定行的自定义视图
//        let view = pickerView.view(forRow: 1, forComponent: 0)
        // 重新加载 UIPickerView 全部分组数据
        pickerView.reloadAllComponents()
        // 重新加载 UIPickerView 指定分组数据
        pickerView.reloadComponent(1)
        // 获取指定组选中的行
        print("selectedRow: \(pickerView.selectedRow(inComponent: 1))")
        // 主动选中 指定组的指定行，带动画效果
        pickerView.selectRow(1, inComponent: 2, animated: true)
        
        scrollView.addSubview(pickerView)
    }
    
    lazy var provine = ["湖北省", "湖南省", "广东省", "江苏省", "浙江省", "山东省"]
    lazy var city =    ["武汉市", "长沙市", "广州市", "南京市", "杭州市", "济南市"]
    lazy var area =    ["武昌区", "番禺区", "白云区", "荔湾区", "天河区", "越秀区"]
    
    // 返回选择器每个分组的行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return provine.count
    }
    
    // 返回选择器分组数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    // 返回选择器每个分组中每行数据的标题
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("第\(component + 1)组，第\(row + 1)行")
        if (component == 0) {
            return provine[row]
        } else if (component == 1) {
            return city[row]
        } else {
            return area[row]
        }
    }
    
    // 设置可变字符串
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var title: String
        if (component == 0) {
            title = provine[row]
        } else if (component == 1) {
            title = city[row]
        } else {
            title = area[row]
        }
        let attStr = NSMutableAttributedString(string: title)
        attStr.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.purple], range: NSRange(location: 0, length: attStr.length))
        return attStr
    }
    
    // 设置图片内容视图
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIImageView(image: UIImage(named: "demo"))
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        return view
    }
    
    // UIPickerView 选中事件监听
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("选择了第\(component + 1)组，第\(row + 1)行")
    }
    
    // 设置 UIPickerView 每个组的宽度
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if (component == 0) {
            return 120
        } else if (component == 1) {
            return 100
        } else {
            return 50
        }
    }
    
    // 设置 UIPickerView 每组每行的高度
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    // 添加时间选择器 UIDatePicker
    func addUIDatePicker() {
        // 创建 UIDatePicker
        let picker1 = UIDatePicker(frame: CGRect(x: 15, y: 1050, width: 350, height: 150))
        // 设置 UIDatePicker 模式
        picker1.datePickerMode = UIDatePicker.Mode.countDownTimer // 计时器模式
        // 设置 UIDatePicker 在计时模式下显示的时间差
        picker1.countDownDuration = TimeInterval(1 * 1000)
        // 设置 UIDatePicker 在计时模式下相邻时间的时间间隔
        picker1.minuteInterval = 10 // 每间隔 10 分钟
        
        picker1.addTarget(self, action: #selector(changeDatePicker), for: UIControl.Event.valueChanged)
        
        
        let picker2 = UIDatePicker(frame: CGRect(x: 15, y: 1250, width: 350, height: 50))
        picker2.datePickerMode = UIDatePicker.Mode.date // 日期模式
        // 设置 UIDatePicker 显示的最小日期
        picker2.minimumDate = Date(timeIntervalSince1970: TimeInterval(662659200)) // 1991-01-01
        // 设置 UIDatePicker 显示的最大日期
        picker2.maximumDate = Date(timeIntervalSince1970: TimeInterval(1640880000)) // 2021-12-31
        
        let picker3 = UIDatePicker(frame: CGRect(x: 15, y: 1300, width: 350, height: 50))
        picker3.datePickerMode = UIDatePicker.Mode.time // 时间模式
        
        let picker4 = UIDatePicker(frame: CGRect(x: 15, y: 1350, width: 350, height: 50))
        picker4.datePickerMode = UIDatePicker.Mode.dateAndTime // 日期时间模式
        // 设置 UIDatePicker 地区，不设置则默认当前地区
        picker4.locale = Locale.current
        // 设置 UIDatePicker 时区，不设置则默认当前时区
        picker4.timeZone = TimeZone.current
        // 设置 UIDatePicker 选中的日期
        picker4.date = Date(timeIntervalSince1970: TimeInterval(1640390400)) // 2021-12-25 08:00:00
        
        picker4.addTarget(self, action: #selector(changeDatePicker), for: UIControl.Event.valueChanged)
        
        scrollView.addSubview(picker1)
        scrollView.addSubview(picker2)
        scrollView.addSubview(picker3)
        scrollView.addSubview(picker4)
        
    }
    
    @objc func changeDatePicker(picker: UIDatePicker) {
        print("选中的时间：\(picker.date)，\(picker.countDownDuration)")
    }
    
    // 添加搜索栏 UISearchBar
    func addUISearchBar() {
        // 创建 UISearchBar
        let searchBar = UISearchBar(frame: CGRect(x: 15, y: 1400, width: 350, height: 150))
        // 设置 UISearchBar 风格
        searchBar.searchBarStyle = UISearchBar.Style.minimal // 极简风格
        // 设置 UISearchBar 风格颜色
        searchBar.barTintColor = UIColor.cyan
        // 设置 UISearchBar 背景图片
//        searchBar.backgroundImage = UIImage(named: "demo")
        // 设置 UISearchBar 提示文字
        searchBar.placeholder = "请输入关键字"
        // 设置 UISearchBar 标题
        searchBar.prompt = "搜索框控件标题"
        // 显示 UISearchBar 右侧取消按钮
        searchBar.showsCancelButton = true
        // 显示 UISearchBar 书库按钮
        searchBar.showsBookmarkButton = true
        // 显示 UISearchBar 搜索结果按钮
        searchBar.showsSearchResultsButton = false
        
        // 设置 UISearchBar 显示附件视图
        searchBar.showsScopeBar = true
        // 设置 UISearchBar 附件视图的标题
        searchBar.scopeButtonTitles = ["综合", "销量", "价格", "筛选"]
        // 设置 UISearchBar 附件视图默认选中的索引
        searchBar.selectedScopeButtonIndex = 1
        
        // 设置协议实例
        searchBar.delegate = self
        
        scrollView.addSubview(searchBar)
    }
    
    // 搜索栏将要开始编辑时回调，返回 true 允许进入编辑态，否则不允许
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldBeginEditing")
        return true
    }
    
    // 搜索栏已经开始编辑时回调
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidBeginEditing")
    }
    
    // 搜索栏将要结束编辑时回调，返回 true 允许结束编辑态，否则不允许
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldEndEditing")
        return true
    }
    
    // 搜索栏已经结束编辑时回调
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing")
    }
    
    // 搜索栏的文本发生变化时回调。非常重要
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchBar, searchText: \(searchText)")
    }
    
    // 搜索栏的文本将要发生变化时回调，返回 false 则此次修改无效
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("searchBar, replacementText: \(text)")
        return true
    }
    
    // 点击键盘上的搜索按钮时回调
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
    }
    
    // 点击搜索栏的书库按钮时回调
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarBookmarkButtonClicked")
    }
    
    // 点击搜索栏的取消按钮时回调
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
    }
    
    // 点击搜索栏的搜索结果按钮时回调
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarResultsListButtonClicked")
    }
    
    // 点击搜索栏的附件视图上的选项按钮时回调
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("searchBar, selectedScopeButtonIndexDidChange: \(selectedScope)")
    }
    
}

