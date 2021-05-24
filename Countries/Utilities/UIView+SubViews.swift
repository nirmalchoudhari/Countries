//
//  UIView+SubViews.swift
//  Countries
//
//  Created by Nirmal Choudhari on 23/05/21.
//

import UIKit

extension UIView {
    
    /// Finds all subview of  given type in view
    /// - Parameter type: type of subview to find
    /// - Returns: a list of subviews matching given type
    func allSubViews<T: UIView>(_ type: T.Type) -> [T] {
        var allSubviews = [T]()
        func getSubViews(view: UIView) {
            if let view = view as? T {
                allSubviews.append(view)
            }
            guard !view.subviews.isEmpty else { return }
            view.subviews.forEach{ getSubViews(view: $0) }
        }
        getSubViews(view: self)
        return allSubviews
    }
}

