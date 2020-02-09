//
//  SignatureViewModel.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
import Web3swift


final class SignatureViewModel: NSObject, BaseViewModelProtocol {

    let models: [CellViewModelProtocol]
    let wallet: Wallet
    let signature: Data
    
    init(message: String, wallet: Wallet, signature: Data) {

        self.wallet = wallet
        
        //qr code needs to be a string data
        let signatureString = signature.toHexString()
        let signatureStringData: Data
        
        if let newData = signatureString.data(using: .utf8) {
            signatureStringData = newData
        }else {
            signatureStringData = signature
        }
        
        self.signature = signatureStringData
        self.models = [TitleCellViewModel(title: "Signature"),
                       MessageCellViewModel(message: message),
                       ImageCellViewModel(data: signatureStringData)]
    }
}
