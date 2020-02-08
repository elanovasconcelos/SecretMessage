//
//  BaseViewModel.swift
//  SecretMessage
//
//  Created by Elano on 07/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject, BaseViewModelProtocol {

    let models: [CellViewModelProtocol]
    
    override init() {
        models = [ TitleCellViewModel(title: "Setup") ]
    }
    
    
    
}


