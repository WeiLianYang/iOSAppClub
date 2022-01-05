//
//  TableViewController.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2021/12/29.
//

import UIKit

class TableViewController: UITableViewController {
    
    // 初始化数据源
    var groupData: Array<String> = ["group-1", "group-2"]
    var dataArray: Array<String> = ["row-1", "row-2", "row-3", "row-4", "row-5"]
    
    var heightForHeader = 35
    var heightForFooter = 25

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.navigationController?.navigationBar.barTintColor = UIColor.cyan
        let barItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(click))
        self.navigationItem.leftBarButtonItem = barItem
        
        self.title = "Navigation"
        self.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.bookmarks, tag: 1)
        
        
        // 创建 UITableView，设置扁平化风格
        tableView = UITableView(frame: self.view.frame, style: UITableView.Style.grouped)
        // 注册 cell
        tableView.register(NSClassFromString("UITableViewCell"), forCellReuseIdentifier: "TableViewCellId")
        
        // 设置数据源与代理
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    @objc func click(bar: UIBarButtonItem) {
        print("UIBarButtonItem click")
        
        let viewController = WebViewController()
        // 入栈
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    // MARK: - Table view data source

    // 返回分组数
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return groupData.count
    }

    // 返回每组的数据量
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellId", for: indexPath)
        // 设置每个 cell 的数据
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    
    // 设置分组 头部 标题
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "title for header in section"
    }
    
    // 设置分组 尾部 标题
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "title for footer in section"
    }
    
    // 设置分组 头部 视图
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width), height: heightForHeader))
        view.backgroundColor = UIColor.purple
        return view
    }
    
    // 设置分组 尾部 视图
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width), height: heightForFooter))
        view.backgroundColor = UIColor.brown
        return view
    }
    
    // 设置分组 头部 视图高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(heightForHeader)
    }
    
    // 设置分组 尾部 视图高度
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(heightForFooter)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
