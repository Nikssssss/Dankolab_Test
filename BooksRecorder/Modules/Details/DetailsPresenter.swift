//
//  DetailsPresenter.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 14.07.2021.
//

import Foundation

protocol IDetailsPresenter: AnyObject {
    func loadView()
    func viewDidLoad()
}

final class DetailsPresenter: IDetailsPresenter {
    private weak var detailsUI: IDetailsUI?
    private let presentingStrategy: IPresentingStrategy
    private let booksStorage: IBooksStorage
    
    init(detailsUI: IDetailsUI,
         presentingStrategy: IPresentingStrategy,
         booksStorage: IBooksStorage) {
        self.detailsUI = detailsUI
        self.presentingStrategy = presentingStrategy
        self.booksStorage = booksStorage
    }
    
    func loadView() {
        self.detailsUI?.replaceScreenView()
    }
    
    func viewDidLoad() {
        let bookViewModel = self.presentingStrategy.bookViewModel
        let screenTitle = self.presentingStrategy.screenTitle
        let buttonTitle = self.presentingStrategy.buttonTitle
        let buttonTapHandler = self.presentingStrategy.buttonTapHandler
        self.detailsUI?.configureUI(bookViewModel: bookViewModel,
                                    screenTitle: screenTitle,
                                    buttonTitle: buttonTitle,
                                    buttonTapHandler: buttonTapHandler)
        self.handleConfirmButtonEnabling(byChecking: bookViewModel.bookName)
        self.hookUI()
    }
}

private extension DetailsPresenter {
    func hookUI() {
        self.detailsUI?.setTextFieldTextDidChangeHandler({ [weak self] text in
            self?.handleConfirmButtonEnabling(byChecking: text)
        })
    }
    
    func handleConfirmButtonEnabling(byChecking text: String?) {
        if let text = text,
           text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            self.detailsUI?.enableConfirmButton()
        } else {
            self.detailsUI?.disableConfirmButton()
            self.detailsUI?.clearNameTextField()
        }
    }
}
