//
//  NotificationsCollectionHeaderReusableView.swift
//  CalmingNotifications
//
//  Created by Maxim on 18.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit

class NotificationsCollectionHeaderReusableView: UICollectionReusableView {
    
    static let identifier = String(describing: NotificationsCollectionHeaderReusableView.self)
    
    private let viewModel: NotificationsHeaderViewModelProtocol_CN
    
    init(frame: CGRect,
         viewModel: NotificationsHeaderViewModelProtocol_CN) {
        self.viewModel = viewModel
        super.init(frame: frame)
        self.addSubview(title)
        self.addSubview(addNewNotificationButton)
        setupLayoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var title: UILabel = {
        let label = UILabel()
        label.text = "Notifications"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var addNewNotificationButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addNewNotificationAction), for: .touchUpInside)
        return button
    }()
 
    
    @objc private func addNewNotificationAction() {
        print("addNewNotificationAction")
    }
    
    func setupLayoutViews() {
        title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        addNewNotificationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        addNewNotificationButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}


