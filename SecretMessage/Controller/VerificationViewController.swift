//
//  VerificationViewController.swift
//  SecretMessage
//
//  Created by Elano on 09/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class VerificationViewController: BaseViewController {

    private let viewModel: VerificationViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    init(viewModel: VerificationViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
        
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func openCamera() {
        let cameraViewModel = CameraViewModel(wallet: viewModel.wallet, message: viewModel.message)
        let controller = CameraViewController(viewModel: cameraViewModel)
        
        openController(controller)
    }
}

//MARK: -
extension VerificationViewController: VerificationViewModelDelegate {
    func verificationViewModel(_ model: VerificationViewModel, didSelectButton type: ButtonType) {
        openCamera()
    }
}
