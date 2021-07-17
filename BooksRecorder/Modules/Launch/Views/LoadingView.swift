//
//  LoadingView.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import UIKit
import SnapKit

class LoadingView: UIView {
    private let spinnerView = SpinnerView()
    
    func configureView() {
        self.backgroundColor = Constants.viewBackgroundColor
        self.addSubviews()
        self.configureSpinnerView()
    }
    
    func startAnimating() {
        self.spinnerView.startAnimating()
    }
}

private extension LoadingView {
    func addSubviews() {
        self.addSubview(self.spinnerView)
    }
    
    func configureSpinnerView() {
        self.spinnerView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
}

private struct Constants {
    static let viewBackgroundColor = UIColor.white
}
