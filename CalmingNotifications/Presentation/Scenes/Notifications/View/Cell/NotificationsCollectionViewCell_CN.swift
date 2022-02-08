//
//  NotificationsCollectionViewCell_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 18.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


class NotificationsCollectionViewCell_CN: UICollectionViewCell {
    
    static let identifier = String(describing: NotificationsCollectionViewCell_CN.self)
    
    
    // MARK: - Dependencies
    
    private var viewModel: NotificationsCellViewModelProtocol_CN?
    
    
    // MARK: - State
    
    private var index: Int?
    
    
    // MARK: - Cell's setup
    
    func setupDependencies<VM>(viewModel: VM, index: Int) {
        guard let vm = viewModel as? NotificationsCellViewModelProtocol_CN else { return }
        self.viewModel = vm
        self.index = index
    }
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleButton)
        setupCellAppearance()
        setupStaticViewsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Input data flow
    
    func reloadData(time: Date) {
        animateRemovingDynamicViews(duration: 0.0)
        titleButton.setTitle(" \(time.hh_mm())", for: .normal)
        resetDatePickerTime(time)
//        datePicker.date = date
    }
    
    func resetDatePickerTime(_ time: Date) {
        datePicker.date = Date()
        datePicker.date = time
    }
    
    // MARK: - UI -
    
    // MARK: - Static views prop
    
    private var titleButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.setImage(UIImage(systemName: "bell.fill"),
                        for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: - Dynamic views prop
    
    private var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        if #available(iOS 14.0, *) {
            picker.preferredDatePickerStyle = .wheels
        }
        picker.datePickerMode = .time
        picker.locale = Locale(identifier: "ru_RU")
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.alpha = 0
        return picker
    }()
    
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        button.isUserInteractionEnabled = true
        button.addTarget(self,
                         action: #selector(saveButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func saveButtonTapped() {
        guard let index = index else { return }
        viewModel?.saveButtonTapped(cellWithIndex: index, new: datePicker.date)
    }
    
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash.fill"),
                        for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.alpha = 0
        button.addTarget(self,
                         action: #selector(deleteButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func deleteButtonTapped() {
        guard let index = index else { return }
        viewModel?.deleteButtonTapped(cellWithIndex: index)
    }
    
    
    // MARK: - Cell's UI
    
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
    
    private func setupStaticViewsLayout() {
        NSLayoutConstraint.activate(
            [titleButton.topAnchor.constraint(equalTo: contentView.topAnchor,
                                              constant: 10),
             titleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                  constant: 20),
             titleButton.heightAnchor.constraint(equalToConstant: (contentView.bounds.height / 2.5))] )
    }
    
    
    // MARK: - Dynamic views animation
    
    func animateAddingDynamicViews() {
        contentView.addSubview(datePicker)
        contentView.addSubview(saveButton)
        contentView.addSubview(deleteButton)
        setupDynamicViewsLayout()
        UIView.animate(withDuration: 0.4, delay: 0.05, options: .curveEaseIn) {
            self.datePicker.alpha = 1
            self.saveButton.alpha = 1
            self.deleteButton.alpha = 1
        }
    }
    
    func animateRemovingDynamicViews(duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear) {
            self.datePicker.alpha = 0
            self.saveButton.alpha = 0
            self.deleteButton.alpha = 0
        } completion: { _ in
            self.saveButton.removeFromSuperview()
            self.deleteButton.removeFromSuperview()
            self.datePicker.removeFromSuperview()
        }
    }
    
    private func setupDynamicViewsLayout() {
        NSLayoutConstraint.activate(
            [datePicker.topAnchor.constraint(equalTo: titleButton.bottomAnchor,
                                             constant: 20),
             datePicker.widthAnchor.constraint(equalToConstant: (contentView.bounds.width / 1.3)),
             datePicker.heightAnchor.constraint(equalToConstant: (contentView.bounds.height * 2.3)),
             datePicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
             
             saveButton.topAnchor.constraint(equalTo: contentView.topAnchor,
                                             constant: 10),
             saveButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor,
                                                  constant: -20),
             saveButton.heightAnchor.constraint(equalToConstant: (contentView.bounds.height / 2.5)),
             deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
             deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
             deleteButton.heightAnchor.constraint(equalToConstant: contentView.bounds.height / 2.5)
            ]
        )
    }
    
    
  // MARK: - Dark/Light mode management
    
    func manageInterfaceStyle() {
        let interfaceStyle = traitCollection.userInterfaceStyle
        contentView.backgroundColor = .clear
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




extension Date {
    func hh_mm() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = .short
        let formatDate = formatter.string(from: self)
        return formatDate
    }
}
