//
//  AnimationViewController.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2022/1/9.
//

import UIKit
import ImageIO

class AnimationViewController: UIViewController {
        
    var animationView1: UIView?
    
    var animationView2: UIView?
    
    let gifWH = 150

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView1 = UIView(frame: CGRect(x: 20, y: 30, width: 100, height: 100))
        animationView1?.backgroundColor = UIColor.red
        self.view.addSubview(animationView1!)
        
        animationView2 = UIView(frame: CGRect(x: 230, y: 30, width: 100, height: 100))
        animationView2?.backgroundColor = UIColor.cyan
        self.view.addSubview(animationView2!)
        
        let imageView = UIImageView(frame: CGRect(x: 30, y: 150, width: gifWH, height: gifWH))
        self.view.addSubview(imageView)
        
        // 通过 UIImageView 播放 Gif 动画加载速度会更快，但是使用复杂
        loadGifWithImageView(imageView: imageView, name: "shark")
        
        let webView = UIWebView(frame: CGRect(x: 60 + gifWH, y: 150, width: gifWH, height: gifWH))
        self.view.addSubview(webView)
        
        // 通过 UIWebView 播放 Gif 动画加载速度慢，但是动画更流畅
        loadGifWithWebView(webView: webView, name: "shark")
        
        addGradientLayer()
        
        addReplicatorLayer()
        
        addShapeLayer()
        
        addEmitterLayer()
        
        addEmitterLayer2()
    }
    
    // 用户点击界面时回调
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 时长1秒，改变背景色，完成后执行修改坐标位置
        UIView.animate(withDuration: 1, animations: {
            self.animationView1?.backgroundColor = UIColor.blue
        }) { (finish) in
            // 上一个动画执行完成后继续执行位移动画
            UIView.animate(withDuration: 2, animations: {
                self.animationView1?.center = CGPoint(x: 120, y: 80)
            })
        }
        
        // 延时2秒执行，时长1秒，循环执行
        /*
        UIView.animate(withDuration: 1, delay: 2, options: [UIView.AnimationOptions.repeat], animations: {
            self.animationView?.backgroundColor = UIColor.blue
        }, completion: nil)
         */
        
        // 阻尼动画（带回弹效果）
        /*
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.animationView?.center = CGPoint(x: 150, y: 200)
        }, completion: nil)
         */
        
        // 切换内容
        UIView.transition(with: animationView2!, duration: 3, options: UIView.AnimationOptions.transitionCurlUp, animations: {
            // 此处可以修改内容
        }, completion: nil)
        
        // 要变化的目标View
        let otherView = UIView(frame: CGRect(x: 220, y: 30, width: 100, height: 100))
        otherView.backgroundColor = UIColor.red
        // 切换视图
        UIView.transition(from: animationView2!, to: otherView, duration: 3, options: UIView.AnimationOptions.transitionCurlUp, completion: nil)
        
//        playAnimation1()
        
