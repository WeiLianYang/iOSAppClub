//
//  CollectionViewController.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2022/1/8.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource { // : UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建集合视图布局类
        let layout = WaterFallFlowLayout(itemCount: 50)
        // 设置布局方向为竖直方向
        layout.scrollDirection = .vertical
        // 设置每个数据载体的尺寸
//        layout.itemSize = CGSize(width: 115, height: 115)
        // 设置最小 行间距
        layout.minimumLineSpacing = 10
        // 设置最小列间距
        layout.minimumInteritemSpacing = 10
        // 设置头视图尺寸
        layout.headerReferenceSize = CGSize(width: self.view.frame.size.width, height: 80)
        // 设置尾视图尺寸
        layout.footerReferenceSize = CGSize(width: self.view.frame.size.width, height: 50)
        // 设置分区边距
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // 创建集合视图
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        // 设置代理与数据源
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 注册数据载体类
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.view.addSubview(collectionView)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    // 返回分组的数量
    /*
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    */
    
    // 返回每组的数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 50
    }

    // 返回 Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        cell.backgroundColor = UIColor(red: CGFloat(arc4random() % 255) / 255, green: CGFloat(arc4random() % 255) / 255, blue: CGFloat(arc4random() % 255) / 255, alpha: 1)
    
        return cell
    }
    
    // 选中时回调
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("user click row: \(indexPath.row)")
    }
    
    // 设置每个 cell 的尺寸
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row % 2 == 0 {
            return CGSize(width: 50, height: 50)
        } else {
            return CGSize(width: 100, height: 100)
        }
    }
    */

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
