//
//  AddStrategy.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 14.07.2021.
//

import Foundation

final class AddPresentingStrategy: IPresentingStrategy {
    private let booksStorage: IBooksStorage
    private let navigator: INavigator
    
    init(booksStorage: IBooksStorage,
         navigator: INavigator) {
        self.booksStorage = booksStorage
        self.navigator = navigator
    }
    
    var bookViewModel: BookViewModel {
        let bookViewModel = BookViewModel(bookName: nil,
                                          deadlineDate: nil)
        return bookViewModel
    }
    
    var screenTitle: String {
        return NSLocalizedString(LocalizationConstants.addBook,
                                 comment: "")
    }
    
    var buttonTitle: String {
        return NSLocalizedString(LocalizationConstants.add,
                                 comment: "")
    }
    
    var buttonTapHandler: ((BookViewModel) -> Void) {
        let handler: ((BookViewModel) -> Void) = { [weak self] bookViewModel in
            guard let self = self,
                  let bookName = bookViewModel.bookName,
                  let deadlineDate = bookViewModel.deadlineDate,
                  bookName.isEmpty == false
            else { return }
            let addingBookDto = BookDto(name: bookName, deadlineDate: deadlineDate)
            let isAdded = self.booksStorage.addBook(addingBookDto)
            if isAdded {
                self.navigator.bookWasAdded()
            } else {
                let message = NSLocalizedString(LocalizationConstants.invalidNameError,
                                                comment: "")
                self.navigator.errorOcurred(with: message)
            }
        }
        return handler
    }
}
