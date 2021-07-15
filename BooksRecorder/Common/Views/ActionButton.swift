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
                self.backgroundColor = UIColor(red: 7 / 255.0,
                                               green: 123 / 255.0,
                                               blue: 249 / 255.0,
                                               alpha: 1.0)
                self.enableShadows()
            } else {
                self.backgroundColor = UIColor(red: 201 / 255.0,
                                               green: 201 / 255.0,
                                               blue: 204 / 255.0,
                                               alpha: 1.0)
                self.disableShadows()
            }
        }
    }
    
    private func configureView() {
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        self.layer.cornerRadius = 10
    }
    
    private func enableShadows() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 1
    }
    
    private func disableShadows() {
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 0
    }
}
