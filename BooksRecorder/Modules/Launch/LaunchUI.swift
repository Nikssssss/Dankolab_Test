//
//  LaunchUI.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import UIKit

protocol ILaunchUI: AnyObject {
    func setLoadingScreenView()
    func setStartScreenView()
    func configureUI()
    func setStartButtonTapHandler(_ handler: @escaping (() -> Void))
}

class LaunchUI: UIViewController {
    private var loadingView: LoadingView?
    private var startView: StartView?
    private var presenter: ILaunchPresenter?
    
    func setPresenter(presenter: ILaunchPresenter) {
        self.presenter = presenter
    }
    
    override func loadView() {
        super.loadView()
        
        self.presenter?.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter?.viewDidLoad()
    }
}

extension LaunchUI: ILaunchUI {
    func setLoadingScreenView() {
        let loadingView = LoadingView()
        self.loadingView = loadingView
        self.view = loadingView
    }
    
    func setStartScreenView() {
        let startView = StartView()
        self.startView = startView
        startView.configureView()
        self.view = startView
        startView.showViewsWithAnimation()
    }
    
    func configureUI() {
        self.loadingView?.configureView()
        self.loadingView?.startAnimating()
        self.configureNavigationBar()
    }
    
    func setStartButtonTapHandler(_ handler: @escaping (() -> Void)) {
        self.startView?.startButtonTapHandler = handler
    }
}

private extension LaunchUI {
    func configureNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
