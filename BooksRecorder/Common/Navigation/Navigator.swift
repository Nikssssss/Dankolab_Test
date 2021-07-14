//
//  Navigator.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import Foundation
import UIKit

protocol INavigator: AnyObject {
    func launch() -> ModuleNavigationItem?
    func launchDidFinish()
    func bookDidFinishEditing()
    func bookWasAdded()
    func addButtonPressedAtBooksList()
    func bookPressedAtBooksList(bookDto: BookDto)
}

final class Navigator: INavigator {    
    private let moduleNavigator = ModuleNavigator()
    
    func launch() -> ModuleNavigationItem? {
        guard let launchNavigationItem = LaunchAssembly.makeModule()
        else { return nil }
        return self.moduleNavigator.launch(with: launchNavigationItem)
    }
    
    func launchDidFinish() {
        guard let booksListNavigationItem = BooksListAssembly.makeModule()
        else { return }
        self.moduleNavigator.pushToMain(moduleNavigationItem: booksListNavigationItem)
    }
    
    func bookDidFinishEditing() {
        self.moduleNavigator.popFromMain()
    }
    
    func bookWasAdded() {
        self.moduleNavigator.popFromMain()
    }
    
    func addButtonPressedAtBooksList() {
        guard let detailsNavigationItem = DetailsAssembly.makeModule()
        else { return }
        self.moduleNavigator.pushToMain(moduleNavigationItem: detailsNavigationItem)
    }
    
    func bookPressedAtBooksList(bookDto: BookDto) {
        guard let detailsNavigationItem = DetailsAssembly.makeModule(bookDto: bookDto)
        else { return }
        self.moduleNavigator.pushToMain(moduleNavigationItem: detailsNavigationItem)
    }
}

private final class ModuleNavigator {
    private let mainNavigationController = UINavigationController()
    
    func launch(with moduleNavigationItem: ModuleNavigationItem) -> ModuleNavigationItem {
        let startViewController = moduleNavigationItem.viewController
        self.mainNavigationController.setViewControllers([startViewController], animated: true)
        let navigationItem = ModuleNavigationItem(viewController: self.mainNavigationController)
        return navigationItem
    }
    
    func pushToMain(moduleNavigationItem: ModuleNavigationItem) {
        self.mainNavigationController.pushViewController(moduleNavigationItem.viewController, animated: true)
    }
    
    func popFromMain() {
        self.mainNavigationController.popViewController(animated: true)
    }
    
    func presentOnMain(moduleNavigationItem: ModuleNavigationItem) {
        let viewController = moduleNavigationItem.viewController
        self.mainNavigationController.present(viewController, animated: true)
    }
}
