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
        textFieldCellViewModel.delegate = self
    }
    
    private func didSelectButton(with type: ButtonType) {
        delegate?.verificationViewModel(self, didSelectButton: type)
    }
}

//MARK: -
extension VerificationViewModel {
    var message: String {
        return textFieldCellViewModel.text.value
    }
}

//MARK: - ButtonCellViewModelDelegate
extension VerificationViewModel: ButtonCellViewModelDelegate {
    func buttonCellViewModelDidSelect(_ model: ButtonCellViewModel) {
        didSelectButton(with: model.buttonType)
    }
}

//MARK: - TextFieldCellViewModelDelegate
extension VerificationViewModel: TextFieldCellViewModelDelegate {
    func textFieldCellViewModel(_ model: TextFieldCellViewModel, didKeyboardReturnsWith text: String) {
        didSelectButton(with: .verify)
    }
}
