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
    
    init(launchUI: ILaunchUI, propertiesStorage: IPropertiesStorage) {
        self.launchUI = launchUI
        self.propertiesStorage = propertiesStorage
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
        let delay = Double.random(in: 2...5)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            print("navigator.launchDidFinish")
        }
    }
    
    func showStartView() {
        let delay = Double.random(in: 2...5)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.launchUI?.setStartScreenView()
            self.launchUI?.setStartButtonTapHandler {
                print("navigator.launchDidFinish")
            }
        }
    }
}
