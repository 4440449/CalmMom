//
//  InterfaceStyleManagement_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 11.02.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


// MARK: - Background color

extension UIView {
    func manageInterfaceStyleBackgroundColor(light: UIColor,
                                             dark: UIColor) {
        let interfaceStyle = traitCollection.userInterfaceStyle
        switch interfaceStyle {
        case .light:
            guard self.backgroundColor != light else { return }
            self.backgroundColor = light
        case .dark:
            guard self.backgroundColor != dark else { return }
            self.backgroundColor = dark
        default:
            return
        }
    }
}


// MARK: - Shadows

extension UIView {
    func setupShadows(color: UIColor? = nil,
                      offset: CGSize? = nil,
                      radius: CGFloat? = nil,
                      opacity: Float? = nil,
                      rasterize: Bool? = nil) {
        if let color = color?.cgColor { self.layer.shadowColor = color }
        if let offset = offset { self.layer.shadowOffset = offset }
        if let radius = radius { self.layer.shadowRadius = radius }
        if let opacity = opacity { self.layer.shadowOpacity = opacity }
        if let rasterize = rasterize {
            guard rasterize else {
                self.layer.shouldRasterize = false
                return
            }
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    func manageInterfaceStyleShadows(light: ShadowSetup_CN,
                                     dark: ShadowSetup_CN) {
        let interfaceStyle = traitCollection.userInterfaceStyle
        switch interfaceStyle {
        case .light:
            self.setupShadows(color: light.color, offset: light.offset, radius: light.radius, opacity: light.opacity, rasterize: light.rasterize)
        case .dark:
            self.setupShadows(color: dark.color, offset: dark.offset, radius: dark.radius, opacity: dark.opacity, rasterize: dark.rasterize)
        default: return
        }
    }
}

struct ShadowSetup_CN {
    var color: UIColor?
    var offset: CGSize?
    var radius: CGFloat?
    var opacity: Float?
    var rasterize: Bool?
}
