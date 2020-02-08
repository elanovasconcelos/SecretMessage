//
//  BaseViewModel.swift
//  SecretMessage
//
//  Created by Elano on 07/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
import Web3swift

protocol LoginViewModelDelegate: class {
    func loginViewModel(_ model: LoginViewModel?, didLoginWith result: Result<EthereumAddress, WalletError>)
}

final class LoginViewModel: NSObject, BaseViewModelProtocol {

    let models: [CellViewModelProtocol]
    let textFieldCellViewModel: TextFieldCellViewModel
    
    weak var delegate: LoginViewModelDelegate?
    
    override init() {
        textFieldCellViewModel = TextFieldCellViewModel(title: "Private key")
        models = [ TitleCellViewModel(title: "Setup"), textFieldCellViewModel ]
        
        super.init()
        
        bind()
    }
    
    private func bind() {
        textFieldCellViewModel.text.valueChanged = { [weak self] text in
            self?.login(completionHandler: { (result) in
                self?.delegate?.loginViewModel(self, didLoginWith: result)
            })
        }
    }
    
    func login(completionHandler: @escaping (Result<EthereumAddress, WalletError>) -> Void) {

        let privateKey = textFieldCellViewModel.text.value
        
        if privateKey.isEmpty {
            completionHandler(.failure(.privateKey))
            return
        }
        
        Web3Helper.ethereumAddress(from: privateKey) { (addresses) in
            if let address = addresses?.first {
                completionHandler(.success(address))
            }else {
                completionHandler(.failure(.privateKey))
            }
        }
    }
    
    /*
     call delegate
     */
}


