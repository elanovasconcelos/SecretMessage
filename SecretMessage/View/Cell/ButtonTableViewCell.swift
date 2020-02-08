//
//  ButtonTableViewCell.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class ButtonTableViewCell: BaseTableViewCell {

    @IBOutlet var button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setup() {
        button.setTitle(viewModel?.title, for: .normal)
    }
    
    @IBAction func selectButton(_ sender: Any) {
        (viewModel as? ButtonCellViewModel)?.buttonSelected()
    }
    
    
}
