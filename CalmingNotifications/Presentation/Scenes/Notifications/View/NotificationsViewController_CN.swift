//
//  NotificationsViewController_CN.swift
//  CalmingNotifications
//
//  Created by Max on 12.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit

class NotificationsViewController_CN: UIViewController,
                                      UICollectionViewDataSource,
                                      UICollectionViewDelegateFlowLayout {
    
    // MARK: - Dependencies
    
    private let viewModel: NotificationsViewModelProtocol_CN
    
    
    // MARK: - Init
    
    init(viewModel: NotificationsViewModelProtocol_CN,
         nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil,
                   bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Views
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(NotificationsCollectionViewCell_CN.self,
                            forCellWithReuseIdentifier: NotificationsCollectionViewCell_CN.identifier)
        collection.register(NotificationsCollectionHeaderReusableView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: NotificationsCollectionHeaderReusableView.identifier)
        collection.dataSource = self
        collection.delegate = self
        //        collection.contentInsetAdjustmentBehavior = .never
        collection.showsVerticalScrollIndicator = false
        collection.alwaysBounceVertical = true
        collection.backgroundColor = .systemBackground
        collection.contentInset.bottom = 40
        return collection
    }()
    
    private lazy var activity: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.color = .systemGray
        return indicator
    }()
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(activity)
        setupObservers()
        viewModel.viewDidLoad()
    }
    
    
    // MARK: - Input data flow
    
    private func setupObservers() {
        viewModel.notifications.subscribe(observer: self) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.selectedIndex = -1
            UIView.transition(with: strongSelf.collectionView,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                strongSelf.collectionView.reloadData()
            })
        }
        
        viewModel.isLoading.subscribe(observer: self) { [weak self] isLoading in
            switch isLoading {
            case .true: self?.activity.startAnimating()
            case .false: self?.activity.stopAnimating()
            }
        }
    }
    
    
    // MARK: - Private state
    
    private var selectedIndex = -1
    
    
    //MARK: - Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (selectedIndex == indexPath.row) ? collectionView.bounds.height / 3 : collectionView.bounds.height / 11
        return CGSize(width: collectionView.bounds.width - 60,
                      height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 60,
                      height: collectionView.bounds.height / 11)
    }
    
    
    //MARK: - Header
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NotificationsCollectionHeaderReusableView.identifier, for: indexPath) as? NotificationsCollectionHeaderReusableView else { fatalError() }
        header.setupDependencies(viewModel: viewModel)
        return header
    }
    
    
    //MARK: - Data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.notifications.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotificationsCollectionViewCell_CN.identifier, for: indexPath) as? NotificationsCollectionViewCell_CN else { fatalError() }
        cell.setupDependencies(viewModel: viewModel, index: indexPath.row)
        cell.reloadData(date: viewModel.notifications.value[indexPath.row].time)
        return cell
    }
      
    
    //MARK: - Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: Управление вьюхами ячеек через VM! Убрать даун каст
        guard let targetCell = collectionView.cellForItem(at: indexPath) as? NotificationsCollectionViewCell_CN else { return }
        switch selectedIndex {
        case _ where selectedIndex == -1 :
            // Ячейка закрыта ==> раскрываю, устанавливаю вьюхи
            targetCell.animateAddingDynamicViews()
            selectedIndex = indexPath.row
        case _ where selectedIndex == indexPath.row :
            // Тап на ту же ячейку ==> ячейка открыта ==> закрываю, удалаяю вьюхи, обнуляю индекс
            targetCell.animateRemovingDynamicViews()
            selectedIndex = -1
            //            collectionView.performBatchUpdates(nil, completion: nil)
        case _ where selectedIndex != indexPath.row :
            // Ячейка не закрыта, условие '== -1' проверено выше ==> тап на другую закрытую ячейку ==> закрываю текущую открытую, удаляю вьюхи ==> открываю новую по index, устанавливаю вьюхи
            guard let closingCell = collectionView.cellForItem(at: IndexPath(row: selectedIndex, section: 0)) as? NotificationsCollectionViewCell_CN else { return }
            closingCell.animateRemovingDynamicViews()
            targetCell.animateAddingDynamicViews()
            selectedIndex = indexPath.row
        default: return
        }
        collectionView.performBatchUpdates(nil) { _ in
            self.collectionView.scrollToItem(at: indexPath,
                                             at: .centeredVertically,
                                             animated: true)
        }
    }
    
    deinit {
        print("deinit NotificationsViewController_CN")
    }
    
}


