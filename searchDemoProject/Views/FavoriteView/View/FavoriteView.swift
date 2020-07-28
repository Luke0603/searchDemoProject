//
//  FavoriteView.swift
//  searchDemoProject
//
//  Created by 陳博竣 on 2020/7/27.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class FavoriteListVCell: UICollectionViewCell {
    
    var faovriteImgView: UIImageView!
    var titleLabel: UILabel!
    var imageUrl: String? {
        didSet {
            guard let imageUrl = imageUrl else { return }
            faovriteImgView.loadImageUsingCache(with: imageUrl)
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
        
        let faovriteImgView = UIImageView()
        faovriteImgView.contentMode = .scaleAspectFit
        faovriteImgView.backgroundColor = .black
        addSubview(faovriteImgView)
        faovriteImgView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        self.faovriteImgView = faovriteImgView
        
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "PingFangTC-Semibold", size: 20)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(faovriteImgView.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
        self.titleLabel = titleLabel
    }
}

class FavoriteView: UIView {
    var faovriteCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var faovriteCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI() {
        let faovriteCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: faovriteCollectionViewLayout)
        faovriteCollectionView.scrollsToTop = false
        faovriteCollectionView.backgroundColor = UIColor.clear
        faovriteCollectionView.register(FavoriteListVCell.self, forCellWithReuseIdentifier: "Cell")
        faovriteCollectionViewLayout.scrollDirection = .vertical
        self.addSubview(faovriteCollectionView)
        faovriteCollectionView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        self.faovriteCollectionView = faovriteCollectionView
    }

}
