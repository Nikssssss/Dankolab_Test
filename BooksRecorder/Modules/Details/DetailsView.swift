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
        self.backgroundColor = .white
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
        self.bookNameTextField.placeholder = "Book name"
        self.bookNameTextField.text = bookName
        self.bookNameTextField.layer.borderWidth = 0.5
        self.bookNameTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.bookNameTextField.layer.cornerRadius = 10
        self.bookNameTextField.delegate = self
        self.bookNameTextField.autocorrectionType = .no
        self.bookNameTextField.autocapitalizationType = .none
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
        self.confirmButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        self.confirmButton.setTitle(title, for: .normal)
        self.confirmButton.addTarget(self,
                                   action: #selector(self.confirmButtonPressed),
                                   for: .touchUpInside)
    }
    
    @objc func confirmButtonPressed() {
        let bookViewModel = BookViewModel(bookName: self.bookNameTextField.text,
                                          deadlineDate: self.deadlineDatePicker.date)
        self.confirmButtonTapHandler?(bookViewModel)
    }
}
