//
//  SearchListController.swift
//  searchDemoProject
//
//  Created by 陳博竣 on 2020/7/22.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class ResultListController: UIViewController {
    
    var viewModel: PhotosViewModel?
    var resultView: ResultView?
    var resultCollectionView: UICollectionView!
    let userDefault = UserDefaults.standard
    var urlList: [String]!
    var titleList: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        viewModelClosures()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        urlList = userDefault.array(forKey: "urlList") as? [String] ?? []
        titleList = userDefault.array(forKey: "titleList") as? [String] ?? []
    }
    
    private func setUI() {
        
        self.view.backgroundColor = .white
        self.title = "搜尋結果 美食"
        
        let resultView: ResultView = ResultView()
        self.view.addSubview(resultView)
        self.resultView = resultView
        self.resultCollectionView = resultView.resultCollectionView
        self.resultCollectionView.delegate = self
        self.resultCollectionView.dataSource = self
        resultView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}

extension ResultListController {
    
    fileprivate func viewModelClosures() {
        
        guard let viewModel = viewModel else { return }
        
        viewModel.dataUpdated = { [weak self] in
            print("Data Source Updated OK!")
            self?.resultCollectionView.reloadData()
        }
    }
    
    private func loadNextPage() {
        
        guard let viewModel = viewModel else { return }
        
        viewModel.loadNextPage {
            print("next page fetched")
        }
    }
    
    @objc func clickFavoriteBtn(sender: UIButton) {
        
        if sender.backgroundColor == .red {
            let url = self.viewModel!.photoArray[sender.tag].imageURL
            let title = self.viewModel!.photoArray[sender.tag].title
            
            let f_urlList = urlList.filter { (String) -> Bool in
                String != url
            }
            
            let f_titleList = titleList.filter { (String) -> Bool in
                String != title
            }
            
            userDefault.set(f_urlList, forKey: "urlList")
            userDefault.set(f_titleList, forKey: "titleList")
            
            sender.backgroundColor = .black
        } else {
            let url = self.viewModel!.photoArray[sender.tag].imageURL
            let title = self.viewModel!.photoArray[sender.tag].title
            
            urlList.append(url)
            titleList.append(title)
            
            userDefault.set(urlList, forKey: "urlList")
            userDefault.set(titleList, forKey: "titleList")
            
            sender.backgroundColor = .red
        }
        print("click OK!!!!!\(sender.tag)")
    }
}

extension ResultListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel!.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var reCell: UICollectionViewCell!
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SearchListVCell
        
        var photo = self.viewModel!.photoArray[indexPath.row]
        cell.imageUrl = photo.imageURL
        if photo.title.isBlank {
            cell.titleLabel.text = "No Title!!"
            photo.title = "No Title!!"
        } else {
            cell.titleLabel.text = photo.title
        }
        cell.favoriteButton.addTarget(self, action: #selector(ResultListController.clickFavoriteBtn(sender:)), for: .touchUpInside)
        
        if urlList.firstIndex(of: photo.imageURL) != nil {
            cell.favoriteButton.backgroundColor = .red
        } else {
            cell.favoriteButton.backgroundColor = .black
        }
        
        cell.favoriteButton.tag = indexPath.row
        reCell = cell
        
        return reCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == viewModel!.photoArray.count - 1{
            loadNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellSize = CGSize()
        
        cellSize.width = collectionView.frame.width / 2.1
        cellSize.height = cellSize.width
        
        return cellSize
    }
}
