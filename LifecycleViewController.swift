//
//  LifecycleViewController.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2021/12/27.
//

import UIKit

class LifecycleViewController: UIViewController {
    
    var data: String? = nil
    
    // 加载视图时调用
    override func loadView() {
        super.loadView()
        
        addUIButton()
        
        addUILabel()
        
        resetUILabelText("lifecycle method: loadView()")
    }

    // 视图加载完成时调用
    override func viewDidLoad() {
        super.viewDidLoad()
        resetUILabelText("lifecycle method: viewDidLoad()")
       
        self.view.backgroundColor = UIColor.white
        
    }
    
    func addUIButton() {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 10, y: 100, width: 100, height: 40)
        button.backgroundColor = UIColor.cyan
        button.setTitle("返回按钮", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func goBack() {
        self.dismiss(animated: true) {
            print("go back complete")
        }
    }
   
    lazy var label = UILabel(frame: CGRect(x: 10, y: 80, width: 375, height: 600))
    
    func addUILabel() {
        label.text = data
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.blue
        label.numberOfLines = 0 // 不限制行数
        
        self.view.addSubview(label)
    }
    
    func resetUILabelText(_ text: String) {
        data?.append("\r")
        data?.append(text)
        label.text = data
        
        print(text)
    }
    
    // 视图将要展示时调用
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetUILabelText("lifecycle method: viewWillAppear()")
    }
    
    // 将要布局子视图时调用
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        resetUILabelText("lifecycle method: viewWillLayoutSubviews()")
    }
    
    // 已经布局子视图时调用
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resetUILabelText("lifecycle method: viewDidLayoutSubviews()")
    }
    
    // 视图已经展示时调用
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resetUILabelText("lifecycle method: viewDidAppear()")
    }
    
    // 视图将要消失时调用
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resetUILabelText("lifecycle method: viewWillDisappear()")
    }
    
    // 视图已经消失时调用
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        resetUILabelText("lifecycle method: viewDidDisappear()")
    }
    
    // 销毁时调用
    deinit {
        resetUILabelText("lifecycle method: deinit()")
    }
    
    // 收到内存警告时调用，主要在低版本上应用
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        resetUILabelText("lifecycle method: didReceiveMemoryWarning()")
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
