//
//  ImageTableViewCell.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class ImageTableViewCell: BaseTableViewCell {

    @IBOutlet var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setup() {
        cellImageView.image = nil
        bind()
    }
    
    private func bind() {
        viewModel?.image.valueChanged = { [weak self] (image) in
            self?.cellImageView.image = image
        }
    }
}
