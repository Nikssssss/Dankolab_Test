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
    func setNumberOfRowsInSectionHandler(_ handler: ((Int) -> Int)?)
    func setCellWillAppearHandler(_ handler: ((IBooksListTableCell, IndexPath) -> Void)?)
    func setTitleForHeaderInSectionHandler(_ handler: ((Int) -> String)?)
    func setCellWillDeleteHandler(_ handler: ((IndexPath) -> Void)?)
    func setAddBookButtonTapHandler(_ handler: (() -> Void)?)
    func setSortBooksButtonTapHandler(_ handler: (() -> Void)?)
    func setDidSelectRowHandler(_ handler: ((IndexPath) -> Void)?)
    func reloadData()
    func enableEmptyListView()
    func disableEmptyListView()
}

class BooksListUI: UIViewController {
    private let booksListView = BooksListView()
    private var presenter: IBooksListPresenter?
    
    private var addBookButtonTapHandler: (() -> Void)?
    private var sortBooksButtonTapHandler: (() -> Void)?
    
    func setPresenter(_ presenter: IBooksListPresenter) {
        self.presenter = presenter
    }
    
    override func loadView() {
        super.loadView()
        
        self.presenter?.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter?.viewWillAppear()
    }
}

extension BooksListUI: IBooksListUI {
    func replaceScreenView() {
        self.view = self.booksListView
    }
    
    func configureUI() {
        self.booksListView.configureView()
        self.configureNavigationBar()
    }
    
    func setNumberOfRowsInSectionHandler(_ handler: ((Int) -> Int)?) {
        self.booksListView.numberOfRowsInSection = handler
    }
    
    func setCellWillAppearHandler(_ handler: ((IBooksListTableCell, IndexPath) -> Void)?) {
        self.booksListView.cellWillAppear = handler
    }
    
    func setTitleForHeaderInSectionHandler(_ handler: ((Int) -> String)?) {
        self.booksListView.titleForHeaderInSection = handler
    }
    
    func setCellWillDeleteHandler(_ handler: ((IndexPath) -> Void)?) {
        self.booksListView.cellWillDelete = handler
    }
    
    func setAddBookButtonTapHandler(_ handler: (() -> Void)?) {
        self.addBookButtonTapHandler = handler
    }
    
    func setSortBooksButtonTapHandler(_ handler: (() -> Void)?) {
        self.sortBooksButtonTapHandler = handler
    }
    
    func setDidSelectRowHandler(_ handler: ((IndexPath) -> Void)?) {
        self.booksListView.didSelectRow = handler
    }
    
    func reloadData() {
        self.booksListView.reloadData()
    }
    
    func enableEmptyListView() {
        self.booksListView.enableEmptyListView()
    }
    
    func disableEmptyListView() {
        self.booksListView.disableEmptyListView()
    }
}

private extension BooksListUI {
    func configureNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.backgroundColor = UIColor(red: 248 / 255.0,
                                                       green: 248 / 255.0,
                                                       blue: 248 / 255.0,
                                                       alpha: 1.0)
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationAppearance
        self.navigationItem.title = "Books list"
        self.configureAddingBookBarButton()
        self.configureSortingBooksButton()
    }
    
    func configureAddingBookBarButton() {
        let addBookButton = UIBarButtonItem()
        addBookButton.image = UIImage(systemName: "plus")
        addBookButton.target = self
        addBookButton.action = #selector(self.addBookButtonPressed)
        self.navigationItem.rightBarButtonItem = addBookButton
    }
    
    func configureSortingBooksButton() {
        let sortBooksButton = UIBarButtonItem()
        sortBooksButton.image = UIImage(named: "sort")
        sortBooksButton.target = self
        sortBooksButton.action = #selector(self.sortBooksButtonPressed)
        self.navigationItem.leftBarButtonItem = sortBooksButton
    }
    
    @objc func addBookButtonPressed() {
        self.addBookButtonTapHandler?()
    }
    
    @objc func sortBooksButtonPressed() {
        self.sortBooksButtonTapHandler?()
    }
}
