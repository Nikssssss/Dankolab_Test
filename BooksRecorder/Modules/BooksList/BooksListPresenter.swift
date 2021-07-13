//
//  BooksListPresenter.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import Foundation

protocol IBooksListPresenter: AnyObject {
    func loadView()
    func viewDidLoad()
}

final class BooksListPresenter: IBooksListPresenter {
    private weak var booksListUI: IBooksListUI?
    
    init(booksListUI: IBooksListUI) {
        self.booksListUI = booksListUI
    }
    
    func loadView() {
        self.booksListUI?.replaceScreenView()
    }
    
    func viewDidLoad() {
        self.booksListUI?.configureUI()
    }
}
