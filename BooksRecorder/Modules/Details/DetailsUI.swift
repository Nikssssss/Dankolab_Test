//
//  DetailsUI.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 14.07.2021.
//

import UIKit

protocol IDetailsUI: AnyObject {
    func replaceScreenView()
    func configureUI(bookViewModel: BookViewModel,
                     screenTitle: String,
                     buttonTitle: String,
                     buttonTapHandler: @escaping ((BookViewModel) -> Void))
    func setTextFieldTextDidChangeHandler(_ handler: ((String?) -> Void)?)
    func enableConfirmButton()
    func disableConfirmButton()
    func clearNameTextField()
}

class DetailsUI: UIViewController {
    private let detailsView = DetailsView()
    private var presenter: IDetailsPresenter?
    
    func setPresenter(_ presenter: IDetailsPresenter) {
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

extension DetailsUI: IDetailsUI {
    func replaceScreenView() {
        self.view = self.detailsView
    }
    
    func configureUI(bookViewModel: BookViewModel,
                     screenTitle: String,
                     buttonTitle: String,
                     buttonTapHandler: @escaping ((BookViewModel) -> Void)) {
        self.detailsView.configureView(bookViewModel: bookViewModel,
                                       buttonTitle: buttonTitle,
                                       buttonTapHandler: buttonTapHandler)
        self.configureNavigationBar(screenTitle: screenTitle)
        self.addHidingKeyboardTap()
    }
    
    func setTextFieldTextDidChangeHandler(_ handler: ((String?) -> Void)?) {
        self.detailsView.textFieldTextDidChange = handler
    }
    
    func enableConfirmButton() {
        self.detailsView.enableConfirmButton()
    }
    
    func disableConfirmButton() {
        self.detailsView.disableConfirmButton()
    }
    
    func clearNameTextField() {
        self.detailsView.clearNameTextField()
    }
}

private extension DetailsUI {
    func configureNavigationBar(screenTitle: String) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.backgroundColor = UIColor(red: 248 / 255.0,
                                                       green: 248 / 255.0,
                                                       blue: 248 / 255.0,
                                                       alpha: 1.0)
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationAppearance
        self.navigationItem.title = screenTitle
    }
    
    func addHidingKeyboardTap() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
