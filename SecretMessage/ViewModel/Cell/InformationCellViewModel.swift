//
//  InformationCellViewModel.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class InformationCellViewModel: NSObject, CellViewModelProtocol {
    
    let title: String
    let type: CellType = .information
    let text: Observable<String>
    let suffix: String
    
    init(title: String, information: String = "", suffix: String = "") {
        self.title = title
        self.suffix = suffix
        self.text = Observable<String>(information + suffix)
    }
}
