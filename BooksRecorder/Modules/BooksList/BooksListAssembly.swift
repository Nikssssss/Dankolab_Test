//
//  BooksListAssembly.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import Foundation

final class BooksListAssembly {
    static func makeModule() -> ModuleNavigationItem? {
        guard let booksStorage = DependencyContainer.shared.container.resolve(IBooksStorage.self)
        else { return nil }
        
        let booksListUI = BooksListUI()
        
        let presenter = BooksListPresenter(booksListUI: booksListUI, booksStorage: booksStorage)
        booksListUI.setPresenter(presenter)
        
        return ModuleNavigationItem(viewController: booksListUI)
    }
}
