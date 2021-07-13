//
//  LaunchAssembly.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import Foundation

final class LaunchAssembly {
    static func makeModule() -> ModuleNavigationItem? {
        guard let propertiesStorage = DependencyContainer.shared.container.resolve(IPropertiesStorage.self)
        else { return nil }
        
        let launchUI = LaunchUI()
        
        let presenter = LaunchPresenter(launchUI: launchUI, propertiesStorage: propertiesStorage)
        launchUI.setPresenter(presenter: presenter)
        
        return ModuleNavigationItem(viewController: launchUI)
    }
}
