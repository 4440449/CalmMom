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
    
    var viewModel: NotificationsCellViewModelProtocol_CN?
    var index: Int?
    
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
    
    
    // MARK: - Static views prop
    
    var titleButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.setImage(UIImage(systemName: "bell.fill"),
                        for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: - Dynamic views prop
    
     var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        if #available(iOS 14.0, *) {
            picker.preferredDatePickerStyle = .wheels
        }
        picker.datePickerMode = .time
        picker.locale = Locale(identifier: "ru_RU")
        picker.date = Date()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.alpha = 0
        return picker
    }()
    
    private var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash.fill"),
                        for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func saveButtonTapped() {
        guard let index = index else { return }
        viewModel?.saveButtonTapped(cellWithIndex: index, new: datePicker.date)
    }
    
    
    @objc func deleteButtonTapped() {
        guard let index = index else { return }
        viewModel?.deleteButtonTapped(cellWithIndex: index)
    }
    
    
    
    
    // MARK: - Cell's UI
    
    private func setupCellAppearance() {
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = .systemBackground
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
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
    
    func animateRemovingDynamicViews() {
        UIView.animate(withDuration: 0.13, delay: 0, options: .curveLinear) {
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
            ] )
        // Bottom
        //        saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        //        saveButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10).isActive = true
    }
    // Top
    
    func reloadData(dateComponents: DateComponents) {
        let calendar = Calendar.current
        guard let time = calendar.date(from: dateComponents) else { return }
        let formattedTime = time.hh_mm()
        datePicker.date = time
        titleButton.setTitle(" \(formattedTime)", for: .normal)
        //
        animateRemovingDynamicViews2()
    }
    
    
    func animateRemovingDynamicViews2() {
        UIView.animate(withDuration: 0, delay: 0, options: .curveLinear) {
            self.datePicker.alpha = 0
            self.saveButton.alpha = 0
            self.deleteButton.alpha = 0
        } completion: { _ in
            self.saveButton.removeFromSuperview()
            self.deleteButton.removeFromSuperview()
            self.datePicker.removeFromSuperview()
        }
    }
}
