//
//  TitleTableViewCell.swift
//  SecretMessage
//
//  Created by Elano on 07/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

//TODO: create BaseTableViewCell
class TitleTableViewCell: UITableViewCell, BaseCellProtocol {

    static let identifier = "TitleTableViewCell"
    
    @IBOutlet var titleLabel: UILabel! //TODO: create BaseLabel
    
    var viewModel: CellViewModelProtocol? { didSet { setup() } }
    
    //MARK: -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup() {
        
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
    }
    
    
}
