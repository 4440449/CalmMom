//
//  DateFormatter_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 11.02.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation


extension Date {
    func hh_mm() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = .short
        let formatDate = formatter.string(from: self)
        return formatDate
    }
}
