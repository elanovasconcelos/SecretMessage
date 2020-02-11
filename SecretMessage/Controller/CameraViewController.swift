//
//  CameraViewController.swift
//  SecretMessage
//
//  Created by Elano on 09/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class CameraViewController: UIViewController {

    private let titleLabel: UILabel = {
        
        let newLabel = UILabel(frame: .zero)
        
        newLabel.text = "QR Code Scanner"
        newLabel.backgroundColor = .clear
        newLabel.textColor = .label
        newLabel.font = UIFont.boldSystemFont(ofSize: 37)
        
        return newLabel
    }()
    
    private let titleContainerView: UIView = {
        
        let newView = UIView(frame: .zero)
        
        newView.backgroundColor = .systemBackground
        
        return newView
    }()
    
    private let cameraContainerView: UIView = {
        
        let newView = UIView(frame: .zero)
        
        newView.backgroundColor = .red
        
        return newView
    }()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    private let viewModel: CameraViewModel
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()

        print("CameraViewController - viewDidLoad")
        setupViews()
        
        viewModel.addCamera(to: view)
    }
    
    init(viewModel: CameraViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -
    private func setupViews() {
        view.addSubview(titleContainerView)
        view.addSubview(cameraContainerView)
        
        titleContainerView.addSubview(titleLabel)
        
        titleContainerView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                  leading: view.safeAreaLayoutGuide.leadingAnchor,
                                  bottom: cameraContainerView.topAnchor,
                                  trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        cameraContainerView.anchor(leading: view.safeAreaLayoutGuide.leadingAnchor,
                                   bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                   trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        titleLabel.anchor(top: titleContainerView.topAnchor,
                          leading: titleContainerView.leadingAnchor,
                          bottom: titleContainerView.bottomAnchor,
                          trailing: titleContainerView.trailingAnchor, value: 8)
        
        //titleContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
    }
    
    private func back() {
        navigationController?.popViewController(animated: true)
    }
    
    private func showCheckResult(_ result: Bool) {
        AlertHelper.showSimpleAlert(self, message:  result ? "Signature is valid" : "Signature is invalid", completionHandler: back)
    }
    
    private func showGenericError() {
        AlertHelper.showSimpleAlert(self, message: "Internal error")
    }
}

extension CameraViewController: CameraViewModelDelegate {
    func cameraViewModel(_ model: CameraViewModel, didGet result: Result<Bool, CameraViewModelError>) {
        switch result {
        case .success(let value):
            showCheckResult(value)
        case .failure(_):
            showGenericError()
        }
    }

}
