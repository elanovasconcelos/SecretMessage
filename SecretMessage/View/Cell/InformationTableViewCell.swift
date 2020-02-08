//
//  InformationTableViewCell.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class InformationTableViewCell: BaseTableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var informationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setup() {
        super.setup()
        
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
        informationLabel.text = viewModel.text.value
        
        viewModel.text.valueChanged = { [weak self] text in
            
            self?.informationLabel.text = text
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel?.text.valueChanged = nil
    }
}
