//
//  TextFieldCellViewModel.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class TextFieldCellViewModel: NSObject, CellViewModelProtocol {
    
    let title: String
    let type: CellType = .textField
    let text: Observable<String>
    
    init(title: String, information: String = "") {
        self.title = title
        self.text = Observable<String>(information)
    }
}
