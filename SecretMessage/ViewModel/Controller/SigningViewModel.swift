//
//  SigningViewModel.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol SigningViewModelDelegate: class {
    func signingViewModel(_ model: SigningViewModel, didSignWith result: Result<Data, WalletError>)
}

final class SigningViewModel: NSObject, BaseViewModelProtocol {

    let models: [CellViewModelProtocol]
    let textFieldCellViewModel: TextFieldCellViewModel
    let wallet: Wallet

    weak var delegate: SigningViewModelDelegate?
    
    init(wallet: Wallet) {
        
        textFieldCellViewModel = TextFieldCellViewModel(title: "Your message")
        
        let signButton = ButtonCellViewModel(title: "Sign message")
        
        self.models = [TitleCellViewModel(title: "Signing"), textFieldCellViewModel, signButton]
        self.wallet = wallet
        
        super.init()
        
        signButton.delegate = self
        textFieldCellViewModel.delegate = self
    }
    
    var message: String {
        return textFieldCellViewModel.text.value
    }
    
    func sign() {
        wallet.signPersonalMessage(message) {(result) in
            
            self.delegate?.signingViewModel(self, didSignWith: result)
        }
    }
}

//MARK: - ButtonCellViewModelDelegate
extension SigningViewModel: ButtonCellViewModelDelegate {
    func buttonCellViewModelDidSelect(_ model: ButtonCellViewModel) {
        sign()
    }
}

//MARK: - TextFieldCellViewModelDelegate
extension SigningViewModel: TextFieldCellViewModelDelegate {
    func textFieldCellViewModel(_ model: TextFieldCellViewModel, didKeyboardReturnsWith text: String) {
        sign()
    }
}
