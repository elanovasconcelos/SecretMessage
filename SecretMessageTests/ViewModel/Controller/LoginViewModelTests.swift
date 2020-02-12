//
//  LoginViewModelTests.swift
//  SecretMessageTests
//
//  Created by Elano on 09/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import XCTest
@testable import SecretMessage

class LoginViewModelTests: XCTestCase {

    private var loginViewModel: LoginViewModel!
    
    override func setUp() {
        loginViewModel = LoginViewModel()
    }

    override func tearDown() {
        
    }

    func testModelsField() {
        let models = loginViewModel.models
        
        XCTAssertEqual(models.count, 2)
        
        if models.count >= 2 {
            XCTAssertEqual(models[0].title, "Setup")
            XCTAssertEqual(models[1].title, "Private key")
        }
    }

    func testFailLogin() {
        let textFieldText = "no key"
        let expectation = self.expectation(description: "Delegate")
        let mockDelegate = MockLoginViewModelDelegate() { [loginViewModel] delegate in
            
            XCTAssertEqual(delegate.callCount, 1)
            XCTAssertEqual(loginViewModel?.textFieldCellViewModel.text.value, textFieldText)
            XCTAssertNotNil(delegate.result)
            
            switch delegate.result! {
            case .failure(let error): XCTAssertEqual(error, .privateKey)
            case .success(_): XCTAssertFalse(true, "It should fail")
            }
            
            expectation.fulfill()
        }
        
        loginViewModel.delegate = mockDelegate
        loginViewModel.textFieldCellViewModel.text.value = textFieldText
        loginViewModel.textFieldCellViewModel(loginViewModel.textFieldCellViewModel, didKeyboardReturnsWith: textFieldText)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSucessLogin() {
        let textFieldText = "42c521d5630bedc9a408725ad7f11690999c125a1fcebe248f24b6b6d8766c17"
        let expectation = self.expectation(description: "Delegate")
        let mockDelegate = MockLoginViewModelDelegate() { delegate in
            
            XCTAssertEqual(delegate.callCount, 1)
            XCTAssertNotNil(delegate.result)
            
            switch delegate.result! {
            case .failure(_): XCTAssertTrue(false, "It should get sucess")
            case .success(let keystore):
                XCTAssertNotNil(keystore.addresses)
                XCTAssertEqual(keystore.addresses?.count, 1)
            }
            
            expectation.fulfill()
        }
        
        loginViewModel.delegate = mockDelegate
        loginViewModel.textFieldCellViewModel.text.value = textFieldText
        loginViewModel.textFieldCellViewModel(loginViewModel.textFieldCellViewModel, didKeyboardReturnsWith: textFieldText)

        waitForExpectations(timeout: 1, handler: nil)
    }
}
