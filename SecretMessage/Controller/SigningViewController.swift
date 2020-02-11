//
//  SigningViewController.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class SigningViewController: BaseViewController {

    private let viewModel: SigningViewModel
    
    //MARK: -
    init(viewModel: SigningViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
        
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - 
    private func openSignature(with data: Data) {

        let model = SignatureViewModel(message: viewModel.message, wallet: viewModel.wallet, signature: data)
        
        ThreadHelper.main {
            let controller = SignatureViewController(viewModel: model)
            
            self.openController(controller)
        }
    }
}

//MARK: -
extension SigningViewController: SigningViewModelDelegate {
    func signingViewModel(_ model: SigningViewModel, didSignWith result: Result<Data, WalletError>) {
        switch result {
        case .success(let data):
            closeKeyboard()
            openSignature(with: data)
        case .failure(_): AlertHelper.showSimpleAlert(self, message: "Invalid message")
        }
    }
}
