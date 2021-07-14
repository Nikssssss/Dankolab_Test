//
//  IUpdateStrategy.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 14.07.2021.
//

import Foundation

protocol IPresentingStrategy: AnyObject {
    var bookViewModel: BookViewModel { get }
    var screenTitle: String { get }
    var buttonTitle: String { get }
    var buttonTapHandler: ((BookViewModel) -> Void) { get }
}
