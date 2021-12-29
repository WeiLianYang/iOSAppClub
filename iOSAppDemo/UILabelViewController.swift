//
//  UILabelViewController.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2021/12/27.
//

import UIKit

// 定义协议，回调给上一个控制器
protocol CallbackProtocol {
    func callback(data: String)
}

class UILabelViewController: UIViewController {
    
    var delegate: CallbackProtocol?
    
    // 定义闭包，回调给上一个控制器
    var callback: ((String) -> Void)?
    
    var data: String? = nil
    
    init(data: String?) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        addUIButton()
        
        addUILabel()
    }
    
    func addUIButton() {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 10, y: 80, width: 100, height: 40)
        button.backgroundColor = UIColor.cyan
        button.setTitle("返回按钮", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func goBack() {
        // 1. 利用协议回调
        delegate?.callback(data: "利用协议回传值")
        
        // 2. 利用闭包回调
        self.callback?("利用闭包回传值")
        
        self.dismiss(animated: true) {
            print("go back complete")
        }
    }
    
    func addUILabel() {
        let label = UILabel(frame: CGRect(x: 10, y: 80, width: 375, height: 100))
        label.text = data
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.blue
        
        self.view.addSubview(label)
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
