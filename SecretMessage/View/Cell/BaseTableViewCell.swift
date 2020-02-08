//
//  BaseTableViewCell.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell, BaseCellProtocol {

    var viewModel: CellViewModelProtocol? { didSet { setup() } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setup() {
        
    }
}
