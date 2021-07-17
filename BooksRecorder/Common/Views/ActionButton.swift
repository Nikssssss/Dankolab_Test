//
//  ActionButton.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 14.07.2021.
//

import UIKit

class ActionButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override var isEnabled: Bool {
        didSet {
            if self.isEnabled {
                self.backgroundColor = Constants.enabledBackgroundColor
                self.enableShadows()
            } else {
                self.backgroundColor = Constants.disabledBackgroundColor
                self.disableShadows()
            }
        }
    }
    
    private func configureView() {
        self.setTitleColor(Constants.titleColor, for: .normal)
        self.titleLabel?.font = Constants.titleFont
        self.layer.cornerRadius = Constants.cornerRadius
        self.isEnabled = true
    }
    
    private func enableShadows() {
        self.layer.shadowColor = Constants.shadowColor
        self.layer.shadowOffset = Constants.shadowOffset
        self.layer.shadowRadius = Constants.shadowRadius
        self.layer.shadowOpacity = Constants.shadowOpacity
    }
    
    private func disableShadows() {
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 0
    }
}

private struct Constants {
    static let enabledBackgroundColor = UIColor(red: 7 / 255.0,
                                         green: 123 / 255.0,
                                         blue: 249 / 255.0,
                                         alpha: 1.0)
    static let disabledBackgroundColor = UIColor(red: 201 / 255.0,
                                          green: 201 / 255.0,
                                          blue: 204 / 255.0,
                                          alpha: 1.0)
    static let titleColor = UIColor.white
    static let titleFont = UIFont.systemFont(ofSize: 16, weight: .bold)
    static let cornerRadius: CGFloat = 10
    
    static let shadowColor = UIColor.darkGray.cgColor
    static let shadowOffset = CGSize(width: 1, height: 2)
    static let shadowRadius: CGFloat = 3
    static let shadowOpacity: Float = 1
}
