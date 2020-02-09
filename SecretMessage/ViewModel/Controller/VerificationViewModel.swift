//
//  VerificationViewModel.swift
//  SecretMessage
//
//  Created by Elano on 09/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol VerificationViewModelDelegate: class {
    func verificationViewModel(_ model: VerificationViewModel, didSelectButton type: ButtonType)
}

final class VerificationViewModel: NSObject, BaseViewModelProtocol {

    let models: [CellViewModelProtocol]
    let textFieldCellViewModel: TextFieldCellViewModel
    let wallet: Wallet
    
    weak var delegate: VerificationViewModelDelegate?
    
    init(wallet: Wallet) {
        
        textFieldCellViewModel = TextFieldCellViewModel(title: "Your message")
        
        let verifyButton = ButtonCellViewModel(title: "Verify message", buttonType: .verify)
        
        self.models = [TitleCellViewModel(title: "Verification"), textFieldCellViewModel, verifyButton]
        self.wallet = wallet
        
        super.init()
        
        verifyButton.delegate = self
    }
    
    var message: String {
        return textFieldCellViewModel.text.value
    }
}

//MARK: -
extension VerificationViewModel: ButtonCellViewModelDelegate {
    func buttonCellViewModelDidSelect(_ model: ButtonCellViewModel) {
        delegate?.verificationViewModel(self, didSelectButton: model.buttonType)
    }
}
