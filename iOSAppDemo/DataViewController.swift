//
//  PlistViewController.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2022/1/16.
//

import UIKit
import CoreData

class DataViewController: UIViewController {

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
        button1.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        scrollView.addSubview(button1)
        
        let button2 = UIButton(type: UIButton.ButtonType.system)
        button2.frame = CGRect(x: 150, y: 0, width: 80, height: 35)
        button2.backgroundColor = UIColor.cyan
        button2.setTitle("Read", for: .normal)
        button2.setTitleColor(UIColor.black, for: .normal)
        button2.addTarget(self, action: #selector(readData), for: .touchUpInside)
        scrollView.addSubview(button2)
        
        let button3 = UIButton(type: UIButton.ButtonType.system)
        button3.frame = CGRect(x: 250, y: 0, width: 80, height: 35)
        button3.backgroundColor = UIColor.cyan
        button3.setTitle("Remove", for: .normal)
        button3.setTitleColor(UIColor.black, for: .normal)
        button3.addTarget(self, action: #selector(removeDataByUserDefaults), for: .touchUpInside)
        scrollView.addSubview(button3)
    }
    
    @objc func saveData() {
        saveDataToUserDefaults()
        
        archiveStringData()
        
        archiveMutableData()
        
        archiveObjectData()
        
        insertToCoreData()
    }
    
    @objc func readData() {
        readDataFromUserDefaults()
        
        unarchiveStringData()
        
        unarchiveMutableData()
        
        unarchiveObjectData()
        
        readFromCoreData()
    }
    
    func saveDataToUserDefaults() {
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
    
    
    func readDataFromUserDefaults() {
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
        
        content.append("\n\n custom plist: \(String(describing: dict))")
        textView.text = content
    }
    
    // *****************
    // 对单一数据进行 归档
    // *****************
    func archiveStringData() {
        // 获取根目录
        let rootPath = NSHomeDirectory()
        // 创建文件完整路径
        let filePath = rootPath + "/archiver1.file"
        // 将字符串进行归档，一并写入磁盘
        NSKeyedArchiver.archiveRootObject("hello william", toFile: filePath)
    }
    
    // *****************
    // 对单一数据进行 解归档
    // *****************
    func unarchiveStringData() {
        // 获取根目录
        let rootPath = NSHomeDirectory()
        // 创建文件完整路径
        let filePath = rootPath + "/archiver1.file"
        // 解归档
        let dataStr = NSKeyedUnarchiver.unarchiveObject(withFile: filePath)
        print("unarchive string: \(dataStr)")
    }
    
    // *****************
    // 对多个数据进行 归档
    // *****************
    func archiveMutableData() {
        // 获取根目录
        let rootPath = NSHomeDirectory()
        // 创建文件完整路径
        let filePath = rootPath + "/archiver2.file"
        // 创建归档载体数据
        let data = NSMutableData()
        // 创建归档对象
        let archiver = NSKeyedArchiver(forWritingWith: data)
        // 存入数据并编码
        archiver.encode("William", forKey: "name")
        archiver.encode(18, forKey: "age")
        archiver.encode("ios developer", forKey: "job")
        // 完成编码
        archiver.finishEncoding()
        // 写入文件
        data.write(toFile: filePath, atomically: true)
        
        print("archive mutable data")
    }
    
    // *****************
    // 对多个数据进行 解归档
    // *****************
    func unarchiveMutableData() {
        let rootPath = NSHomeDirectory()
        let filePath = rootPath + "/archiver2.file"
        // 将文件读取成 Data 数据
        let data = try? Data(contentsOf: URL(fileURLWithPath: filePath))
        // 创建解归档对象
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data!)
        // 解归档数据
        let name = unarchiver.decodeObject(forKey: "name")
        let age = unarchiver.decodeInt32(forKey: "age")
        let job = unarchiver.decodeObject(forKey: "job")
        
        print("unarchive mutable data: \(name), \(age), \(job)")
    }
    
    
    // ******************************
    //  对 ArchiveData 类进行 归档测试
    // ******************************
    func archiveObjectData() {
        let rootPath = NSHomeDirectory()
        let filePath = rootPath + "/archiver3.file"
       
        let instance = ArchiveData()
        instance.name = "William Yang"
        instance.age = 18
        
        // 归档
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: instance, requiringSecureCoding: true)
            try data.write(to: URL(fileURLWithPath: filePath))
            
            print("archive success")
        } catch  {
            print("archive failed：\(error)")
        }
    }
    
    // ******************************
    //  对 ArchiveData 类进行 解归档
    // ******************************
    func unarchiveObjectData() {
        let rootPath = NSHomeDirectory()
        let filePath = rootPath + "/archiver3.file"
        
        // 解归档
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let some = try NSKeyedUnarchiver.unarchivedObject(ofClass: ArchiveData.self, from: data)
            
            print("unarchive success: ", some?.name, some?.age)
        } catch {
            print("unarchive failed: \(error)")
        }
    }
    
    // 插入数据
    func insertToCoreData() {
        let context = getDBContext()
        //获取管理的数据上下文 对象
//        let app = UIApplication.shared.delegate as! AppDelegate
//        let context = app.persistentContainer.viewContext
        
        // 创建作者数据
        let author: AuthorEntity = NSEntityDescription.insertNewObject(forEntityName: "AuthorEntity", into: context) as! AuthorEntity
        author.name = "WilliamYang"
        
        // 创建书籍数据
        let book: BookEntity = NSEntityDescription.insertNewObject(forEntityName: "BookEntity", into: context) as! BookEntity
        book.name = "Book A"
        book.price = 25
        book.soldout = false
        book.issueTime = Date(timeIntervalSince1970: TimeInterval(1640880000))
        
        author.relationship = book
        
        // 存储数据
        if ((try? context.save()) != nil) {
            print("save data success")
        } else {
            print("save data failed")
        }
    }
    
    func getDBContext() -> NSManagedObjectContext {
        // 获取数据模型文件地址
        let url = Bundle.main.url(forResource: "iOSAppDemo", withExtension: "momd")
        // 创建数据模型管理实例
        let model = NSManagedObjectModel(contentsOf: url!)
        // 创建存储管理实例
        let store = NSPersistentStoreCoordinator(managedObjectModel: model!)
        
        // 设置存储路径
        let path = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/demo.sqlite")
        print("path: \(path)")
        
        // 设置存储方式为 Sqlite 数据库
        var _ = try? store.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: path, options: nil)
        // 创建数据库操作上下文实例
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        // 关联存储环境
        context.persistentStoreCoordinator = store
        
        return context
    }
    
    func readFromCoreData() {
//        let app = UIApplication.shared.delegate as! AppDelegate
//        let context = app.persistentContainer.viewContext
        
        // 创建查询请求
        let request = NSFetchRequest<AuthorEntity>(entityName: "AuthorEntity")
        // 设置查询条件
        request.predicate = NSPredicate(format: "name==\"WilliamYang\"")
        // 执行查询
        let result = try? getDBContext().execute(request) as? NSAsynchronousFetchResult<AuthorEntity>
        let author = result?.finalResult?.first
        let book = author?.relationship
        
        print(author?.name, book?.name, book?.price, book?.soldout, book?.issueTime)
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
