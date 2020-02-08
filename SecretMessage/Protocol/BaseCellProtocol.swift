//
//  BaseCellProtocol.swift
//  SecretMessage
//
//  Created by Elano on 07/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol BaseCellProtocol: UITableViewCell {
    var viewModel: CellViewModelProtocol? { get set }
}
