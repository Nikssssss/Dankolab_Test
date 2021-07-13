//
//  LoadingView.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import UIKit
import SnapKit

class LoadingView: UIView {
    private let spinnerImageView = UIImageView()
    
    func configureView() {
        self.backgroundColor = .white
        self.addSubviews()
        self.configureSpinnerView()
    }
    
    func startAnimating() {
        self.startRotatingSpinner()
    }
}

private extension LoadingView {
    func addSubviews() {
        self.addSubview(self.spinnerImageView)
    }
    
    func configureSpinnerView() {
        self.spinnerImageView.image = UIImage(named: "spinner")
        self.spinnerImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(100)
        }
    }
    
    func startRotatingSpinner() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = 2
        rotateAnimation.repeatCount = .infinity
        self.spinnerImageView.layer.add(rotateAnimation, forKey: nil)
    }
}
