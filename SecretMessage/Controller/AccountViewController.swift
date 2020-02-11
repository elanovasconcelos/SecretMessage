//
//  DetailViewController.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class AccountViewController: BaseViewController {

    private let viewModel: AccountViewModel

    init(viewModel: AccountViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
        
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func openSign() {
        
        if let wallet = viewModel.wallet {
            let controller = SigningViewController(viewModel: SigningViewModel(wallet: wallet))

            openController(controller)
        }else {
            showWalletError()
        }
    }

    private func openVerify() {
        if let wallet = viewModel.wallet {
            let controller = VerificationViewController(viewModel: VerificationViewModel(wallet: wallet))

            openController(controller)
        }else {
            showWalletError()
        }
    }
    
    private func showWalletError() {
        AlertHelper.showSimpleAlert(self, message: "No valid Wallet")
    }
    
}

//MARK: - AccountViewModelDelegate
extension AccountViewController: AccountViewModelDelegate {
    func accountViewModel(_ model: AccountViewModel, didSelectButton type: ButtonType) {
        switch type {
        case .sign: openSign()
        case .verify: openVerify()
        }
    }
}
