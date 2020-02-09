//
//  DetailViewModel.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
import Web3swift

protocol AccountViewModelDelegate: class {
    func accountViewModel(_ model: AccountViewModel, didSelectButton type: ButtonType)
}

final class AccountViewModel: NSObject, BaseViewModelProtocol {

    let models: [CellViewModelProtocol]
    let address: EthereumAddress?
    let balanceViewModel: InformationCellViewModel
    let keystore: EthereumKeystoreV3
    
    private(set) var web3: web3? { didSet { updateBalance() }}
    
    weak var delegate: AccountViewModelDelegate?
    
    init(keystore: EthereumKeystoreV3, type: Web3Type = .local) {
        self.keystore = keystore
        self.address = keystore.addresses?.first
        self.balanceViewModel = InformationCellViewModel(title: "Balance", suffix: " Ether", showLoadingMessage: true)
        
        let buttons = [ButtonCellViewModel(title: "Sign", buttonType: .sign), ButtonCellViewModel(title: "Verify", buttonType: .verify)]
        
        let addressString = address?.address ?? "Error"
        self.models = [TitleCellViewModel(title: "Account"),
                       InformationCellViewModel(title: "Address", information: addressString, suffix: "Ed"),
                       balanceViewModel] + buttons
        
        super.init()
        
        buttons.forEach { $0.delegate = self }
        
        updateWeb3(type: type)
    }
    
    var wallet: Wallet? {
        
        guard
            let web3 = web3,
            let address = address
            else { return nil }
        
        return Wallet(web3: web3, address: address, keystore: keystore)
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
        
        let newWeb3 = Web3.InfuraRinkebyWeb3()
        let keystoreManager = KeystoreManager([keystore])
        
        newWeb3.addKeystoreManager(keystoreManager)
        
        self.web3 = newWeb3
    }
    
    func updateBalance() {
        //TODO: improve error
        
        let suffix = balanceViewModel.suffix
        
        guard let address = address else {
            self.balanceViewModel.text.value = "Error"
            return
        }
        
        Web3Helper.balance(from: address, web3: web3) { [weak self] (value) in
            
            if let newValue = value {
                self?.balanceViewModel.text.value = newValue + suffix
            }else {
                self?.balanceViewModel.text.value = "Error"
            }
        }
    }
    
    //MARK: - Enum
    enum Web3Type {
        case local
        case rinkeby
    }
}

//MARK: - ButtonCellViewModelDelegate
extension AccountViewModel: ButtonCellViewModelDelegate {
    func buttonCellViewModelDidSelect(_ model: ButtonCellViewModel) {
        delegate?.accountViewModel(self, didSelectButton: model.buttonType)
    }
}
