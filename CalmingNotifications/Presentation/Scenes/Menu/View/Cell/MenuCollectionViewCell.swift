//
//  MenuCollectionViewCell.swift
//  CalmingNotifications
//
//  Created by Maxim on 11.02.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: MenuCollectionViewCell.self)
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(title)
        setupAppearance()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI -
    
    private var title: UILabel = {
        let label = UILabel()
        label.text = "Mom's Exhale"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupTitleText(_ text: String) {
        title.text = text
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            contentView.layer.borderColor = UIColor(named: "borderColor")?.cgColor
            contentView.layer.shadowColor = UIColor(named: "topShadowColor")?.cgColor
            self.layer.shadowColor = UIColor(named: "bottomShadowColor")?.cgColor
        }
    }
    
    private func setupAppearance() {
        contentView.backgroundColor = UIColor(named: "backgroundColor")
        
        contentView.layer.cornerRadius = 15
        contentView.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.setupShadows(color: UIColor(named: "topShadowColor"),
                                 offset: CGSize(width: -10, height: -10),
                                 radius: 7,
                                 opacity: 1,
                                 rasterize: true)
        self.setupShadows(color: UIColor(named: "bottomShadowColor"),
                          offset: CGSize(width: 10, height: 10),
                          radius: 7,
                          opacity: 1,
                          rasterize: true)
    }
    
    
    // MARK: - Layout
    
    private func setupLayout() {
        title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
    }
    
}



