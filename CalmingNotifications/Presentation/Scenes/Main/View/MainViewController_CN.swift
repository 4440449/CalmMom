//
//  MainViewController_CN.swift
//  CalmingNotifications
//
//  Created by Max on 10.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit
import MommysEye


class MainViewController_CN: UIViewController,
                             UICollectionViewDataSource,
                             UICollectionViewDelegate {
    
    // MARK: - Dependencies
    
    private let viewModel: MainViewModelProtocol_CN
    private let animator: CheckMarkAnimatableProtocol_CN
    
    
    // MARK: - Init
    
    init(viewModel: MainViewModelProtocol_CN,
         animator: CheckMarkAnimatableProtocol_CN,
         nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?) {
        self.viewModel = viewModel
        self.animator = animator
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
        view.addSubview(menuButton)
        view.addSubview(activity)
//        view.addSubview(dimView)
        setupLayout()
        setupObservers()
        viewModel.viewDidLoad()
        //        view.layer.addSublayer(pathLayer)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //        print("viewWillLayoutSubviews")
    }
    
    
    // MARK: - Input data flow
    
    private func setupObservers() {
        viewModel.quoteCards.subscribe(observer: self) { [weak self] _ in
            self?.collectionView.reloadData()
        }
        
        viewModel.isLoading.subscribe(observer: self) { [weak self] isLoading in
            switch isLoading {
            case .true: self?.activity.startAnimating()
            case .false: self?.activity.stopAnimating()
            }
        }
        viewModel.showSuccessAnimation.subscribe(observer: self) { [weak self] toShow in
            switch toShow {
            case true: self?.successAnimation()
            case false: return
            }
        }
    }
    
    // MARK: - UI -
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: view.bounds,
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
        button.tintColor = .white
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(menuButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func menuButtonTapped() {
        viewModel.menuButtonTapped()
//        successAnimation()
    }
    
    private lazy var activity: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.center = self.view.center
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.color = .systemGray
        return indicator
    }()
    
//    private lazy var dimView: UIView = {
//        let view = UIView()
//        view.frame = self.view.frame
//        view.backgroundColor = .black
//        view.alpha = 0
//        view.isHidden = true
//        return view
//    }()
//
//    private var feedbackGenerator = UINotificationFeedbackGenerator()
//
//    private lazy var checkMarkLayer: CAShapeLayer = {
//        CATransaction.begin()
//        let layer = CAShapeLayer()
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: self.view.bounds.midX - 20,
//                              y: self.view.bounds.midY - 20))
//        path.addLine(to: CGPoint(x: self.view.bounds.midX,
//                                 y: self.view.bounds.midY))
//        path.addLine(to: CGPoint(x: self.view.bounds.midX + 25,
//                                 y: self.view.bounds.midY - 50))
//        layer.frame = self.view.bounds
//        layer.path = path.cgPath
//        layer.strokeColor = UIColor.white.cgColor
//        layer.fillColor = nil
//        layer.lineCap = .round
//        layer.lineWidth = 5
//        layer.lineJoin = .round
//        return layer
//    }()
    
    
    //MARK: - Data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.quoteCards.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell_CN.identifier, for: indexPath) as? MainCollectionViewCell_CN else { fatalError() }
        cell.setupDependencies(viewModel: viewModel, index: indexPath.row)
        cell.fillContent(quote: viewModel.quoteCards.value[indexPath.row].quote,
                         image: viewModel.quoteCards.value[indexPath.row].image)
        cell.setLikeButtonsState(isFavorite: viewModel.quoteCards.value[indexPath.row].isFavorite)
        return cell
    }
    
    
    //MARK: - Layout
    
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
    
    
    private func setupLayout() {
        menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        menuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        menuButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    // MARK: - Animation
    
    private func successAnimation() {
        
        animator.checkMarkAnimation(for: view)
        
//        let generator = animator.feedbackGenerator
//        generator.prepare()
//        let checkMark = animator.checkMarkLayer(for: view.bounds)
//        let dimView = animator.dimView(for: view.bounds)
//        view.addSubview(dimView)
//        view.layer.addSublayer(checkMark)
//        animator.dimAnimation(for: dimView)
//        animator.strokeCheckMarkAnimation(for: checkMark)
//        generator.notificationOccurred(.success)
        
        
//        feedbackGenerator.prepare()
//        view.layer.addSublayer(checkMarkLayer)
//        dimAnimation()
//        strokeCheckMarkAnimation()
//        feedbackGenerator.notificationOccurred(.success)
    }
    
//    private func strokeCheckMarkAnimation() {
//        let pathAnimation = CABasicAnimation(keyPath:"strokeEnd")
//        pathAnimation.duration = 0.35
//        pathAnimation.fromValue = 0
//        pathAnimation.toValue = 1
//        pathAnimation.isRemovedOnCompletion = true
//        CATransaction.setCompletionBlock {
//            self.hideCheckMarkAnimation()
//        }
//        checkMarkLayer.add(pathAnimation, forKey: "strokeEnd")
//        CATransaction.commit()
//    }
//
//    private func hideCheckMarkAnimation() {
//        let removeAnimation = CABasicAnimation(keyPath: "opacity")
//        removeAnimation.duration = 0.2
//        removeAnimation.fromValue = 1
//        removeAnimation.toValue = 0
//        removeAnimation.isRemovedOnCompletion = false
//        removeAnimation.fillMode = .forwards
//        CATransaction.setCompletionBlock {
//            self.checkMarkLayer.removeAllAnimations()
//            self.checkMarkLayer.removeFromSuperlayer()
//        }
//        checkMarkLayer.add(removeAnimation, forKey: "opacity")
//        CATransaction.commit()
//    }
//
//    private func dimAnimation() {
//        UIView.animate(withDuration: 0.25,
//                       delay: 0,
//                       options: .curveEaseInOut) {
//            self.dimView.isHidden = false
//            self.dimView.alpha = 0.4
//        } completion: { _ in
//            UIView.animate(withDuration: 0.3,
//                           delay: 0,
//                           options: .curveEaseOut) {
//                self.dimView.alpha = 0
//            } completion: { _ in
//                self.dimView.isHidden = true
//            }
//        }
//    }
    
}


