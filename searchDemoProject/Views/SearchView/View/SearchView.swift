//
//  SearchView.swift
//  searchDemoProject
//
//  Created by 陳博竣 on 2020/7/25.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit
import SnapKit

class SearchView: UIView {

    var searchTextField: UITextField!
    var displayNoTextField: UITextField!
    var searchButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI() {
        
        let searchTextField = UITextField()
        searchTextField.placeholder = "欲搜尋內容"
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = .black
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.returnKeyType = .done
        searchTextField.textColor = UIColor.black
        searchTextField.backgroundColor = UIColor.white
        addSubview(searchTextField)
        self.searchTextField = searchTextField
        searchTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(searchTextField.snp.width).multipliedBy(0.1)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.8)
        }
        
        let displayNoTextField = UITextField()
        displayNoTextField.placeholder = "每頁呈現數量"
        displayNoTextField.borderStyle = .roundedRect
        displayNoTextField.backgroundColor = .black
        displayNoTextField.clearButtonMode = .whileEditing
        displayNoTextField.keyboardType = .numberPad
        displayNoTextField.returnKeyType = .done
        displayNoTextField.textColor = UIColor.black
        displayNoTextField.backgroundColor = UIColor.white
        addSubview(displayNoTextField)
        self.displayNoTextField = displayNoTextField
        displayNoTextField.snp.makeConstraints { (make) in
            make.width.height.equalTo(searchTextField)
            make.top.equalTo(searchTextField.snp.bottom).inset(-10)
            make.centerX.equalToSuperview()
        }
        
        let searchButton = UIButton()
        searchButton.clipsToBounds = true
        searchButton.layer.cornerRadius = 5
        searchButton.backgroundColor = .gray
        searchButton.setTitle("搜尋", for: .normal)
        searchButton.tintColor = .white
        addSubview(searchButton)
        self.searchButton = searchButton
        searchButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(searchTextField)
            make.top.equalTo(displayNoTextField.snp.bottom).inset(-10)
            make.centerX.equalToSuperview()
        }
    }
}
