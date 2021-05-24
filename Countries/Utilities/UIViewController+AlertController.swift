//
//  UIViewController+AlertController.swift
//  Countries
//
//  Created by Nirmal Choudhari on 24/05/21.
//

import UIKit

/// Config which represent details required for Alert
struct AlertConfig {
    var title: String = "Countries App"
    var message: String
    var actions: [String]
    var showCancel: Bool = true
}

extension UIViewController {
    
    /// Shows an alert with given message and retry button
    /// - Parameters:
    ///   - message: message to dispaly as an alert
    ///   - completion: completion for the alert action handler
    func showRetryAlert(message: ErrorDescription, completion: @escaping ()-> Void) {
        showAlertController(alertConfig: AlertConfig(message: message, actions: ["Retry"])) {_ in
            completion()
        }
    }
    // Shows an alert with given alertConfig
    /// - Parameters:
    ///   - alertConfig: config for an alert
    ///   - completion: completion for the alert action handler
    func showAlertController(alertConfig: AlertConfig, handler: @escaping (ActionIdentifier) -> Void) {
        let alertController = UIAlertController(title: alertConfig.title, message: alertConfig.message, preferredStyle: .alert)
        if alertConfig.showCancel {
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in }))
        }
        for action in alertConfig.actions {
            let alertAction = UIAlertAction(title: action, style: .default) { result in
                handler(result.title ?? "Cancel")
            }
            alertController.addAction(alertAction)
        }
        present(alertController, animated: true, completion: {})
    }
}
