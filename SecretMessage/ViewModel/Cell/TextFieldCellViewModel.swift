//
//  TextFieldCellViewModel.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol TextFieldCellViewModelDelegate: class {
    func textFieldCellViewModel(_ model: TextFieldCellViewModel, didKeyboardReturnsWith text: String)
}

final class TextFieldCellViewModel: NSObject, CellViewModelProtocol {
    
    let title: String
    let type: CellType = .textField
    let text: Observable<String>
    
    weak var delegate: TextFieldCellViewModelDelegate?
    
    init(title: String, information: String = "") {
        self.title = title
        self.text = Observable<String>(information)
    }
    
    func eventSelected() {
        delegate?.textFieldCellViewModel(self, didKeyboardReturnsWith: text.value)
    }
}
