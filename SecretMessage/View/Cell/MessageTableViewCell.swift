//
//  MessageTableViewCell.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class MessageTableViewCell: BaseTableViewCell {

    @IBOutlet var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setup() {
        super.setup()
        
        messageLabel.text = viewModel?.title
    }
    
}
