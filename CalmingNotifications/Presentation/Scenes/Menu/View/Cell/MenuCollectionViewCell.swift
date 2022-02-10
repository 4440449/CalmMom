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
        setupCellAppearance()
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
    
    
    private func setupCellAppearance() {
        contentView.layer.cornerRadius = 15
        
        contentView.layer.shadowColor = UIColor.white.cgColor
        contentView.layer.shadowOffset = CGSize(width: -10, height: -10)
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        manageInterfaceStyle()
    }
    
    
    // MARK: - Layout

    private func setupLayout() {
        title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
    }
    
    
    // MARK: - Dark/Light mode management
      
      func manageInterfaceStyle() {
          let interfaceStyle = traitCollection.userInterfaceStyle
//          contentView.backgroundColor = .clear
          switch interfaceStyle {
          case .light: setupLightMode()
          case .dark: setupDarkMode()
          default: return
          }
      }

      private func setupLightMode() {
          let lightColor = NotificationSceneColors_CN.light.color()
          guard contentView.backgroundColor != lightColor else { return }
          contentView.backgroundColor = lightColor
          setupLightModeCellShadows()
      }
      
      private func setupDarkMode() {
          let darkColor = NotificationSceneColors_CN.dark.color()
          guard contentView.backgroundColor != darkColor else { return }
          contentView.backgroundColor = darkColor
          setupDarkModeCellShadows()
      }
      
      private func setupLightModeCellShadows() {
          contentView.layer.shadowRadius = 15
          contentView.layer.shadowOpacity = 0.8
          self.layer.shadowRadius = 7
          self.layer.shadowOpacity = 0.15
      }
      
      private func setupDarkModeCellShadows() {
          contentView.layer.shadowRadius = 15
          contentView.layer.shadowOpacity = 0.1
          self.layer.shadowRadius = 12
          self.layer.shadowOpacity = 0.5
      }
    
}
