//
//  BooksListAssembly.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import Foundation

final class BooksListAssembly {
    static func makeModule() -> ModuleNavigationItem? {
        let container = DependencyContainer.shared.container
        guard let booksStorage = container.resolve(IBooksStorage.self),
              let navigator = container.resolve(INavigator.self)
        else { return nil }
        
        let booksListUI = BooksListUI()
        
        let presenter = BooksListPresenter(booksListUI: booksListUI,
                                           booksStorage: booksStorage,
                                           navigator: navigator)
        booksListUI.setPresenter(presenter)
        
        return ModuleNavigationItem(viewController: booksListUI)
    }
}
