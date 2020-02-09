//
//  SignatureViewModel.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class SignatureViewModel: NSObject, BaseViewModelProtocol {

    let models: [CellViewModelProtocol]
    let wallet: Wallet
    let signature: Data
    
    init(message: String, wallet: Wallet, signature: Data) {
        
        self.signature = signature
        self.wallet = wallet
        self.models = [TitleCellViewModel(title: "Signature"),
                       MessageCellViewModel(message: message),
                       ImageCellViewModel(data: signature)]
    }
}
