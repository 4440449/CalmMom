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
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI -
    
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
        let text = "Уведомления отключены. Разрешите их получение в настройках"
        let atrText = NSMutableAttributedString(string: text,
                                               attributes: [:])
        atrText.addAttributes([.foregroundColor : UIColor.systemBlue,
                               .underlineStyle: NSUnderlineStyle.single.rawValue],
                              range: NSRange(location: 48, length: 10))
        button.setAttributedTitle(atrText, for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(notificationStatusButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc func notificationStatusButtonTapped() {
        if let appSettings = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(appSettings) {
            UIApplication.shared.open(appSettings)
        }
    }
    
    
    // MARK: - Layout
    
    func setupLayout() {
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    
    // MARK: - Push notifications auth mode management
    
    func manageAuthStatusMode(isAuthorized: PushNotificationsAuthStatus_CN) {
        switch isAuthorized {
        case .authorized:
            showAddNewButton()
            hideWarning()
        case .notAuthorized:
            hideAddNewButon()
            showWarning()
        }
    }
    
    private func showAddNewButton() {
        self.addSubview(addNewNotificationButton)
        addNewNotificationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        addNewNotificationButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
    }
    
    private func hideAddNewButon() {
        addNewNotificationButton.removeFromSuperview()
    }
    
    
    private func showWarning() {
        self.addSubview(notificationStatus)
        notificationStatus.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        notificationStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        notificationStatus.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20).isActive = true
    }
    
    private func hideWarning() {
        notificationStatus.removeFromSuperview()
    }
    
    
}


