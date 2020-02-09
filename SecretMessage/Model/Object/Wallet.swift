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
    let keystore: EthereumKeystoreV3
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
                print("[signPersonalMessage]: \(error.localizedDescription)")
                completionHandler(.failure(.sign))
            }
        }
    }
    
    
    /// A function to validade a message and a signature
    /// - Parameters:
    ///   - signature: The  hexadecimal string  of the signature.
    ///   - message: The message used on the signature.
    ///   - completionHandler: The check result.  returns `true` if valid.
    func validatePersonalMessageSignature(_ signature: String, for message: String, completionHandler: @escaping (Bool) -> Void) {
        
        let signatureData = Data.fromHex(signature)
        let messageData = message.data(using: .utf8)
        
        validatePersonalMessageSignature(signatureData, for: messageData, completionHandler: completionHandler)
    }
    
    func validatePersonalMessageSignature(_ signature: Data?,
                                          for messageHash: Data?,
                                          completionHandler: @escaping (Bool) -> Void) {
        
        ecrecover(hash: messageHash, signature: signature) { [address] (newAddress) in
            guard let newAddress = newAddress else {
                completionHandler(false)
                return
            }
            
            completionHandler(newAddress == address)
        }
    }
    
    func ecrecover(hash: Data?, signature: Data?, completionHandler: @escaping (EthereumAddress?) -> Void) {
        ThreadHelper.background {
            do {
                guard
                    let hash = hash,
                    let messageData = Web3.Utils.hashPersonalMessage(hash),
                    let signature = signature
                else {
                    completionHandler(nil)
                    return
                }
                
                let result = try self.web3.personal.ecrecover(hash: messageData, signature: signature)
                
                completionHandler(result)
                
            } catch {
                completionHandler(nil)
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
