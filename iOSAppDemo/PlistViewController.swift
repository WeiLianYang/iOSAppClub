//
//  PlistViewController.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2022/1/16.
//

import UIKit

class PlistViewController: UIViewController {

    lazy var scrollView: UIScrollView = UIScrollView(frame: self.view.frame)
    
    lazy var textView = UITextView(frame: CGRect(x: 0, y: 40, width: self.view.frame.size.width, height: self.view.frame.size.height))
    
    var content: String = " 显示 UserDefaults 读取的数据："
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addUIScrollView()
        
        addUITextView()
        
        addUIButton()
        
        readDataFromCustomPlist()
        
    }
    
    func addUIScrollView() {
        scrollView.backgroundColor = UIColor.white
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true
        self.view.addSubview(scrollView)
    }
    
    func addUITextView() {
        
        textView.text = content
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textColor = UIColor.blue
        textView.textAlignment = NSTextAlignment.natural
        textView.isUserInteractionEnabled = false
        
        scrollView.addSubview(textView)
    }
    
    func addUIButton() {
        let button1 = UIButton(type: UIButton.ButtonType.system)
        button1.frame = CGRect(x: 50, y: 0, width: 80, height: 35)
        button1.backgroundColor = UIColor.cyan
        button1.setTitle("Save", for: .normal)
        button1.setTitleColor(UIColor.black, for: .normal)
        button1.addTarget(self, action: #selector(saveDataToUserDefaults), for: .touchUpInside)
        scrollView.addSubview(button1)
        
        let button2 = UIButton(type: UIButton.ButtonType.system)
        button2.frame = CGRect(x: 150, y: 0, width: 80, height: 35)
        button2.backgroundColor = UIColor.cyan
        button2.setTitle("Read", for: .normal)
        button2.setTitleColor(UIColor.black, for: .normal)
        button2.addTarget(self, action: #selector(readDataFromUserDefaults), for: .touchUpInside)
        scrollView.addSubview(button2)
        
        let button3 = UIButton(type: UIButton.ButtonType.system)
        button3.frame = CGRect(x: 250, y: 0, width: 80, height: 35)
        button3.backgroundColor = UIColor.cyan
        button3.setTitle("Remove", for: .normal)
        button3.setTitleColor(UIColor.black, for: .normal)
        button3.addTarget(self, action: #selector(removeDataByUserDefaults), for: .touchUpInside)
        scrollView.addSubview(button3)
    }
    
    @objc func saveDataToUserDefaults() {
        // 获取应用程序默认的 UserDefaults
        let userDefault = UserDefaults.standard
        // 存储 URL
        userDefault.set(URL(string: "https://www.baidu.com"), forKey: "urlKey")
        // 存储 String
        userDefault.set("string value", forKey: "stringKey")
        // 存储 Bool
        userDefault.set(true, forKey: "boolKey")
        // 存储 Double
        userDefault.set(Double(1.0), forKey: "doubleKey")
        // 存储 Float
        userDefault.set(Float(2.2), forKey: "floatKey")
        // 存储 Int
        userDefault.set(100, forKey: "intKey")
        // 存储 Dictionary
        userDefault.set(["key": "value"], forKey: "dictKey")
        // 存储 Array
        userDefault.set([1, 2, 3], forKey: "arrayKey")
        // 存储 Data
        userDefault.set(Data(), forKey: "dataKey")
        // 同步数据到磁盘
        userDefault.synchronize()
    }
    
    
    @objc func readDataFromUserDefaults() {
        // 获取应用程序默认的 UserDefaults
        let userDefault = UserDefaults.standard
        
        content = " 显示 UserDefaults 读取的数据："
        
        // 读取 URL
        content.append("\n\n url value: \(String(describing: userDefault.url(forKey: "urlKey")))")
        // 读取 String
        content.append("\n\n string value: \(String(describing: userDefault.string(forKey: "stringKey")))")
        // 读取 Bool
        content.append("\n\n bool value: \(userDefault.bool(forKey: "boolKey"))")
        // 读取 Double
        content.append("\n\n doublevalue: \(userDefault.double(forKey: "doubleKey"))")
        // 读取 Float
        content.append("\n\n float value: \(userDefault.float(forKey: "floatKey"))")
        // 读取 Int
        content.append("\n\n int value: \(userDefault.integer(forKey: "intKey"))")
        // 读取 Dictionary
        content.append("\n\n dictionary value: \(String(describing: userDefault.dictionary(forKey: "dictKey")))")
        // 读取 Array
        content.append("\n\n array value: \(String(describing: userDefault.array(forKey: "arrayKey")))")
        // 读取 Data
        content.append("\n\n data value: \(String(describing: userDefault.data(forKey: "dataKey")))")
        
        readAndWriteDataWithCustomPlist()
    }
    
    @objc func removeDataByUserDefaults() {
        // 获取应用程序默认的 UserDefaults
        let userDefault = UserDefaults.standard
        // 移除 URL
        userDefault.removeObject(forKey: "urlKey")
        // 移除 String
        userDefault.removeObject(forKey: "stringKey")
        // 移除 Bool
        userDefault.removeObject(forKey: "boolKey")
        // 移除 Double
        userDefault.removeObject(forKey: "doubleKey")
        // 移除 Float
        userDefault.removeObject(forKey: "floatKey")
        // 移除 Int
        userDefault.removeObject(forKey: "intKey")
        // 移除 Dictionary
        userDefault.removeObject(forKey: "dictKey")
        // 移除 Array
        userDefault.removeObject(forKey: "arrayKey")
        // 移除 Data
        userDefault.removeObject(forKey: "dataKey")
    }
    
    func readDataFromCustomPlist() {
        // 获取文件路径
        let path = Bundle.main.path(forResource: "CustomPlist", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        print(dict ?? "dict is nil")
        
        content.append("\n\n custom plist: \(String(describing: dict))")
        textView.text = content
    }
    
    func readAndWriteDataWithCustomPlist() {
        // 获取沙盒用户数据目录
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let fileName = path! + "CustomPlist.plist"
        let dic: NSDictionary = ["name": "William", "age": 20, "job": "ios developer"]
        // 写入数据
        dic.write(toFile: fileName, atomically: true)
        
        // 读取 plist
        let dict = NSDictionary(contentsOfFile: fileName)
        print(dict ?? "dict is nil")
        
        content.append("\n\n custom plist: \(String(describing: dict))")
        textView.text = content
    }
    
    func archiveData() {
        
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
