//
//  TextFieldTableViewCell.swift
//  SecretMessage
//
//  Created by Elano on 07/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class TextFieldTableViewCell: BaseTableViewCell {
    
    @IBOutlet var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTextField()
    }

    override func setup() {
        super.setup()
        
        guard let viewModel = viewModel else { return }
        
        textField.placeholder = viewModel.title
    }
    
    private func setupTextField() {
        textField.returnKeyType = .done
        textField.delegate = self
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        viewModel?.text.value = textField.text ?? ""
    }
}

extension TextFieldTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        viewModel?.text.value = textField.text ?? ""
        viewModel?.eventSelected()
        
        return true
    }
}
