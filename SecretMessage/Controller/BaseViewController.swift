//
//  ViewController.swift
//  SecretMessage
//
//  Created by Elano on 04/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
import Web3swift

class BaseViewController: UIViewController {

    private let tableView: UITableView = {
       
        let newTableView = UITableView(frame: .zero)

        newTableView.rowHeight = UITableView.automaticDimension
        newTableView.estimatedRowHeight = 44
        newTableView.separatorStyle = .none
        
        return newTableView
    }()
    
    private let viewModel: BaseViewModelProtocol
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupTableView()
    }

    //MARK: - 
    private func setupTableView() {

        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              leading: view.safeAreaLayoutGuide.leadingAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    init(viewModel: BaseViewModelProtocol) {
        self.viewModel = viewModel
    
        viewModel.register(tableView: tableView)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func testSetup2() {
//        let privateKey = "42c521d5630bedc9a408725ad7f11690999c125a1fcebe248f24b6b6d8766c17"
//        //let web3 = Web3Helper.localNode()!
//
//        Web3Helper.localNode { (web3) in
//            guard let web3 = web3 else { return }
//
//            let _ = Web3Helper.ethereumAddress(from: privateKey) { addresses in
//                Web3Helper.balance(from: addresses!.first!, web3: web3) { balance in
//                    print("balance: \(String(describing: balance))")
//                }
//            }
//        }
//    }
    
//    private func testSetup() {
//
//        print("--testSetup--")
//
//        guard let web3 = localNode() else {  return }
//        let stringAddress = "0x8CFC2286eb2e9C450056aC8609C945e1BE3D7a87"
//        guard var ethAdd = EthereumAddress(stringAddress) else {
//            print("ethAdd")
//            return
//        }
//
//
//        do {
//            let privateKey = "42c521d5630bedc9a408725ad7f11690999c125a1fcebe248f24b6b6d8766c17"
//            let privateKeyData = Data.fromHex(privateKey)
//
//            let etheriumKeystore = try EthereumKeystoreV3.init(privateKey: privateKeyData!)
//
//            if let newAddress = etheriumKeystore?.addresses?.first {
//                ethAdd = newAddress
//                print("changed: \(ethAdd)")
//            }else {
//                print("no address")
//            }
//        } catch  {
//            print("[etheriumKeystore]: \(error.localizedDescription)")
//        }
//
//
//
//        do {
//            let balancebigint = try web3.eth.getBalance(address: ethAdd)//.value
//
//            print("Ether Balance: \(String(describing: Web3.Utils.formatToEthereumUnits(balancebigint)!))")
//
//            let message = "hi hi"
//            let messageData = Web3.Utils.hashPersonalMessage(message.data(using: .utf8)!)!//Data.fromHex("\(message.hashValue)")!
//
////            let result = try web3.personal.signPersonalMessage(message: messageData,
////                                                               from: ethAdd)
//
//            let result2 = try web3.personal.signPersonalMessage(message: message.data(using: .utf8)!,
//                                                                from: ethAdd)
//
//            //let resultAddress = Web3.Utils.personalECRecover(messageData, signature: result)!
//            let resultAddress2 = try web3.personal.ecrecover(hash: messageData, signature: result2)
//
//            //print("result: \(result)")
//            print("resultAddress: \(resultAddress2)")
//            print("isValid:\(ethAdd == resultAddress2)")
//            //print("result2: \(resultAddress)")
//
//        } catch  {
//            print("[testSetup]: \(error.localizedDescription)")
//        }
//
//
//    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension BaseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfrows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = viewModel.models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: model.type.identifier, for: indexPath) as! BaseCellProtocol
        
        cell.viewModel = model
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
