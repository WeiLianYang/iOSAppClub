//
//  TableViewController.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2021/12/29.
//

import UIKit

class TableViewController: UITableViewController {
    
    // 初始化数据源
//    var groupData: Array<String> = ["group-1"]//, "group-2"]
//    var dataArray: Array<String> = ["row-1", "row-2", "row-3", "row-4", "row-5"]
//    lazy var dataArray: Array<TableCellData> = [TableCellData(), TableCellData(), TableCellData(), TableCellData()]
    lazy var dataArray: Array<TableCellData> = []
    let groupData = ["#", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var heightForHeader = 35
    var heightForFooter = 25
    var heightForCell = 100

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
        
        for index in 0...3 {
            dataArray.append(TableCellData(title: "title-\(index)", imageName: "demo"))
        }
        
        
        // 创建 UITableView，设置扁平化风格
        tableView = UITableView(frame: self.view.frame, style: UITableView.Style.grouped)
        // 注册 cell
        tableView.register(NSClassFromString("UITableViewCell"), forCellReuseIdentifier: "cell")
//        tableView.register(UINib.init(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        // 设置数据源与代理
        tableView.delegate = self
        tableView.dataSource = self
        
        // 开启编辑模式
//        tableView.isEditing = true
        
    }
    
    @objc func click(bar: UIBarButtonItem) {
        print("UIBarButtonItem click")
        
        let viewController = WebViewController()
        viewController.hidesBottomBarWhenPushed = true
        // 入栈
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    // MARK: - Table view data source

    // 返回分组数
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return groupData.count
    }
    
    // 设置索引栏标题
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return groupData
    }

    // 返回每组的数据量
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // 设置每个 cell 的数据
        let data = dataArray[indexPath.row]
    
        cell.textLabel?.text = data.title
        cell.detailTextLabel?.text = data.subTitle
        cell.imageView?.image = UIImage(named: data.imageName)

        return cell
    }
    
    // 设置分组 头部 标题
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupData[section]
    }
    
    // 将索引栏上的文字与分区进行绑定
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    // 设置分组 尾部 标题
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "title for footer in section"
    }
    
    // 设置分组 头部 视图
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width), height: heightForHeader))
//        view.backgroundColor = UIColor.purple
//        return view
        return nil
    }
    
    // 设置分组 尾部 视图
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width), height: heightForFooter))
//        view.backgroundColor = UIColor.brown
//        return view
        return nil
    }
    
    // 设置分组 头部 视图高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(heightForHeader)
    }
    
    // 设置分组 尾部 视图高度
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(heightForFooter)
    }
    
    // 当 Cell 将要展示出来时被调用
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    // 当头部视图将要展示出来时被调用
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
    }
    
    // 当尾部视图将要展示出来时被调用
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
    }
    
    // 当 Cell 已经被展示出来时调用
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    // 当头部视图已经被展示出来时调用
    override func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        
    }
    
    // 当尾部视图已经被展示出来时调用
    override func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        
    }
    
    // 设置 Cell 高度
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(heightForCell)
    }
    
    // 用户将要选中某一行时调用
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    // 用户将要取消选中某一行时调用
    override func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    // 用户已经选中某一行时调用
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // 用户已经取消选中某一行时调用
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    // 返回每行 cell 的编辑模式
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == 0 {
            return .insert
        } else {
            return .delete
        }
        
    }
    
    // 设置显示的交互按钮的文字
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        if indexPath.row == 0 {
            return "insert"
        } else {
            return "delete"
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            print("click delete button")
            // 删除数据源中的数据
            dataArray.remove(at: indexPath.row)
            // 删除 cell
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
        } else {
            print("click insert button")
            
            let item = TableCellData()
            // 插入数据源
            dataArray.insert(item, at: indexPath.row)
            // 插入 cell
            tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    // 对数据排序
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("sourceIndexPath.row: ", sourceIndexPath.row, "destinationIndexPath.row: ", destinationIndexPath.row)
        
        let temp1 = dataArray[sourceIndexPath.row]
        let temp2 = dataArray[destinationIndexPath.row]
        
        dataArray[sourceIndexPath.row] = temp2
        dataArray[destinationIndexPath.row] = temp1
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
