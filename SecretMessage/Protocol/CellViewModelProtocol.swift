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
    var text: Observable<String> { get }
}

//MARK: -
extension CellViewModelProtocol {
    var text: Observable<String> {
        fatalError("not implemented")
    }
}

//MARK: -
enum CellType: String {
    case title
    case textField
    case information
    case button
    case message
    
    var identifier: String {
        
        switch self {
        case .title: return TitleTableViewCell.identifier
        case .textField: return TextFieldTableViewCell.identifier
        case .information: return InformationTableViewCell.identifier
        case .button: return ButtonTableViewCell.identifier
        case .message: return MessageTableViewCell.identifier
        }
    }
}

//MARK: -
class Observable<T> {
    var value: T {
        didSet {
            ThreadHelper.main {
                self.valueChanged?(self.value)
            }
        }
    }
    var valueChanged: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
}

