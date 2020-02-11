//
//  MockLoginViewModelDelegate.swift
//  SecretMessageTests
//
//  Created by Elano on 09/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
import web3swift
@testable import SecretMessage

class MockLoginViewModelDelegate: NSObject, LoginViewModelDelegate {
    
    private(set) var result: Result<EthereumKeystoreV3, WalletError>?
    private(set) var callCount = 0
    
    var callBack: (MockLoginViewModelDelegate) -> Void
    
    init(callBack: @escaping (MockLoginViewModelDelegate) -> Void) {
        self.callBack = callBack
    }
    
    func loginViewModel(_ model: LoginViewModel?, didLoginWith result: Result<EthereumKeystoreV3, WalletError>) {
        self.result = result
        callCount += 1
        
        callBack(self)
    }
    
}
