//
//  ButtonCellViewModel.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol ButtonCellViewModelDelegate: class {
    func buttonCellViewModelDidSelect(_ model: ButtonCellViewModel)
}

final class ButtonCellViewModel: NSObject, CellViewModelProtocol {
    
    let title: String
    let type: CellType = .button
    let buttonType: ButtonType
    
    weak var delegate: ButtonCellViewModelDelegate?
    
    init(title: String, delegate: ButtonCellViewModelDelegate? = nil, buttonType: ButtonType = .sign) {
        self.title = title
        self.delegate = delegate
        self.buttonType = buttonType
    }
    
    func eventSelected() {
        delegate?.buttonCellViewModelDidSelect(self)
    }
}

//MARK: - 
enum ButtonType {
    case sign
    case verify
}
