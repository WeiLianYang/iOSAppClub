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
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
