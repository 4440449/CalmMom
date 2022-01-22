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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = .systemBackground
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var datePicker: UIDatePicker = {
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
        button.backgroundColor = .systemRed
//        button.addTarget(self, action: #selector(addNotificationButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        return button
    }()
    
    
    func setupViews() {
        contentView.addSubview(datePicker)
        contentView.addSubview(saveButton)
        datePicker.frame.size = CGSize(width: contentView.bounds.width / 2,
                                       height: contentView.bounds.height / 2)
        UIView.animate(withDuration: 0.5) {
            self.datePicker.alpha = 1
            self.saveButton.alpha = 1
        }
        
    }
    
    func removeViews() {
        print("removeViews")
        UIView.animate(withDuration: 0.5) {
            print("animate")
            self.datePicker.alpha = 0
            self.saveButton.alpha = 0
            print("animate off")
        }
        datePicker.removeFromSuperview()
        saveButton.removeFromSuperview()
    }
}
