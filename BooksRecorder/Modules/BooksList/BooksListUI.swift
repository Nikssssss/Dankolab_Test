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
    func setNameSortActionTapHandler(_ handler: (() -> Void)?)
    func setDateSortActionTapHandler(_ handler: (() -> Void)?)
    func reloadData()
    func enableEmptyListView()
    func disableEmptyListView()
    func showSortTypes()
}

class BooksListUI: UIViewController {
    private let booksListView = BooksListView()
    private var presenter: IBooksListPresenter?
    
    private var addBookButtonTapHandler: (() -> Void)?
    private var sortBooksButtonTapHandler: (() -> Void)?
    private var nameSortActionTapHandler: (() -> Void)?
    private var dateSortActionTapHandler: (() -> Void)?
    
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
    
    func setNameSortActionTapHandler(_ handler: (() -> Void)?) {
        self.nameSortActionTapHandler = handler
    }
    
    func setDateSortActionTapHandler(_ handler: (() -> Void)?) {
        self.dateSortActionTapHandler = handler
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
    
    func showSortTypes() {
        self.showSortActionSheet()
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
        self.navigationItem.title = NSLocalizedString("Books list", comment: "")
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
    
    func showSortActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let nameSortAction = UIAlertAction(title: NSLocalizedString("Sort by name", comment: ""),
                                           style: .default) { _ in
            self.nameSortActionTapHandler?()
        }
        let dateSortAction = UIAlertAction(title: NSLocalizedString("Sort by date", comment: ""),
                                           style: .default) { _ in
            self.dateSortActionTapHandler?()
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""),
                                         style: .cancel,
                                         handler: nil)
        actionSheet.addAction(nameSortAction)
        actionSheet.addAction(dateSortAction)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true)
    }
    
    @objc func addBookButtonPressed() {
        self.addBookButtonTapHandler?()
    }
    
    @objc func sortBooksButtonPressed() {
        self.sortBooksButtonTapHandler?()
    }
}
