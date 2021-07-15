//
//  DependencyContainer.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import Foundation
import Swinject

final class DependencyContainer {
    static var shared: DependencyContainer = {
        let dependencyContainer = DependencyContainer()
        return dependencyContainer
    }()
    
    let container = Container()
    
    private init() {
        self.registerDependencies()
    }
    
    private func registerDependencies() {        
        self.container.register(INavigator.self) { _ in
            return Navigator()
        }.inObjectScope(.container)
        
        self.container.register(IPropertiesStorage.self) { _ in
            return PropertiesStorage()
        }
        
        self.container.register(IBooksStorage.self) { _ in
            return BooksStorage(booksSortingType: .none)
        }.inObjectScope(.container)
    }
}
