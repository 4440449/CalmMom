//
//  NotificationsCollectionHeaderReusableView.swift
//  CalmingNotifications
//
//  Created by Maxim on 18.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


class NotificationsCollectionHeaderReusableView: UICollectionReusableView {
    
    // MARK: - Static
    
    static let identifier = String(describing: NotificationsCollectionHeaderReusableView.self)
    
    
    // MARK: - Dependencies
    
    private var viewModel: NotificationsHeaderViewModelProtocol_CN?
    
    func setupDependencies<VM>(viewModel: VM) {
        guard let vm = viewModel as? NotificationsHeaderViewModelProtocol_CN else { return }
        self.viewModel = vm
    }
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(title)
        self.addSubview(addNewNotificationButton)
        setupLayoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI
    
    private var title: UILabel = {
        let label = UILabel()
        label.text = "Notifications"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var addNewNotificationButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addNewNotificationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func addNewNotificationButtonTapped() {
        viewModel?.addNewNotificationButtonTapped(date: Date())
    }
    
    func setupLayoutViews() {
        title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        addNewNotificationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        addNewNotificationButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    
}


