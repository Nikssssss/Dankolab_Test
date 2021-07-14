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
    func reloadData()
    func enableEmptyListView()
    func disableEmptyListView()
}

class BooksListUI: UIViewController {
    private let booksListView = BooksListView()
    private var presenter: IBooksListPresenter?
    
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
        navigationAppearance.backgroundColor = .white
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationAppearance
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.title = "Books list"
    }
}
