//
//  LaunchAssembly.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import Foundation

final class LaunchAssembly {
    static func makeModule() -> ModuleNavigationItem? {
        let container = DependencyContainer.shared.container
        guard let propertiesStorage = container.resolve(IPropertiesStorage.self),
              let navigator = container.resolve(INavigator.self)
        else { return nil }
        
        let launchUI = LaunchUI()
        
        let presenter = LaunchPresenter(launchUI: launchUI,
                                        propertiesStorage: propertiesStorage,
                                        navigator: navigator)
        launchUI.setPresenter(presenter: presenter)
        
        return ModuleNavigationItem(viewController: launchUI)
    }
}
