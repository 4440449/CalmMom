//
//  MainCollectionViewCell_CN.swift
//  CalmingNotifications
//
//  Created by Max on 11.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit

class MainCollectionViewCell_CN: UICollectionViewCell {
    
    static let identifier = String(describing: MainCollectionViewCell_CN.self)
    
    
    private var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "Mom's Exhale"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var quoteLabel: UILabel = {
        let label = UILabel()
        label.text = "Держи себя в руках... иначе пздц... dasd asd asd a sdssssddsda sd asd asdkasoia sjoia oj op jpasd jpasd p kpasodk paskd p[asdk p jkp "
        label.numberOfLines = 10
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemRed
        //        button.addGestureRecognizer(tapGest)
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemTeal
        [logoLabel, quoteLabel, likeButton].forEach { self.contentView.addSubview($0) }
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupLayout() {
        logoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        logoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        logoLabel.bottomAnchor.constraint(equalTo: quoteLabel.topAnchor, constant: -40).isActive = true
        
        quoteLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        quoteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        quoteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        likeButton.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 30).isActive = true
        likeButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    
    
    @objc func likeButtonTapped() {
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        likeButton.isSelected = !likeButton.isSelected
        print("likeButton is selected == \(likeButton.isSelected)")
    }
    
}
