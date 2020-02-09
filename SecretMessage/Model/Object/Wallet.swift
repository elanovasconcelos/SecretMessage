//
//  Wallet.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
import Web3swift

struct Wallet {

    let web3: web3
    let address: EthereumAddress
}

//MARK: -
extension Wallet {
    func signPersonalMessage(_ message: String, completionHandler: @escaping (Result<Data, WalletError>) -> Void) {
        ThreadHelper.background {
            do {
                guard
                    let messageData = message.data(using: .utf8)
                    else {
                        completionHandler(.failure(.message))
                        return
                }
                
                let result = try self.web3.personal.signPersonalMessage(message: messageData, from: self.address)
                
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(.sign))
            }
        }
    }
}

//MARK: - WalletError
enum WalletError: Error {
    case privateKey
    case sign
    case message
}
