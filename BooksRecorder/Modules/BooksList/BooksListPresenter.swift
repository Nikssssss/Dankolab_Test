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
    func viewWillAppear()
}

final class BooksListPresenter: IBooksListPresenter {
    private weak var booksListUI: IBooksListUI?
    private let booksStorage: IBooksStorage
    private let navigator: INavigator
    
    init(booksListUI: IBooksListUI,
         booksStorage: IBooksStorage,
         navigator: INavigator) {
        self.booksListUI = booksListUI
        self.booksStorage = booksStorage
        self.navigator = navigator
    }
    
    func loadView() {
        self.booksListUI?.replaceScreenView()
    }
    
    func viewDidLoad() {
        self.booksListUI?.configureUI()
        self.hookUI()
    }
    
    func viewWillAppear() {
        self.handleBooksLoading()
    }
}

private extension BooksListPresenter {
    func hookUI() {
        self.hookNumberOfRowsInSectionHandler()
        self.hookCellWillAppearHandler()
        self.hookTitleForHeaderInSectionHandler()
        self.hookCellWillDeleteHandler()
        self.hookAddBookButtonTapHandler()
        self.hookSortBooksButtonTapHandler()
        self.hookDidSelectRowHandler()
        self.hookNameSortActionHandler()
        self.hookDateSortActionHandler()
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
                self.renderCell(cell, at: indexPath,
                                using: self.booksStorage.overdueBooks,
                                withDateColor: Constants.overdueDateColor)
            case 1:
                self.renderCell(cell, at: indexPath,
                                using: self.booksStorage.validBooks,
                                withDateColor: Constants.validDateColor)
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
                if self.booksStorage.overdueBooks.count > 0 {
                    return NSLocalizedString(LocalizationConstants.overdueBooks,
                                             comment: "")
                }
                return ""
            case 1:
                if self.booksStorage.validBooks.count > 0 {
                    return NSLocalizedString(LocalizationConstants.validBooks,
                                             comment: "")
                }
                return ""
            default:
                return ""
            }
        })
    }
    
    func hookCellWillDeleteHandler() {
        self.booksListUI?.setCellWillDeleteHandler({ [weak self] indexPath in
            guard let self = self else { return }
            switch indexPath.section {
            case 0:
                self.booksStorage.removeOverdueBook(at: indexPath.row)
            case 1:
                self.booksStorage.removeValidBook(at: indexPath.row)
            default:
                break
            }
            self.handleBooksLoading()
        })
    }
    
    func hookAddBookButtonTapHandler() {
        self.booksListUI?.setAddBookButtonTapHandler({ [weak self] in
            self?.navigator.addButtonPressedAtBooksList()
        })
    }
    
    func hookSortBooksButtonTapHandler() {
        self.booksListUI?.setSortBooksButtonTapHandler({ [weak self] in
            self?.booksListUI?.showSortTypes()
        })
    }
    
    func hookDidSelectRowHandler() {
        self.booksListUI?.setDidSelectRowHandler({ [weak self] indexPath in
            guard let self = self else { return }
            switch indexPath.section {
            case 0:
                let bookDto = self.booksStorage.overdueBooks[indexPath.row]
                self.navigator.bookPressedAtBooksList(bookDto: bookDto)
            case 1:
                let bookDto = self.booksStorage.validBooks[indexPath.row]
                self.navigator.bookPressedAtBooksList(bookDto: bookDto)
            default:
                break
            }
        })
    }
    
    func hookNameSortActionHandler() {
        self.booksListUI?.setNameSortActionTapHandler({ [weak self] in
            guard let self = self else { return }
            self.booksStorage.setBooksSortingType(.name)
            self.handleBooksLoading()
        })
    }
    
    func hookDateSortActionHandler() {
        self.booksListUI?.setDateSortActionTapHandler({ [weak self] in
            guard let self = self else { return }
            self.booksStorage.setBooksSortingType(.date)
            self.handleBooksLoading()
        })
    }
    
    func renderCell(_ cell: IBooksListTableCell,
                    at indexPath: IndexPath,
                    using books: [BookDto],
                    withDateColor color: UIColor) {
        let book = books[indexPath.row]
        cell.setBookName(book.name)
        cell.setBookDate(self.mapDateToString(book.deadlineDate))
        cell.setBookDateColor(color)
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

private struct Constants {
    static let overdueDateColor = UIColor.red
    static let validDateColor = UIColor.gray
}
