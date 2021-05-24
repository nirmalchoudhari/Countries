//
//  ProvenanceTableViewCell.swift
//  Countries
//
//  Created by Nirmal Choudhari on 23/05/21.
//

import UIKit

/// UITableViewCell for Provenance
class ProvenanceTableViewCell: UITableViewCell, Identifiable, NibIdentifiable {

    static let identifier = "ProvenanceTableViewCell"
    
    @IBOutlet private var nameLabel: UILabel!
    
    /// Configure Cell based on the model object
    /// - Parameter item: Country Object
    func configure(_ item: Provenance?) {
        nameLabel.text = item?.name
    }
    
    static func nib() -> UINib {
        return UINib.init(nibName: ProvenanceTableViewCell.identifier, bundle: nil)
    }
    
}
