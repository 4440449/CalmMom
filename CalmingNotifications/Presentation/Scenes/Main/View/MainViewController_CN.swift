//
//  MainViewController_CN.swift
//  CalmingNotifications
//
//  Created by Max on 10.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


class MainViewController_CN: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let viewModel: MainViewModelProtocol_CN
    
    init(viewModel: MainViewModelProtocol_CN,
         nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil,
                   bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let collection = MainUICollectionView_CN(frame: view.bounds,
                                                 collectionViewLayout: setupCollectionViewLayout())
        collection.register(MainCollectionViewCell_CN.self,
                            forCellWithReuseIdentifier: MainCollectionViewCell_CN.identifier)
        collection.contentInsetAdjustmentBehavior = .never
        collection.alwaysBounceVertical = false
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private var menuButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(menuButton)
        setupMenuButtonLayout()
        //        tabBarItem = UITabBarItem(title: nil,
        //                                  image: UIImage(systemName: "house"),
        //                                  selectedImage: UIImage(systemName: "house.fill"))
        viewModel.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews")
    }
    
    private func setupCollectionViewLayout() -> UICollectionViewCompositionalLayout {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //        item.contentInsets = .init(top: 1, leading: 1, bottom: 1, trailing: 1)
    
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
    
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .paging
    
            return UICollectionViewCompositionalLayout(section: section)
        }
    
    
    private func setupMenuButtonLayout() {
        menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        menuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        menuButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
//
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell_CN.identifier, for: indexPath) as? MainCollectionViewCell_CN else { fatalError() }
        return cell
    }
    
    
    @objc private func menuButtonTapped() {
        viewModel.menuButtonTapped()
        //        tabBarController?.show(CN_MenuViewController(), sender: nil)
        
    }
    
    
    
}
