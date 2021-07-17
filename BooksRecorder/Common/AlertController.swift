//
//  AlertController.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 17.07.2021.
//

import Foundation
import SwiftMessages

protocol IAlertController: AnyObject {
    func showErrorAlert(message: String)
}

final class AlertController: IAlertController {
    func showErrorAlert(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let config = self.createErrorConfig()
            let view = self.createErrorView(message: message)
            SwiftMessages.show(config: config, view: view)
        }
    }
}

private extension AlertController {
    func createErrorConfig() -> SwiftMessages.Config {
        var config = SwiftMessages.Config()
        config.presentationStyle = .center
        config.presentationContext = .window(windowLevel: .alert)
        config.duration = .forever
        config.dimMode = .gray(interactive: true)
        return config
    }
    
    func createErrorView(message: String) -> MessageView {
        let title = NSLocalizedString(LocalizationConstants.error,
                                      comment: "")
        let buttonTitle = NSLocalizedString(LocalizationConstants.okay,
                                            comment: "")
        let view = MessageView.viewFromNib(layout: .centeredView)
        view.configureTheme(backgroundColor: .white, foregroundColor: .darkGray)
        view.configureDropShadow()
        view.tapHandler = { _ in SwiftMessages.hide() }
        view.buttonTapHandler = { _ in SwiftMessages.hide() }
        view.button?.setTitle(buttonTitle, for: .normal)
        view.button?.setTitleColor(.link, for: .normal)
        view.button?.backgroundColor = .white
        view.configureBackgroundView(width: 250)
        view.configureContent(title: title, body: message)
        return view
    }
}
