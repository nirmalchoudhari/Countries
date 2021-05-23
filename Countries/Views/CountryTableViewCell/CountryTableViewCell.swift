//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Nirmal Choudhari on 23/05/21.
//

import UIKit
import SDWebImage

class CountryTableViewCell: UITableViewCell {
    
    static let identifier = "CountryTableViewCell"
    
    @IBOutlet private var flagImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ item: Country?) {
        nameLabel.text = item?.name
        //https://www.countryflags.io/be/flat/64.png
        guard let code = item?.code,
              let flagURL = URL(string: "https://www.countryflags.io/\(code)/flat/64.png") else { return }
        flagImageView.sd_setImage(with: flagURL, completed: nil)
    }
    
    static func nib() -> UINib {
        return UINib.init(nibName: CountryTableViewCell.identifier, bundle: nil)
    }
    
}
