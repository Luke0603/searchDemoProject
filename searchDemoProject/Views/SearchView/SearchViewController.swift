//
//  ViewController.swift
//  searchDemoProject
//
//  Created by 陳博竣 on 2020/7/22.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchView: SearchView?
    var isCanSearch: Bool = false
    private var viewModel = PhotosViewModel()
    private var searchKeyword: String = ""
    private var displayNo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    private func setUI() {
        
        print("測試git")
        self.view.backgroundColor = .white
        self.title = "搜尋輸入頁"
        
        let searchView: SearchView = SearchView()
        self.view.addSubview(searchView)
        self.searchView = searchView
        searchView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        searchView.searchButton.addTarget(self, action: #selector(SearchViewController.searchList), for: .touchUpInside)
        searchView.searchTextField.addTarget(self, action: #selector(SearchViewController.textDidChange), for: .editingChanged)
        searchView.displayNoTextField.addTarget(self, action: #selector(SearchViewController.textDidChange), for: .editingChanged)
        
    }
    
    // 點擊空白位置，收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 搜尋圖片
    @objc func searchList() {
        if isCanSearch {
            // 點擊搜尋，收鍵盤
            self.view.endEditing(true)
            viewModel.search(SearchWord: self.searchKeyword, DisplayNo: self.displayNo) {
                DispatchQueue.main.async {
                    let vc: ResultListController = ResultListController()
                    vc.viewModel = self.viewModel
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    // 監控textField的值，改變搜尋按鈕
    @objc func textDidChange(_ textField:UITextField) {
        guard let view = searchView else { return }
        
        if let keyword = view.searchTextField.text, let displayNo = view.displayNoTextField.text {
            if !keyword.isBlank && !displayNo.isBlank {
                view.searchButton.backgroundColor = UIColor.blue
                self.searchKeyword = keyword
                self.displayNo = displayNo
                isCanSearch = true
            } else {
                view.searchButton.backgroundColor = UIColor.gray
                isCanSearch = false
            }
        }
    }
}

