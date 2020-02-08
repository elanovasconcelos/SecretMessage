//
//  CellViewModelProtocol.swift
//  SecretMessage
//
//  Created by Elano on 07/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol CellViewModelProtocol {
    var title: String { get }
    var type: CellType { get }
    var subTitle: String { get }
}

extension CellViewModelProtocol {
    var subTitle: String { return "" }
}

//MARK: -
enum CellType: String {
    case title
    
    var identifier: String {
        
        switch self {
        case .title: return TitleTableViewCell.identifier
        }
    }
}
