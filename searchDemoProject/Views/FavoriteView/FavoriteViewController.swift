//
//  FavoriteViewController.swift
//  searchDemoProject
//
//  Created by 陳博竣 on 2020/7/27.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var favoriteView: FavoriteView?
    var favoriteCollectionView: UICollectionView!
    let userDefault = UserDefaults.standard
    var urlList: [String]!
    var titleList: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        urlList = userDefault.array(forKey: "urlList") as? [String] ?? []
        titleList = userDefault.array(forKey: "titleList") as? [String] ?? []
        
        self.favoriteCollectionView.reloadData()
    }
    
    private func setUI() {
        
        self.view.backgroundColor = .white
        self.title = "我的最愛"
        
        let favoriteView: FavoriteView = FavoriteView()
        self.view.addSubview(favoriteView)
        self.favoriteView = favoriteView
        self.favoriteCollectionView = favoriteView.faovriteCollectionView
        self.favoriteCollectionView.delegate = self
        self.favoriteCollectionView.dataSource = self
        favoriteView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urlList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var reCell: UICollectionViewCell!
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FavoriteListVCell
        
        cell.faovriteImgView.backgroundColor = .black
        cell.imageUrl = urlList[indexPath.row]
        if titleList[indexPath.row].isBlank {
            cell.titleLabel.text = "No Title!!"
        } else {
            cell.titleLabel.text = titleList[indexPath.row]
        }
        
        reCell = cell
        
        return reCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellSize = CGSize()

        cellSize.width = collectionView.frame.width / 2.1
        cellSize.height = cellSize.width

        return cellSize
    }
    

}
