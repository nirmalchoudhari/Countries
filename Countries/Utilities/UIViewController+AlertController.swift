//
//  UIViewController+AlertController.swift
//  Countries
//
//  Created by Nirmal Choudhari on 24/05/21.
//

import UIKit

struct AlertConfig {
    var title: String = "Countries App"
    var message: String
    var actions: [String]
    var showCancel: Bool = true
}

extension UIViewController {
    
    func showRetryAlert(message: ErrorDescription, completion: @escaping ()-> Void) {
        showAlertController(alertConfig: AlertConfig(message: message, actions: ["Retry"])) {_ in
            completion()
        }
                                  
    }
    
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