//        playAnimation2()
        
        playAnimation3()
        
        playAnimation4()
        
        playGroupAnimation()
    }
    
    
    func loadGifWithImageView(imageView: UIImageView, name: String) {
        // 创建素材路径
        let path = Bundle.main.path(forResource: name, ofType: "gif")
        // 通过路径创建素材 url
        let url = URL.init(fileURLWithPath: path!)
        // 创建素材实例
        let source = CGImageSourceCreateWithURL(url as CFURL, nil)
        // 获取素材中图片的张数
        let count = CGImageSourceGetCount(source!)
        
        // 存放所有图片的数组
        var imageArray = Array<UIImage>()
        // 存放所有图片宽度的数组
        var widthArray = Array<Int>()
        // 存放所有图片高度的数组
        var heightArray = Array<Int>()
        // 图片播放时长
        var time: Int = Int()
        
        for index in 0..<count {
            // 从素材实例中获取图片
            let image = CGImageSourceCreateImageAtIndex(source!, index, nil)
            
            imageArray.append(UIImage(cgImage: image!))
            
            // 获取图片信息数组
            let info = CGImageSourceCopyPropertiesAtIndex(source!, index, nil) as! Dictionary<String, AnyObject>
            // 获取宽高
            let width = Int(truncating: info[kCGImagePropertyPixelWidth as String]! as! NSNumber)
            let height = Int(truncating: info[kCGImagePropertyPixelHeight as String]! as! NSNumber)
            
            widthArray.append(width)
            heightArray.append(height)
            
            // 获取时间
            let timeDic = info[kCGImagePropertyGIFDictionary as String]! as! Dictionary<String, AnyObject>
            time += Int(truncating: timeDic[kCGImagePropertyGIFDelayTime as String]! as! NSNumber)
            
            var imgWidth = widthArray[0]
            if (imgWidth > gifWH) {
                imgWidth = gifWH
            }
            var imgHeight = heightArray[0]
            if (imgHeight > gifWH) {
                imgHeight = gifWH
            }
            
            // 设置 ImageView 尺寸
            imageView.frame = CGRect(x: 30, y: 150, width: imgWidth, height: imgHeight)
            // 播放动画
            imageView.animationImages = imageArray
            imageView.animationDuration = TimeInterval(time)
            imageView.animationRepeatCount = 0
            imageView.startAnimating()
        }
    }
    
    func loadGifWithWebView(webView: UIWebView, name: String) {
        let path = Bundle.main.path(forResource: name, ofType: "gif")
        let url = URL.init(fileURLWithPath: path!)
        let imageData = try! Data(contentsOf: url)
        
        webView.scrollView.bounces = false
        webView.backgroundColor = UIColor.clear
        webView.scalesPageToFit = true
        webView.load(imageData, mimeType: "image/gif", textEncodingName: "", baseURL: URL(string: Bundle.main.bundlePath)!)
    }
    
    // 添加渐变图层
    func addGradientLayer() {
        // 创建渐变图层
        let layer = CAGradientLayer()
        // 设置图层尺寸位置
        layer.bounds = CGRect(x: 0, y: 320, width: 100, height: 100)
        layer.position = CGPoint(x: 100, y: 370)
        // 设置色彩渐变的颜色
        layer.colors = [UIColor.red.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor]
        // 设置渐变的临界位置
        layer.locations = [NSNumber(value: 0.2), NSNumber(value: 0.5), NSNumber(value: 0.7)]
        // 设置渐变的起始点与结束点
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        
        self.view.layer.addSublayer(layer)
        
        let layer2 = CAGradientLayer()
        // 设置图层尺寸位置
        layer2.bounds = CGRect(x: 130, y: 320, width: 100, height: 100)
        layer2.position = CGPoint(x: 230, y: 370)
        // 设置色彩渐变的颜色
        layer2.colors = [UIColor.red.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor]
        // 设置渐变的临界位置
        layer2.locations = [NSNumber(value: 0.2), NSNumber(value: 0.5), NSNumber(value: 0.7)]
        // 设置渐变的起始点与结束点
        layer2.startPoint = CGPoint(x: 0, y: 0)
        layer2.endPoint = CGPoint(x: 1, y: 1)
        
        self.view.layer.addSublayer(layer2)
    }
    
    // 添加拷贝图层
    func addReplicatorLayer() {
        // 创建拷贝图层
        let layer = CAReplicatorLayer()
        layer.position = CGPoint.zero
        // 创建内容图层
        let subLayer = CALayer()
        subLayer.bounds = CGRect(x: 0, y: 450, width: 30, height: 30)
        subLayer.position = CGPoint(x: 30, y: 460)
        subLayer.backgroundColor = UIColor.black.cgColor
        layer.addSublayer(subLayer)
        
        // 设置每次拷贝将副本沿 x 轴平移20个单位
        layer.instanceTransform = CATransform3DMakeTranslation(40, 1, 0)
        // 设置拷贝副本数量
        layer.instanceCount = 8
        self.view.layer.addSublayer(layer)
    }
    
    // 添加图形 Layer 层
    func addShapeLayer() {
        let layer = CAShapeLayer()
        layer.position = CGPoint.zero
        
        // 创建图形路径
        let path = CGMutablePath()
        // 设置路径起点
        path.move(to: CGPoint(x: 150, y: 490))
        // 画线
        path.addLine(to: CGPoint(x: 50, y: 550))
        path.addLine(to: CGPoint(x: 150, y: 550))
        path.addLine(to: CGPoint(x: 150, y: 490))
        
        // 设置图层路径
        layer.path = path
        // 设置图形边缘线条起点和终点
        layer.strokeStart = 0
        layer.strokeEnd = 1
        // 设置填充规则
        layer.fillRule = CAShapeLayerFillRule.evenOdd
        // 设置填充颜色
        layer.fillColor = UIColor.cyan.cgColor
        // 设置边框颜色
        layer.strokeColor = UIColor.brown.cgColor
        // 设置边框宽度
        layer.lineWidth = 3
        
        self.view.layer.addSublayer(layer)
        
        
        let layer2 = CAShapeLayer()
        layer2.position = CGPoint.zero
        
        let path2 = CGMutablePath()
        path2.move(to: CGPoint(x: 180, y: 490))
        path2.addLine(to: CGPoint(x: 180, y: 550))
        path2.addLine(to: CGPoint(x: 280, y: 550))
        path2.addLine(to: CGPoint(x: 180, y: 490))
        
        layer2.path = path2
        layer2.strokeStart = 0
        layer2.strokeEnd = 1
        layer2.fillRule = CAShapeLayerFillRule.nonZero
        layer2.fillColor = UIColor.brown.cgColor
        layer2.strokeColor = UIColor.cyan.cgColor
        layer2.lineWidth = 3
        
        self.view.layer.addSublayer(layer2)
    }
    
    func playAnimation1() {
        // 创建动画实例，声明要进行属性动画的属性路径
        let basicAni = CABasicAnimation(keyPath: "transform.rotation.z")
        // 从 0 度开始旋转
        basicAni.fromValue = 0
        // 旋转到180度
        basicAni.toValue = NSNumber(value: Double.pi)
        // 设置时长
        basicAni.duration = 2
        // 将动画作用于指定视图layer层上
        self.view.layer.add(basicAni, forKey: nil)
    }
    
    func playAnimation2() {
        let keyFrameAni = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        keyFrameAni.values = [NSNumber(value: 0), NSNumber(value: Double.pi / 4), NSNumber(value: 0), NSNumber(value: Double.pi)]
        keyFrameAni.duration = 3
        self.view.layer.add(keyFrameAni, forKey: "")
    }
    
    func playAnimation3() {
        let springAni = CASpringAnimation(keyPath: "position.x")
        // 模拟质量，必须大于 0，默认为1，影响惯性
        springAni.mass = 5
        // 模拟弹簧劲度系数，值越大，回弹越快
        springAni.stiffness = 5
        // 设置阻尼系数，值越大，回弹幅度越小
        springAni.damping = 2
        springAni.toValue = 280
        springAni.duration = 2
        
        springAni.fillMode = .forwards
        springAni.isRemovedOnCompletion = false
        
        let layer = CALayer()
        layer.position = CGPoint(x: 80, y: 600)
        layer.bounds = CGRect(x: 10, y: 580, width: 50, height: 50)
        layer.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(layer)
        
        layer.add(springAni, forKey: "")
        
//        layer.position.x = 280
    }
    
    func playAnimation4() {
        // 创建转场动画
        let transAni = CATransition()
        // 设置转场动画类型
        transAni.type = CATransitionType.push
        // 设置转场动画方向
        transAni.subtype = CATransitionSubtype.fromRight
        
        transAni.fillMode = .forwards
        transAni.isRemovedOnCompletion = false
        
        let layer = CALayer()
        layer.position = CGPoint(x: 200, y: 625)
        layer.bounds = CGRect(x: 10, y: 650, width: 50, height: 50)
        layer.backgroundColor = UIColor.gray.cgColor
        layer.add(transAni, forKey: "")
        
        // 转场动画是在 layer 层出现时产生效果
        self.view.layer.addSublayer(layer)
    }
    
    func playGroupAnimation() {
        // 背景色过渡动画
        let basic1 = CABasicAnimation(keyPath: "backgroundColor")
        basic1.toValue = UIColor.yellow.cgColor
        // 缩放动画
        let basic2 = CABasicAnimation(keyPath: "transform.scale.x")
        basic2.toValue = NSNumber(value: 2)
        
        // 创建组合动画
        let groupAni = CAAnimationGroup()
        groupAni.animations = [basic1, basic2]
        groupAni.duration = 3
        groupAni.fillMode = .both
        groupAni.isRemovedOnCompletion = false
        
        let layer = CALayer()
        layer.position = CGPoint(x: 200, y: 625)
        layer.bounds = CGRect(x: 10, y: 720, width: 50, height: 50)
        layer.backgroundColor = UIColor.brown.cgColor
        layer.add(groupAni, forKey: "")
        
        self.view.layer.addSublayer(layer)
    }
    
    // 粒子效果
    func addEmitterLayer() {
        // 创建粒子单元
        let cell = CAEmitterCell()
        // 设置每秒产生粒子数
        cell.birthRate = 100
        // 设置粒子存活时间
        cell.lifetime = 4
        // 设置粒子存活时间随机范围
        cell.lifetimeRange = 2
        // 设置粒子渲染颜色
        cell.color = UIColor(red: 0.5, green: 0.9, blue: 0.9, alpha: 0.5).cgColor
        // 设置粒子内容
        cell.contents = UIImage(named: "snowflake")?.cgImage
        // 设置粒子运动速度
        cell.velocity = 100
        // 设置粒子运动速度随机范围
        cell.velocityRange = 50
        // 设置粒子在 x-y 平面的发射角度
        cell.emissionLongitude = CGFloat(Double.pi + Double.pi / 2)
        // 设置粒子发射角度的随机范围
        cell.emissionRange = CGFloat(Double.pi)
        // 设置粒子的缩放速率
        cell.scaleSpeed = 0.5
        // 设置粒子的旋转
        cell.spin = 0.3
        
        // 配置粒子发射引擎
        let emitter = CAEmitterLayer()
        // 设置发射引擎的位置和尺寸
        emitter.emitterPosition = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.size.height - 20)
        emitter.emitterSize = CGSize(width: self.view.bounds.size.width - 100, height: 20)
        // 粒子的渲染模式
        emitter.renderMode = .oldestFirst
        // 设置粒子发射引擎的粒子单元
        emitter.emitterCells = [cell]
        
        self.view.layer.addSublayer(emitter)
    }
    
    // 粒子效果2
    func addEmitterLayer2() {
        // 创建粒子单元
        let cell = CAEmitterCell()
        // 设置每秒产生粒子数
        cell.birthRate = 50
        // 设置粒子存活时间
        cell.lifetime = 4
        // 设置粒子存活时间随机范围
        cell.lifetimeRange = 2
        // 设置粒子渲染颜色
//        cell.color = UIColor(red: 0.5, green: 0.9, blue: 0.9, alpha: 0.5).cgColor
        // 设置粒子内容
        cell.contents = UIImage(named: "raindrop")?.cgImage
        // 设置粒子运动速度
        cell.velocity = 100
        // 设置粒子运动速度随机范围
        cell.velocityRange = 50
        // 设置粒子在 x-y 平面的发射角度
        cell.emissionLongitude = CGFloat(Double.pi)
        // 设置粒子发射角度的随机范围
        cell.emissionRange = CGFloat(Double.pi)
        
        // 配置粒子发射引擎
        let emitter = CAEmitterLayer()
        // 设置发射引擎的位置和尺寸
        emitter.emitterPosition = CGPoint(x: self.view.bounds.size.width / 2, y: 40)
        emitter.emitterSize = CGSize(width: self.view.bounds.size.width, height: 40)
        // 粒子的渲染模式
        emitter.renderMode = .unordered
        // 设置粒子发射引擎的粒子单元
        emitter.emitterCells = [cell]
        
        self.view.layer.addSublayer(emitter)
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
