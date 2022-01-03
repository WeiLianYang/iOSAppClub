//
//  WKWebViewController.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2022/1/2.
//

import WebKit
import UIKit

class WKWebViewController: UIViewController, WKScriptMessageHandler, WKUIDelegate {
    
    var wkWebView: WKWebView?
    
    var progressView: UIProgressView?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "WKWebView Demo"
        
        let configuration = WKWebViewConfiguration()
        // 设置进程池，一般不需要设置，在使用多个 WKWebView 实例时会使用到
        configuration.processPool = WKProcessPool()
        // 设置偏好
        let prefrence = WKPreferences()
        // 设置网页中最小字体
        prefrence.minimumFontSize = 0
        // 支持 js，在 iOS 14 中已弃用
//        prefrence.javaScriptEnabled = true
        // 设置允许不经过交互，由 js 自动打开窗口
        prefrence.javaScriptCanOpenWindowsAutomatically = true
        
        let pagePrefrence = WKWebpagePreferences()
        // 支持 js
        pagePrefrence.allowsContentJavaScript = true
        
        configuration.preferences = prefrence
        configuration.defaultWebpagePreferences = pagePrefrence
        
        // 设置 js 交互
        let contentController = WKUserContentController()
        // 设置代理并注册要被 js 调用的原生方法的事件名称
        contentController.add(self, name: "callNativeMethod")
        // 向网页注入 js 代码
        let jsStr = "function jsFunc() { window.webkit.messageHandlers.nativeMethod.postMessage({\"key\":\"value\"}) }; jsFunc()"
        let script = WKUserScript(source: jsStr, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: false)
        // 进行注入
        contentController.addUserScript(script)
        configuration.userContentController = contentController
        
        wkWebView = WKWebView(frame: self.view.frame, configuration: configuration)
        
        self.view.addSubview(wkWebView!)
        
        let url = URL(string: "https://github.com/WeiLianYang/iOSAppDemo")
        let request = URLRequest(url: url!)
        wkWebView?.load(request)
        
        // 调用 js
        wkWebView?.evaluateJavaScript("jsFunc", completionHandler: { any, error in
            print("error: \(error.debugDescription)")
        })
        
        // 创建进度条控件
        progressView = UIProgressView(frame: CGRect(x: 0, y: 140, width: self.view.frame.size.width, height: 10))
        progressView?.tintColor = UIColor.green
        progressView?.progress = 0
        self.view.addSubview(progressView!)
        
        // 添加进度条监听
        wkWebView?.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        
    }
    
    // 监听加载进度
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            let progress = wkWebView!.estimatedProgress
            print("progress: \(progress)")
            progressView?.progress = Float(progress)
            if (progress == 1.0) {
                progressView?.isHidden = true
            }
        }
    }
    
    // js 调用 原生方法回调处
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("body: ", message.body, ", name: ", message.name)
    }
    
    // 当网页视图被创建时回调
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        return wkWebView
    }
    
    // 当网页视图被关闭时回调
    func webViewDidClose(_ webView: WKWebView) {
        
    }
    
    // js 弹出 alert 警告框时回调
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo) async {
        
    }
    
    // js 弹出 confirm 确认框时回调
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo) async -> Bool {
        return true
    }
    
    // js 弹出输入框时回调
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo) async -> String? {
        return nil
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
