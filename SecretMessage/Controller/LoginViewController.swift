//
//  LoginViewController.swift
//  SecretMessage
//
//  Created by Elano on 07/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
import web3swift

final class LoginViewController: BaseViewController {
    
    private let viewModel: LoginViewModel

    //MARK: -
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        clearTitle()
    }
    
    //MARK: -
    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
        
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func openAccountView(with keystore: EthereumKeystoreV3) {

        let accountViewModel = AccountViewModel(keystore: keystore, type: .rinkeby)
        let viewController = AccountViewController(viewModel: accountViewModel)
        let navigationController = BaseNavigationController(rootViewController: viewController)

        navigationController.modalPresentationStyle = .fullScreen
        
        self.present(navigationController, animated: true, completion: nil)
    }
}

//MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate {
    func loginViewModel(_ model: LoginViewModel?, didLoginWith result: Result<EthereumKeystoreV3, WalletError>) {
        switch result {
        case .success(let address):
            ThreadHelper.main {
                self.openAccountView(with: address)
            }
            
        case .failure(let error):
            print("[LoginViewController]: \(error.localizedDescription)")
            AlertHelper.showSimpleAlert(self, message: "Invalid private key")
        }
    }
}
