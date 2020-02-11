//
//  Web3Helper.swift
//  SecretMessage
//
//  Created by Elano on 05/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
import web3swift

typealias PrivateKey = String

final class Web3Helper: NSObject {
    
    static func localNode(port: Int = 7545, completionHandler: @escaping (web3?) -> Void) {
        
        ThreadHelper.background {
            do {
                //TODO continue: to background
                guard let url = URL(string: "http://127.0.0.1:\(port)") else {
                    completionHandler(nil)
                    return
                }
                
                let web3 = try Web3.new(url)
                
                completionHandler(web3)
            } catch {
                log(error, place: "localNode")
                completionHandler(nil)
            }
        }
    }
    
    static func ethereumAddress(from privateKey: PrivateKey, completionHandler: @escaping ([EthereumAddress]?) -> Void) {
        //TODO: maybe improve using Result<> and erro enum
        ThreadHelper.background {
            do {
                guard let privateKeyData = Data.fromHex(privateKey) else {
                    completionHandler(nil)
                    return
                }
                let etheriumKeystore = try EthereumKeystoreV3.init(privateKey: privateKeyData)
                
                completionHandler(etheriumKeystore?.addresses)
                
            } catch  {
                log(error, place: "addresses")
                
                completionHandler(nil)
            }
        }
    }
    
    static func keystore(from privateKey: PrivateKey, completionHandler: @escaping (EthereumKeystoreV3?) -> Void) {
        //TODO: maybe improve using Result<> and erro enum
        ThreadHelper.background {
            do {
                guard let privateKeyData = Data.fromHex(privateKey) else {
                    completionHandler(nil)
                    return
                }
                let etheriumKeystore = try EthereumKeystoreV3.init(privateKey: privateKeyData)
                
                completionHandler(etheriumKeystore)
                
            } catch  {
                log(error, place: "keystore")
                
                completionHandler(nil)
            }
        }
    }
    
    static func balance(from address: EthereumAddress, web3: web3?, completionHandler: @escaping (String?) -> Void) {
        
        guard let web3 = web3 else {
            completionHandler(nil)
            return
        }
        
        ThreadHelper.background {
            
            do {
                let balancebigint = try web3.eth.getBalance(address: address)
                completionHandler(Web3.Utils.formatToEthereumUnits(balancebigint))
            } catch {
                log(error, place: "balance")
                completionHandler(nil)
            }
        }
    }
    
    static func signPersonalMessage(_ message: String, from address: EthereumAddress, web3: web3, completionHandler: @escaping (Data?) -> Void) {
        ThreadHelper.background {
            do {
                guard
                    let messageData = message.data(using: .utf8)
                    else {
                        completionHandler(nil)
                        return
                }
                
                let result = try web3.personal.signPersonalMessage(message: messageData, from: address)
                
                completionHandler(result)
            } catch {
                log(error, place: "signPersonalMessage")
                completionHandler(nil)
            }
        }
    }
    
    static func ecrecover(hash: Data, signature: Data, web3: web3, completionHandler: @escaping (EthereumAddress?) -> Void) {
        ThreadHelper.background {
            do {
                guard let messageData = Web3.Utils.hashPersonalMessage(hash) else {
                    completionHandler(nil)
                    return
                }
                
                let result = try web3.personal.ecrecover(hash: messageData, signature: signature)
                
                completionHandler(result)
                
            } catch {
                log(error, place: "ecrecover")
                completionHandler(nil)
            }
        }
    }
    
    //MARK: -
    static func log(_ error: Error, place: String = "") {
        //TODO: improve error
        print("[Web3Helper|\(place)]: \(error.localizedDescription)")
    }
}

//MARK: -


