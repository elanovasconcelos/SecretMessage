//
//  DetailViewController.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class AccountViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
        print("openSign")
        
        if let wallet = viewModel.wallet {
            let controller = SigningViewController(viewModel: SigningViewModel(wallet: wallet))

            openController(controller)
        }else {
            AlertHelper.showSimpleAlert(self, message: "No valid Wallet")
        }
        
    }

    private func openVerify() {
        print("openVerify")
    }
    
    
}

//MARK: - AccountViewModelDelegate
extension AccountViewController: AccountViewModelDelegate {
    func accountViewModel(_ model: AccountViewModel, didSelectButton type: ButtonCellViewModel.ButtonType) {
        switch type {
        case .sign: openSign()
        case .verify: openVerify()
        }
    }
}
