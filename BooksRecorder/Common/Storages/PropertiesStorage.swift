//
//  PropertiesStorage.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import Foundation

protocol IPropertiesStorage: AnyObject {
    var launchedBefore: Bool? { get }
    func setFirstLaunch()
}

final class PropertiesStorage: IPropertiesStorage {
    var launchedBefore: Bool? {
        return self.userDefaults.value(forKey: Keys.launchedBefore) as? Bool
    }
    
    private enum Keys {
        static let launchedBefore = "launchedBefore"
    }
    
    private let userDefaults = UserDefaults.standard
    
    func setFirstLaunch() {
        self.userDefaults.set(true, forKey: Keys.launchedBefore)
    }
}
