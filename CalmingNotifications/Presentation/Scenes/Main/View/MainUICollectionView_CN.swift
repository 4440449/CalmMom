//
//  MainUICollectionView_CN.swift
//  CalmingNotifications
//
//  Created by Max on 11.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit

class MainUICollectionView_CN: UICollectionView {

    
    
    override init(frame: CGRect,
                  collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = .systemPink
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupCollectionView() {
//        logoLabel = UILabel(frame: <#T##CGRect#>)
    }
    
   

}
