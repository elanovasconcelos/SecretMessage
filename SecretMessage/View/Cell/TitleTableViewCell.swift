//
//  TitleTableViewCell.swift
//  SecretMessage
//
//  Created by Elano on 07/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class TitleTableViewCell: BaseTableViewCell {

    @IBOutlet var titleLabel: UILabel! //TODO: create BaseLabel
    
    //MARK: -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setup() {
        
        super.setup()
        
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
    }
    
    
}
