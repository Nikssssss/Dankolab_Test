//
//  BooksListUI.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import UIKit

protocol IBooksListUI: AnyObject {
    func replaceScreenView()
    func configureUI()
}

class BooksListUI: UIViewController {
    private let booksListView = BooksListView()
    private var presenter: IBooksListPresenter?
    
    override func loadView() {
        super.loadView()
        
        self.presenter?.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
    }
}

extension BooksListUI: IBooksListUI {
    func replaceScreenView() {
        self.view = self.booksListView
    }
    
    func configureUI() {
        
    }
}
