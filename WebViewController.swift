//
//  WebViewController.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2022/1/1.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    var webView: UIWebView?
    var btnGoBack: UIButton!
    var btnGoForward: UIButton!
    let toolWidth = 100
    let toolHeight = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建 WebView
        webView = UIWebView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width), height: Int(self.view.frame.size.height) - toolHeight))
        
        // 创建 url
        let url = URL(string: "http://www.baidu.com")
        // 创建 url 请求
        let request = URLRequest(url: url!)
        
        // 加载网页
        webView?.loadRequest(request)
        // 设置协议实现
        webView?.delegate = self
        self.view.addSubview(webView!)
        
        // 创建自定义导航条
        let toolView = UIView(frame: CGRect(x: 0, y: Int(self.view.frame.size.height) - toolHeight, width: Int(self.view.frame.size.width), height: toolHeight))
        self.view.addSubview(toolView)
        
        // 创建后退按钮
        btnGoBack = UIButton(frame: CGRect(x: 20, y: 0, width: toolWidth, height: toolHeight))
        btnGoBack.backgroundColor = UIColor.cyan
        btnGoBack.setTitle("Back", for: .normal)
        btnGoBack.setTitleColor(UIColor.black, for: .normal)
        btnGoBack.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        toolView.addSubview(btnGoBack)
        
        // 创建前进按钮
        btnGoForward = UIButton(frame: CGRect(x: Int(self.view.frame.size.width) - 120, y: 0, width: toolWidth, height: toolHeight))
        btnGoForward.backgroundColor = UIColor.cyan
        btnGoForward.setTitle("Forward", for: .normal)
        btnGoForward.setTitleColor(UIColor.black, for: .normal)
        btnGoForward.addTarget(self, action: #selector(goForward), for: .touchUpInside)
        toolView.addSubview(btnGoForward)
        
    }
    
    @objc func goBack() {
        webView?.goBack()
    }
    
    @objc func goForward() {
        webView?.goForward()
    }
    
    // 视图将要开始加载时回调，返回 false 则禁止此次加载
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        print("load url: ", request.url)
        return true
    }
    
    // 视图已经开始加载时回调
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("webViewDidStartLoad")
    }
    
    // 视图加载完成时回调
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("webViewDidFinishLoad")
    }
    
    // 视图加载失败时回调
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("load error: ", error.localizedDescription)
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
