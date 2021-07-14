//
//  DetailsAssembly.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 14.07.2021.
//

import Foundation

final class DetailsAssembly {
    static func makeModule(bookDto: BookDto) -> ModuleNavigationItem? {
        let container = DependencyContainer.shared.container
        guard let booksStorage = container.resolve(IBooksStorage.self),
              let navigator = container.resolve(INavigator.self)
        else { return nil }
        
        let detailsUI = DetailsUI()
        
        let presentingStrategy = EditPresentingStrategy(bookDto: bookDto,
                                                        booksStorage: booksStorage,
                                                        navigator: navigator)
        let presenter = DetailsPresenter(detailsUI: detailsUI,
                                         presentingStrategy: presentingStrategy,
                                         booksStorage: booksStorage)
        detailsUI.setPresenter(presenter)
        
        return ModuleNavigationItem(viewController: detailsUI)
    }
    
    static func makeModule() -> ModuleNavigationItem? {
        let container = DependencyContainer.shared.container
        guard let booksStorage = container.resolve(IBooksStorage.self),
              let navigator = container.resolve(INavigator.self)
        else { return nil }
        
        let detailsUI = DetailsUI()
        
        let presentingStrategy = AddPresentingStrategy(booksStorage: booksStorage,
                                                       navigator: navigator)
        let presenter = DetailsPresenter(detailsUI: detailsUI,
                                         presentingStrategy: presentingStrategy,
                                         booksStorage: booksStorage)
        detailsUI.setPresenter(presenter)
        
        return ModuleNavigationItem(viewController: detailsUI)
    }
}
