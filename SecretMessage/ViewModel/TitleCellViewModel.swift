//
//  TitleCellViewModel.swift
//  SecretMessage
//
//  Created by Elano on 07/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

class TitleCellViewModel: NSObject, CellViewModelProtocol {

    let title: String
    let type: CellType = .title
    
    init(title: String) {
        self.title = title
    }
}
