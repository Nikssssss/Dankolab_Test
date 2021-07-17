//
//  DetailsView.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 14.07.2021.
//

import UIKit

class DetailsView: UIView {
    var textFieldTextDidChange: ((String?) -> Void)?
    
    private let bookNameTextField = UITextField()
    private let deadlineDatePicker = UIDatePicker()
    private let confirmButton = ActionButton()
    
    private var confirmButtonTapHandler: ((BookViewModel) -> Void)?
    
    func configureView(bookViewModel: BookViewModel,
                       buttonTitle: String,
                       buttonTapHandler: @escaping ((BookViewModel) -> Void)) {
        self.backgroundColor = Constants.viewBackgroundColor
        self.addSubviews()
        self.configureBookNameTextField(bookName: bookViewModel.bookName)
        self.configureDeadlineDatePicker(deadlineDate: bookViewModel.deadlineDate)
        self.configureConfirmButton(titled: buttonTitle)
        self.confirmButtonTapHandler = buttonTapHandler
    }
    
    func enableConfirmButton() {
        self.confirmButton.isEnabled = true
    }
    
    func disableConfirmButton() {
        self.confirmButton.isEnabled = false
    }
    
    func clearNameTextField() {
        self.bookNameTextField.text = ""
    }
}

extension DetailsView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.textFieldTextDidChange?(textField.text)
    }
}

private extension DetailsView {
    func addSubviews() {
        self.addSubview(self.bookNameTextField)
        self.addSubview(self.deadlineDatePicker)
        self.addSubview(self.confirmButton)
    }
    
    func configureBookNameTextField(bookName: String?) {
        self.bookNameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(45)
        }
        self.bookNameTextField.setLeftPaddingPoints(18)
        self.bookNameTextField.text = bookName
        self.bookNameTextField.layer.borderWidth = Constants.nameTextFieldBorderWidth
        self.bookNameTextField.layer.borderColor = Constants.nameTextFieldBorderColor
        self.bookNameTextField.layer.cornerRadius = Constants.nameTextFieldCornerRadius
        self.bookNameTextField.delegate = self
        self.bookNameTextField.autocorrectionType = .no
        self.bookNameTextField.autocapitalizationType = .none
        self.bookNameTextField.backgroundColor = Constants.nameTextFieldBackgroundColor
        let placeholderText = NSLocalizedString(LocalizationConstants.bookName,
                                                comment: "")
        let attributes: [NSAttributedString.Key : Any] = [.foregroundColor: Constants.nameTextFieldPlaceholderColor]
        let attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                       attributes: attributes)
        self.bookNameTextField.attributedPlaceholder = attributedPlaceholder
        self.bookNameTextField.textColor = Constants.nameTextFieldTextColor
    }
    
    func configureDeadlineDatePicker(deadlineDate: Date?) {
        self.deadlineDatePicker.snp.makeConstraints { make in
            make.top.equalTo(self.bookNameTextField.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        self.deadlineDatePicker.datePickerMode = .date
        self.deadlineDatePicker.preferredDatePickerStyle = .wheels
        let currentDate = Date()
        let threeMonthsAgoDate = Calendar.current.date(byAdding: .month,
                                                      value: 3,
                                                      to: currentDate)
        self.deadlineDatePicker.minimumDate = currentDate
        self.deadlineDatePicker.maximumDate = threeMonthsAgoDate
        if let deadlineDate = deadlineDate {
            self.deadlineDatePicker.setDate(deadlineDate, animated: true)
        }
    }
    
    func configureConfirmButton(titled title: String) {
        self.makeConfirmButtonConstraints(bottomOffset: Constants.buttonBottomOffset)
        self.confirmButton.setTitle(title, for: .normal)
        self.confirmButton.addTarget(self,
                                   action: #selector(self.confirmButtonPressed),
                                   for: .touchUpInside)
        self.moveConfirmButtonWhenKeyboardShows()
    }
    
    func makeConfirmButtonConstraints(bottomOffset: CGFloat) {
        self.confirmButton.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().offset(bottomOffset)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(Constants.buttonHeight)
        }
    }
    
    func moveConfirmButtonWhenKeyboardShows() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                                as? NSValue)?.cgRectValue {
            let buttonY = self.frame.height + Constants.buttonBottomOffset - Constants.buttonHeight
            if self.confirmButton.frame.origin.y == buttonY {
                let raiseOffset = Constants.buttonHeight / 2
                self.confirmButton.frame.origin.y -= (keyboardSize.height - raiseOffset)
                let buttonBottom = Constants.buttonBottomOffset - (keyboardSize.height - raiseOffset)
                self.makeConfirmButtonConstraints(bottomOffset: buttonBottom)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                                as? NSValue)?.cgRectValue {
            let raiseOffset = Constants.buttonHeight / 2
            let yOffset = keyboardSize.height + (Constants.buttonHeight - Constants.buttonBottomOffset - raiseOffset)
            let buttonY = self.frame.height - yOffset
            if self.confirmButton.frame.origin.y == buttonY {
                self.confirmButton.frame.origin.y += (keyboardSize.height - raiseOffset)
                self.makeConfirmButtonConstraints(bottomOffset: Constants.buttonBottomOffset)
            }
        }
    }
    
    @objc func confirmButtonPressed() {
        let bookViewModel = BookViewModel(bookName: self.bookNameTextField.text,
                                          deadlineDate: self.deadlineDatePicker.date)
        self.confirmButtonTapHandler?(bookViewModel)
    }
}

private struct Constants {
    static let viewBackgroundColor = UIColor.white
    static let nameTextFieldBorderWidth: CGFloat = 0.5
    static let nameTextFieldBorderColor = UIColor.lightGray.cgColor
    static let nameTextFieldCornerRadius: CGFloat = 10
    static let nameTextFieldPlaceholderColor = UIColor.lightGray
    static let nameTextFieldTextColor = UIColor.black
    static let nameTextFieldBackgroundColor = UIColor.white
    static let buttonBottomOffset: CGFloat = -50
    static let buttonHeight: CGFloat = 50.0
}
