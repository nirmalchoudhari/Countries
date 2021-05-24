//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Nirmal Choudhari on 23/05/21.
//

import UIKit
import SDWebImage

/// Protocol which helps UITableviewCell to be identified using identifier
protocol Identifiable {
    static var identifier: String {get}
}

/// Protocol which helps UITableviewCell to be identified using Nib
protocol NibIdentifiable {
    static func nib() -> UINib
}

/// UITableViewCell for displaying Country
class CountryTableViewCell: UITableViewCell, Identifiable, NibIdentifiable {
    
    static let identifier = "CountryTableViewCell"
    
    @IBOutlet private var flagImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    
    /// Configure Cell based on the model object
    /// - Parameter item: Country Object
    func configure(_ item: Country?) {
        nameLabel.text = item?.name
        guard let code = item?.code,
              let flagURL = URL(string: RequestType.flag(code).urlString ) else { return }
        flagImageView.sd_setImage(with: flagURL, completed: nil)
    }
    
    static func nib() -> UINib {
        return UINib.init(nibName: CountryTableViewCell.identifier, bundle: nil)
    }
    
}
