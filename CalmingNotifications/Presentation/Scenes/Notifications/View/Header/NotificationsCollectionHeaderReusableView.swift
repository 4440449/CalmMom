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
//        self.backgroundColor = .red
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
    
    private lazy var addNewNotificationButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(addNewNotificationButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func addNewNotificationButtonTapped() {
        viewModel?.addNewNotificationButtonTapped(date: Date())
    }
    
    private var notificationStatus: UIButton = {
        let button = UIButton()
        button.setTitle("Уведомления отключены. Разрешите их получение в настройках", for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
//        button.semanticContentAttribute = .forceRightToLeft
        button.setTitleColor(.label, for: .normal)
//        button.setImage(UIImage(systemName: "gearshape.fill"),
//                        for: .normal)
        
        button.scalesLargeContentImage = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(notificationStatusButtonTapped), for: .touchUpInside)
//        button.backgroundColor = .green
        return button
    }()
    
    @objc func notificationStatusButtonTapped() {
        print("notif button tapped")
        if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
            UIApplication.shared.open(appSettings)
        }
    }
    
    
    func setupLayoutViews() {
//        title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        addNewNotificationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        addNewNotificationButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
//        addNewNotificationButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
//        notificationStatus.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
//        notificationStatus.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20).isActive = true
//        notificationStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
//        notificationStatus.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
//        notificationStatus.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func managePushNotificationsWarning(isAuthorized: Bool) {
        if !isAuthorized {
            self.addSubview(notificationStatus)
            notificationStatus.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
            notificationStatus.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20).isActive = true
            notificationStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        } else {
            notificationStatus.removeFromSuperview()
        }
    }
    
}


