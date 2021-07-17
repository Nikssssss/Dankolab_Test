//
//  LaunchPresenter.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import Foundation

protocol ILaunchPresenter: AnyObject {
    func loadView()
    func viewDidLoad()
}

final class LaunchPresenter: ILaunchPresenter {
    private weak var launchUI: ILaunchUI?
    private let propertiesStorage: IPropertiesStorage
    private let navigator: INavigator
    
    init(launchUI: ILaunchUI, propertiesStorage: IPropertiesStorage, navigator: INavigator) {
        self.launchUI = launchUI
        self.propertiesStorage = propertiesStorage
        self.navigator = navigator
    }
    
    func loadView() {
        self.launchUI?.setLoadingScreenView()
        self.replaceLoadingView()
    }
    
    func viewDidLoad() {
        self.launchUI?.configureUI()
    }
}

private extension LaunchPresenter {
    func replaceLoadingView() {
        if let launchedBefore = self.propertiesStorage.launchedBefore,
           launchedBefore == true {
            self.handleFinishingLaunch()
        } else {
            self.showStartView()
            self.propertiesStorage.setFirstLaunch()
        }
    }
    
    func handleFinishingLaunch() {
        let delay = Double.random(in: Constants.delayRange)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.navigator.launchDidFinish()
        }
    }
    
    func showStartView() {
        let delay = Double.random(in: Constants.delayRange)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            self.launchUI?.setStartScreenView()
            self.launchUI?.setStartButtonTapHandler { [weak self] in
                self?.navigator.launchDidFinish()
            }
        }
    }
}

private struct Constants {
    static let delayRange = 2.0...5.0
}
