//
//  EditStrategy.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 14.07.2021.
//

import Foundation

final class EditPresentingStrategy: IPresentingStrategy {
    private let bookDto: BookDto
    private let booksStorage: IBooksStorage
    private let navigator: INavigator
    
    init(bookDto: BookDto,
         booksStorage: IBooksStorage,
         navigator: INavigator) {
        self.bookDto = bookDto
        self.booksStorage = booksStorage
        self.navigator = navigator
    }
    
    var bookViewModel: BookViewModel {
        let bookViewModel = BookViewModel(bookName: self.bookDto.name,
                                          deadlineDate: self.bookDto.deadlineDate)
        return bookViewModel
    }
    
    var screenTitle: String {
        return "Edit info"
    }
    
    var buttonTitle: String {
        return "Edit"
    }
    
    var buttonTapHandler: ((BookViewModel) -> Void) {
        let handler: ((BookViewModel) -> Void) = { [weak self] bookViewModel in
            guard let self = self,
                  let bookName = bookViewModel.bookName,
                  let deadlineDate = bookViewModel.deadlineDate,
                  bookName.isEmpty == false
            else { return }
            let editedBookDto = BookDto(name: bookName, deadlineDate: deadlineDate)
            let isEdited = self.booksStorage.editBook(self.bookDto, using: editedBookDto)
            if isEdited {
                self.navigator.bookDidFinishEditing()
            } else {
                print("This book name already exists")
                //TODO: show alert about the same name
            }
        }
        return handler
    }
}
