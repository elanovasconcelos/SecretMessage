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
    let address: EthereumAddress
    let balanceViewModel: InformationCellViewModel
    
    private(set) var web3: web3? { didSet { updateBalance() }}
    
    weak var delegate: AccountViewModelDelegate?
    
    init(address: EthereumAddress, type: Web3Type = .local) {
        self.address = address
        self.balanceViewModel = InformationCellViewModel(title: "Balance", suffix: " Ether", showLoadingMessage: true)
        
        let buttons = [ButtonCellViewModel(title: "Sign", buttonType: .sign), ButtonCellViewModel(title: "Verify", buttonType: .verify)]
        
        self.models = [TitleCellViewModel(title: "Account"),
                       InformationCellViewModel(title: "Address", information: address.address, suffix: "Ed"),
                       balanceViewModel] + buttons
        
        super.init()
        
        buttons.forEach { $0.delegate = self }
        
        updateWeb3(type: type)
    }
    
    var wallet: Wallet? {
        
        guard let web3 = web3 else { return nil }
        
        return Wallet(web3: web3, address: address)
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
