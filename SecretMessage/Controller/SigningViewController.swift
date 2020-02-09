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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    init(viewModel: SigningViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
        
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func openSignature(with data: Data) {
        
        print("viewModel.message: \(viewModel.message)")
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
        case .success(let data): openSignature(with: data)
        case .failure(_): AlertHelper.showSimpleAlert(self, message: "Invalid message")
        }
    }
}
