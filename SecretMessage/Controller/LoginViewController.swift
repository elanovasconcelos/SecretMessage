//
//  LoginViewController.swift
//  SecretMessage
//
//  Created by Elano on 07/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
import Web3swift

final class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private let viewModel: LoginViewModel

    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
        
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func openAccountView(with address: EthereumAddress) {
        print("address: \(address)")
        
        let viewController = AccountViewController(viewModel: AccountViewModel(address: address, type: .local))
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.modalPresentationStyle = .fullScreen
        
        self.present(navigationController, animated: true, completion: nil)
    }
}

//MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate {
    func loginViewModel(_ model: LoginViewModel?, didLoginWith result: Result<EthereumAddress, WalletError>) {
        switch result {
        case .success(let address):
            ThreadHelper.main {
                self.openAccountView(with: address)
            }
            
        case .failure(_):
            AlertHelper.showSimpleAlert(self, message: "Invalid private key")
        }
    }
}
