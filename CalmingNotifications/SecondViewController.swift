//
//  SecondViewController.swift
//  CalmingNotifications
//
//  Created by Max on 12.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    private lazy var notifView: UIView = {
        let notView = UIView()
        notView.backgroundColor = .systemGray
        notView.translatesAutoresizingMaskIntoConstraints = false
        return notView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupTabBarAppearance()
        view.addSubview(notifView)
        setupNotifViewLayout()
    }
    
    private func setupTabBarAppearance() {
        tabBarItem = UITabBarItem(title: nil,
        image: UIImage(systemName: "bell"),
        selectedImage: UIImage(systemName: "bell.fill"))
    }
    
    private func setupNotifViewLayout() {
        notifView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notifView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        notifView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        notifView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

 
}
