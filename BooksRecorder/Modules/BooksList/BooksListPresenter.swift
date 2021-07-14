//
//  BooksListPresenter.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import Foundation
import class UIKit.UIColor

protocol IBooksListPresenter: AnyObject {
    func loadView()
    func viewDidLoad()
}

final class BooksListPresenter: IBooksListPresenter {
    private weak var booksListUI: IBooksListUI?
    private let booksStorage: IBooksStorage
    
    init(booksListUI: IBooksListUI, booksStorage: IBooksStorage) {
        self.booksListUI = booksListUI
        self.booksStorage = booksStorage
    }
    
    func loadView() {
        self.booksListUI?.replaceScreenView()
    }
    
    func viewDidLoad() {
        self.booksListUI?.configureUI()
        self.hookUI()
        self.handleBooksLoading()
    }
}

private extension BooksListPresenter {
    func hookUI() {
        self.hookNumberOfRowsInSectionHandler()
        self.hookCellWillAppearHandler()
        self.hookTitleForHeaderInSectionHandler()
    }
    
    func hookNumberOfRowsInSectionHandler() {
        self.booksListUI?.setNumberOfRowsInSectionHandler({ [weak self] section in
            guard let self = self else { return 0 }
            switch section {
            case 0:
                return self.booksStorage.overdueBooks.count
            case 1:
                return self.booksStorage.validBooks.count
            default:
                return 0
            }
        })
    }
    
    func hookCellWillAppearHandler() {
        self.booksListUI?.setCellWillAppearHandler({ [weak self] cell, indexPath in
            guard let self = self else { return }
            switch indexPath.section {
            case 0:
                let book = self.booksStorage.overdueBooks[indexPath.row]
                cell.setBookName(book.name)
                cell.setBookDate(self.mapDateToString(book.deadlineDate))
                cell.setBookDateColor(.red)
            case 1:
                let book = self.booksStorage.validBooks[indexPath.row]
                cell.setBookName(book.name)
                cell.setBookDate(self.mapDateToString(book.deadlineDate))
            default:
                break
            }
        })
    }
    
    func hookTitleForHeaderInSectionHandler() {
        self.booksListUI?.setTitleForHeaderInSectionHandler({ [weak self] section in
            guard let self = self else { return "" }
            switch section {
            case 0:
                return self.booksStorage.overdueBooks.count > 0 ? "Overdue books" : ""
            case 1:
                return self.booksStorage.validBooks.count > 0 ? "On time books" : ""
            default:
                return ""
            }
        })
    }
    
    func mapDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
    func handleBooksLoading() {
        self.booksStorage.loadBooks()
        self.booksListUI?.reloadData()
        if self.booksStorage.count == 0 {
            self.booksListUI?.enableEmptyListView()
        } else {
            self.booksListUI?.disableEmptyListView()
        }
    }
}
