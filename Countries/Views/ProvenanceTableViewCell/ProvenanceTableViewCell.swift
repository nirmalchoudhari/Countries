//
//  ProvenanceTableViewCell.swift
//  Countries
//
//  Created by Nirmal Choudhari on 23/05/21.
//

import UIKit

class ProvenanceTableViewCell: UITableViewCell, Identifiable {

    static let identifier = "ProvenanceTableViewCell"
    
    @IBOutlet private var nameLabel: UILabel!
    
    func configure(_ item: Provenance?) {
        nameLabel.text = item?.name
    }
    
    static func nib() -> UINib {
        return UINib.init(nibName: ProvenanceTableViewCell.identifier, bundle: nil)
    }
    
}
