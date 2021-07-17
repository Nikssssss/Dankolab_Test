//
//  StartView.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import UIKit

class StartView: UIView {
    var startButtonTapHandler: (() -> Void)?
    
    private let containerView = UIStackView()
    private let titleView = UIImageView()
    private let bookImageView = UIImageView()
    private let startButton = ActionButton()
    
    func configureView() {
        self.backgroundColor = Constants.viewBackgroundColor
        self.addSubviews()
        self.configureContainerView()
        self.configureTitleView()
        self.configureBookImageView()
        self.configureStartButton()
    }
    
    func showViewsWithAnimation() {
        UIView.animateKeyframes(withDuration: 2.1,
                                delay: 0,
                                options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.33) {
                self.titleView.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.33) {
                self.bookImageView.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 0.66, relativeDuration: 0.33) {
                self.startButton.alpha = 1
            }
        }
    }
}

private extension StartView {
    func addSubviews() {
        self.addSubview(self.containerView)
        self.addSubview(self.startButton)
    }
    
    func configureContainerView() {
        self.containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
        }
        self.containerView.axis = .vertical
        self.containerView.alignment = .center
        self.containerView.distribution = .equalSpacing
        self.containerView.spacing = Constants.containerInteritemSpacing
        self.containerView.addArrangedSubview(self.titleView)
        self.containerView.addArrangedSubview(self.bookImageView)
    }
    
    func configureTitleView() {
        self.titleView.image = UIImage(named: "titleImage")
        self.titleView.alpha = 0
    }
    
    func configureBookImageView() {
        self.bookImageView.image = UIImage(named: "bookImage")
        self.bookImageView.alpha = 0
    }
    
    func configureStartButton() {
        self.startButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        self.startButton.setTitle(NSLocalizedString(LocalizationConstants.start,
                                                    comment: ""), for: .normal)
        self.startButton.addTarget(self,
                                   action: #selector(self.startButtonPressed),
                                   for: .touchUpInside)
        self.startButton.alpha = 0
    }
    
    @objc func startButtonPressed() {
        self.startButtonTapHandler?()
    }
}

private struct Constants {
    static let viewBackgroundColor = UIColor.white
    static let containerInteritemSpacing: CGFloat = 44
}
