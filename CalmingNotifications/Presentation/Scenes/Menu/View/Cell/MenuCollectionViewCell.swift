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
        setupObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Input data flow
    
    private func setupObservers() {
        if let sceneDelegate =
            UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.sceneState.subscribe(observer: self) { [weak self] sceneState in
                guard let strongSelf = self else { return }
                switch sceneState {
                case .foreground:
                    strongSelf.contentView.manageInterfaceStyleBackgroundColor(
                        light: AppColors_CN.light.color(),
                        dark: AppColors_CN.dark.color() )
                    strongSelf.contentView.manageInterfaceStyleShadows(
                        light: .init(radius: 15, opacity: 0.8),
                        dark: .init(radius: 15, opacity: 0.1) )
                    strongSelf.manageInterfaceStyleShadows(
                        light: .init(radius: 7, opacity: 0.15),
                        dark: .init(radius: 12, opacity: 0.5) )
                case .background: return
                }
            }
        }
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
    
    private func setupAppearance() {
        contentView.layer.cornerRadius = 15
        contentView.manageInterfaceStyleBackgroundColor(
            light: AppColors_CN.light.color(),
            dark: AppColors_CN.dark.color() )
        contentView.setupShadows(color: .white,
                                 offset: CGSize(width: -10, height: -10),
                                 rasterize: true)
        contentView.manageInterfaceStyleShadows(
            light: .init(radius: 15, opacity: 0.8),
            dark: .init(radius: 15, opacity: 0.1) )
        self.setupShadows(color: .black,
                          offset: CGSize(width: 10, height: 10),
                          rasterize: true)
        self.manageInterfaceStyleShadows(
            light: .init(radius: 7, opacity: 0.15),
            dark: .init(radius: 12, opacity: 0.5) )
    }
    
    
    // MARK: - Layout
    
    private func setupLayout() {
        title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
    }
    
}



