//
//  UIViewController+ActivityIndicator.swift
//  Countries
//
//  Created by Nirmal Choudhari on 23/05/21.
//

import UIKit

extension UIViewController {
    func showActivityIndicator() {
        view.isUserInteractionEnabled = false
        let allActivityIndicators = view.allSubViews(UIActivityIndicatorView.self)
        guard allActivityIndicators.isEmpty else {
            allActivityIndicators.first?.startAnimating()
            return
        }

        let activityIndicator: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .large)
        } else {
            activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        }
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .orange
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        view.isUserInteractionEnabled = true
        guard let activityIndicator = view.allSubViews(UIActivityIndicatorView.self).first else {
            return
        }
        activityIndicator.stopAnimating()
    }
    
}