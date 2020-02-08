//
//  BaseViewModelProtocol.swift
//  SecretMessage
//
//  Created by Elano on 07/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol BaseViewModelProtocol {
    
    var models: [CellViewModelProtocol] { get }
    
    func numberOfrows() -> Int
    func register(tableView: UITableView?)
}

extension BaseViewModelProtocol {
    
    func register(tableView: UITableView?) {
        guard let tableView = tableView else { return }
        
        models.forEach { tableView.register(nibNameAndIdentifier: $0.type.identifier) }
    }
    
    func numberOfrows() -> Int {
        return models.count
    }
}
