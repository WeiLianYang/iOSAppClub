//
//  AnimationViewController.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2022/1/9.
//

import UIKit
import ImageIO

class AnimationViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = UIScrollView(frame: self.view.frame)
    
    var animationView1: UIView?
    
    var animationView2: UIView?
    
    let gifWH = 150

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addUIScrollView()

        animationView1 = UIView(frame: CGRect(x: 20, y: 30, width: 100, height: 100))
        animationView1?.backgroundColor = UIColor.red
        self.view.addSubview(animationView1!)
        
        animationView2 = UIView(frame: CGRect(x: 230, y: 50, width: 100, height: 100))
        animationView2?.backgroundColor = UIColor.cyan
        self.view.addSubview(animationView2!)
        
        let imageView = UIImageView(frame: CGRect(x: 30, y: 150, width: gifWH, height: gifWH))
        scrollView.addSubview(imageView)
        
        // 通过 UIImageView 播放 Gif 动画加载速度会更快，但是使用复杂
        loadGifWithImageView(imageView: imageView, name: "shark")
        
        let webView = UIWebView(frame: CGRect(x: 60 + gifWH, y: 150, width: gifWH, height: gifWH))
        scrollView.addSubview(webView)
        
        // 通过 UIWebView 播放 Gif 动画加载速度慢，但是动画更流畅
        loadGifWithWebView(webView: webView, name: "shark")
    }
    
    func addUIScrollView() {
        // 设置 UIScrollView 的代理为当前视图控制器本身
//        scrollView.delegate = self

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
    
    // 用户点击界面时回调
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 时长1秒，改变背景色，完成后执行修改坐标位置
        UIView.animate(withDuration: 1, animations: {
            self.animationView1?.backgroundColor = UIColor.blue
        }) { (finish) in
            // 上一个动画执行完成后继续执行位移动画
            UIView.animate(withDuration: 2, animations: {
                self.animationView1?.center = CGPoint(x: 120, y: 100)
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
        let otherView = UIView(frame: CGRect(x: 220, y: 50, width: 100, height: 100))
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
