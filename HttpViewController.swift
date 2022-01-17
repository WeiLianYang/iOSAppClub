//
//  HttpViewController.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2022/1/16.
//

import UIKit

class HttpViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = UIScrollView(frame: self.view.frame)
    
    lazy var textView = UITextView(frame: CGRect(x: 0, y: 35, width: self.view.frame.size.width, height: self.view.frame.size.height * 2))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addUIScrollView()

        addUITextView()
        
        addUIButton()
        
    }
    
    func addUIScrollView() {
        scrollView.backgroundColor = UIColor.white
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height * 2)
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true
        self.view.addSubview(scrollView)
    }
    
    func addUITextView() {
        
        textView.text = "这里会显示网络请求返回的数据"
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.textColor = UIColor.blue
        textView.textAlignment = NSTextAlignment.natural
        textView.isUserInteractionEnabled = false
        
        scrollView.addSubview(textView)
    }
    
    func addUIButton() {
        let button1 = UIButton(type: UIButton.ButtonType.system)
        button1.frame = CGRect(x: 100, y: 0, width: 80, height: 35)
        button1.backgroundColor = UIColor.cyan
        button1.setTitle("GET", for: .normal)
        button1.setTitleColor(UIColor.black, for: .normal)
        button1.addTarget(self, action: #selector(getHotData), for: .touchUpInside)
        scrollView.addSubview(button1)
        
        let button2 = UIButton(type: UIButton.ButtonType.system)
        button2.frame = CGRect(x: 200, y: 0, width: 80, height: 35)
        button2.backgroundColor = UIColor.cyan
        button2.setTitle("POST", for: .normal)
        button2.setTitleColor(UIColor.black, for: .normal)
        button2.addTarget(self, action: #selector(getDuiLian), for: .touchUpInside)
        scrollView.addSubview(button2)
    }
    
    var dictionary: Any? = nil
    
    // 获取全网热点数据 get 请求
    @objc func getHotData() {
        let urlString = "http://api.tianapi.com/networkhot/index?key=%@"
        let apiKey = "d2d3cbf56e29d3556f060c762f94d05b"
        
        // 创建请求配置
        let config = URLSessionConfiguration.default
        // 创建请求 URL
        let url = URL(string: String(format: urlString, apiKey))
        // 创建请求实例
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        // 创建请求 Session
        let session = URLSession(configuration: config)
        // 创建请求任务
        let task = session.dataTask(with: request) { data, response, error in
            let result = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
            self.dictionary = result.debugDescription.unicodeToString
            self.performSelector(onMainThread: #selector(self.setText), with: nil, waitUntilDone: true)
        }
        // 激活请求任务
        task.resume()
    }
    
    @objc func setText() {
        self.textView.text = dictionary.debugDescription
    }
    
    // 获取全网热点数据 post 请求
    @objc func getDuiLian() {
        let urlString = "http://api.tianapi.com/duilian/index"
        let apiKey = "d2d3cbf56e29d3556f060c762f94d05b"
        
        // 创建请求配置
        let config = URLSessionConfiguration.default
        // 创建请求 URL
        let url = URL(string: String(format: urlString, apiKey))
        // 创建请求实例
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        let key = ["key": apiKey]
        let data = try? encoder.encode(key)
        
        print("data: \(data.debugDescription)")
        
        let reqBody = "key=\(apiKey)".data(using: String.Encoding.utf8)
        
        request.httpBody = reqBody
        // 创建请求 Session
        let session = URLSession(configuration: config)
        // 创建请求任务
        let task = session.dataTask(with: request) { data, response, error in
            let result = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
            self.dictionary = result.debugDescription.unicodeToString
            print(self.dictionary ?? "no data parsed")
            self.performSelector(onMainThread: #selector(self.setText), with: nil, waitUntilDone: true)
        }
        // 激活请求任务
        task.resume()
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
