//
//  SplashViewController_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 04.02.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit

class SplashViewController_CN: UIViewController {

    // MARK: - Dependencies

    private let viewModel: SplashViewModelProtocol_CN
    
    
    // MARK: - Init

    init(viewModel: SplashViewModelProtocol_CN,
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
        view.backgroundColor = UIColor(patternImage: UIImage(named: "SplashScreen")!)
//        view.addSubview(activity)
        view.addSubview(progress)
        setupObservers()
        viewModel.viewDidLoad()
    }
    
    private func setupObservers() {
//        viewModel.isLoading.subscribe(observer: self) { [weak self] isLoading in
//            switch isLoading {
//            case .true: self?.activity.startAnimating()
//            case .false: self?.activity.stopAnimating()
//            }
//        }
        viewModel.progress.subscribe(observer: self) { [weak self] progressValue in
            self?.progress.progress = Float(progressValue)
//            self?.progress.setProgress(progressValue, animated: true)
        }
    }
    
    
    // MARK: - UI -
    
    private lazy var progress: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.center = view.center
        progress.setProgress(0, animated: true)
        progress.trackTintColor = .black
        progress.tintColor = .red
        return progress
    }()
    
    
//    private lazy var activity: UIActivityIndicatorView = {
//        let indicator = UIActivityIndicatorView()
//        indicator.center = view.center
//        indicator.hidesWhenStopped = true
//        indicator.style = .large
//        indicator.color = .black
//        return indicator
//    }()

    deinit {
//        print("SplashViewController_CN is deinit -------- ")
    }
}
