//
//  MessageCellViewModel.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class MessageCellViewModel: NSObject, CellViewModelProtocol {
    
    let title: String
    let type: CellType = .message
    
    init(message: String) {
        self.title = "Message: \"\(message)\""
    }
}
