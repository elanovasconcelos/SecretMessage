//
//  BaseViewModel.swift
//  SecretMessage
//
//  Created by Elano on 07/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
import web3swift

protocol LoginViewModelDelegate: class {
    func loginViewModel(_ model: LoginViewModel?, didLoginWith result: Result<EthereumKeystoreV3, WalletError>)
}

final class LoginViewModel: NSObject, BaseViewModelProtocol {

    let models: [CellViewModelProtocol]
    let textFieldCellViewModel: TextFieldCellViewModel
    
    weak var delegate: LoginViewModelDelegate?
    
    override init() {
        textFieldCellViewModel = TextFieldCellViewModel(title: "Private key")
        models = [ TitleCellViewModel(title: "Setup"), textFieldCellViewModel ]
        
        super.init()
        
        textFieldCellViewModel.delegate = self
        //bind()
    }
    
    private func bind() {
        textFieldCellViewModel.text.valueChanged = { [weak self] text in
            self?.login(completionHandler: { (result) in
                self?.delegate?.loginViewModel(self, didLoginWith: result)
            })
        }
    }
    
    func login(completionHandler: @escaping (Result<EthereumKeystoreV3, WalletError>) -> Void) {

        let privateKey = textFieldCellViewModel.text.value
        
        if privateKey.isEmpty {
            completionHandler(.failure(.privateKey))
            return
        }
        
        Web3Helper.keystore(from: privateKey) { (ethereumKeystoreV3) in
            
            if let keystore = ethereumKeystoreV3 {
                 completionHandler(.success(keystore))
            }else {
                completionHandler(.failure(.privateKey))
            }
        }
    }
}

extension LoginViewModel: TextFieldCellViewModelDelegate {
    func textFieldCellViewModel(_ model: TextFieldCellViewModel, didKeyboardReturnsWith text: String) {
        
        login() { (result) in
            self.delegate?.loginViewModel(self, didLoginWith: result)
        }
    }
}
