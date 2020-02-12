//
//  AccountViewModelTests.swift
//  SecretMessageTests
//
//  Created by Elano on 11/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import XCTest
import web3swift
@testable import SecretMessage

class AccountViewModelTests: XCTestCase {

    private var accountViewModel: AccountViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testModelsField() {
        let expectation = self.expectation(description: "viewModel")
        let _ = accountViewModel { (viewModel) in
            let modelsCount = viewModel?.models.count ?? 0
            
            XCTAssertNotNil(viewModel)
            XCTAssertEqual(modelsCount, 5)
            
            if modelsCount >= 5 {
                XCTAssertEqual(viewModel?.models[0].title, "Account")
                XCTAssertEqual(viewModel?.models[1].title, "Address")
                XCTAssertEqual(viewModel?.models[2].title, "Balance")
                XCTAssertEqual(viewModel?.models[3].title, "Sign")
                XCTAssertEqual(viewModel?.models[4].title, "Verify")
                
                XCTAssertEqual(viewModel?.models[1].text.value, "0x8CFC2286eb2e9C450056aC8609C945e1BE3D7a87Ed")
                XCTAssertEqual(viewModel?.models[2].text.value, "Loading...")
            }
            
            expectation.fulfill()
        }
        
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}

//MARK: -
extension AccountViewModelTests {
    
    func accountViewModel(completionHandler: @escaping (AccountViewModel?) -> Void) {
        
        /// A private key from Ganache
        let privateKey = "42c521d5630bedc9a408725ad7f11690999c125a1fcebe248f24b6b6d8766c17"
        
        Web3Helper.keystore(from: privateKey) { (keystore) in
            guard let keystore = keystore else {
                completionHandler(nil)
                return
            }
            
            completionHandler(AccountViewModel(keystore: keystore, type: .local))
        }
    }
}
