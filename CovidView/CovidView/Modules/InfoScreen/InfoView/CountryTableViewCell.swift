//
//  CountryTableViewCell.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/24/21.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupCell(with model: CountryModel) {
        countryLabel.text = model.name
    }
}
