//
//  MenuViewController_CN.swift
//  CalmingNotifications
//
//  Created by Max on 12.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit

class MenuViewController_CN: UIViewController,
                             UICollectionViewDataSource,
                             UICollectionViewDelegateFlowLayout {
    
    // MARK: - Dependencies

    private let viewModel: MenuViewModel_CN
    
    
    // MARK: - Init
    
    init(viewModel: MenuViewModel_CN,
                  nibName nibNameOrNil: String?,
                  bundle nibBundleOrNil: Bundle?) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil,
                   bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View's lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        manageInterfaceStyle()
        setupObservers()
        viewModel.viewDidLoad()
    }
    
    
    // MARK: - Input data flow

    private func setupObservers() {
        if let sceneDelegate =
            UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.sceneState.subscribe(observer: self) { [weak self] sceneState in
                switch sceneState {
                case .foreground:
                    self?.manageInterfaceStyle()
                    self?.collectionView.reloadData()
                case .background: return
                }
            }
        }
        viewModel.menuItems.subscribe(observer: self) { [weak self] _ in
            self?.collectionView.reloadData()
        }
        
    }
    
    
    // MARK: - UI -

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(MenuCollectionViewCell.self,
                            forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        //        collection.contentInsetAdjustmentBehavior = .never
        collection.showsVerticalScrollIndicator = false
        collection.alwaysBounceVertical = true
        collection.contentInset.top = 70
        return collection
    }()
    
    
    //MARK: - Data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.menuItems.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else { fatalError() }
        let title = viewModel.menuItems.value[indexPath.row].title.rawValue
        cell.setupTitleText(title)
        cell.manageInterfaceStyle()
        return cell
    }
    
    
    //MARK: - Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(index: indexPath.row)
    }
    
    
    //MARK: - Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 60,
                      height: collectionView.bounds.height / 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(30)
    }
    
    
    // MARK: - Dark/Light mode management
    
    private func manageInterfaceStyle() {
        let interfaceStyle = traitCollection.userInterfaceStyle
        switch interfaceStyle {
        case .light:
            setupLightMode()
        case .dark:
            setupDarkMode()
        default:
            return
        }
    }

    private func setupLightMode() {
        let lightColor = NotificationSceneColors_CN.light.color()
        guard collectionView.backgroundColor != lightColor else { return }
        collectionView.backgroundColor = lightColor
    }
    
    private func setupDarkMode() {
        let darkColor = NotificationSceneColors_CN.dark.color()
        guard collectionView.backgroundColor != darkColor else { return }
        collectionView.backgroundColor = darkColor
    }
    
    
    deinit {
        print("deinit NotificationsViewController_CN")
    }

}
