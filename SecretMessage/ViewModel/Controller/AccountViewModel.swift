//
//  DetailViewModel.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
import Web3swift

final class AccountViewModel: NSObject, BaseViewModelProtocol {

    let models: [CellViewModelProtocol]
    let address: EthereumAddress
    let balanceViewModel: InformationCellViewModel
    private(set) var web3: web3? { didSet { updateBalance() }}
    
    init(address: EthereumAddress, type: Web3Type = .local) {
        self.address = address
        self.balanceViewModel = InformationCellViewModel(title: "Balance", suffix: " Ether", showLoadingMessage: true)
        
        self.models = [TitleCellViewModel(title: "Account"),
                       InformationCellViewModel(title: "Address", information: address.address, suffix: "Ed"),
                       balanceViewModel]
        
        super.init()
        
        updateWeb3(type: type)
    }
    
    private func updateWeb3(type: Web3Type) {
        
        switch type {
        case .local: updateLocal()
        case .rinkeby: updateRinkeby()
        }
    }
    
    private func updateLocal() {
        Web3Helper.localNode { [weak self] (web3) in
            self?.web3 = web3
        }
    }
    
    private func updateRinkeby() {
        self.web3 = Web3.InfuraRinkebyWeb3()
    }
    
    func updateBalance() {
        //TODO: improve error
        
        let suffix = balanceViewModel.suffix
        
        Web3Helper.balance(from: address, web3: web3) { [weak self] (value) in
            
            if let newValue = value {
                self?.balanceViewModel.text.value = newValue + suffix
            }else {
                self?.balanceViewModel.text.value = "Error"
            }
        }
    }
    
    //MARK: -
    enum Web3Type {
        case local
        case rinkeby
    }
}
