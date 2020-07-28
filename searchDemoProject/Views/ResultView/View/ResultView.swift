//
//  ResultView.swift
//  searchDemoProject
//
//  Created by 陳博竣 on 2020/7/26.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class SearchListVCell: UICollectionViewCell {
    
    var resultImgView: UIImageView!
    var titleLabel: UILabel!
    var favoriteButton: UIButton!
    var imageUrl: String? {
        didSet {
            guard let imageUrl = imageUrl else { return }
            resultImgView.loadImageUsingCache(with: imageUrl)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setUI() {
        
        let resultImgView = UIImageView()
        resultImgView.contentMode = .scaleAspectFit
        resultImgView.backgroundColor = .black
        addSubview(resultImgView)
        resultImgView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        self.resultImgView = resultImgView
        
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "PingFangTC-Semibold", size: 20)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(resultImgView.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
        self.titleLabel = titleLabel
        
        let favoriteButton = UIButton()
        favoriteButton.setTitle("Like", for: .normal)
        favoriteButton.backgroundColor = .black
        favoriteButton.isUserInteractionEnabled = true
        addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { (make) in
            make.top.left.equalTo(resultImgView)
        }
        self.favoriteButton = favoriteButton
    }
}

class ResultView: UIView {

    var resultCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var resultCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI() {
        let resultCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: resultCollectionViewLayout)
        resultCollectionView.scrollsToTop = false
        resultCollectionView.backgroundColor = UIColor.clear
        resultCollectionView.register(SearchListVCell.self, forCellWithReuseIdentifier: "Cell")
        resultCollectionViewLayout.scrollDirection = .vertical
        self.addSubview(resultCollectionView)
        resultCollectionView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        self.resultCollectionView = resultCollectionView
    }
}
