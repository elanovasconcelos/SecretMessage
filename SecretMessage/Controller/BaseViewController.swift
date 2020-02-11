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
        newTableView.isScrollEnabled = false
        
        return newTableView
    }()
    
    private let viewModel: BaseViewModelProtocol
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        clearTitle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        updateTitle()
    }
    
    //MARK: -
    private func setupController() {
        view.backgroundColor = .systemBackground
    }
    
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
}

// MARK: -
extension BaseViewController {
    
    func clearTitle() {
        title = ""
    }
    
    func updateTitle() {
        if viewModel.models.count > 0 {
            title = viewModel.models[0].title
        }
    }
    
    func openController(_ controller: UIViewController) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.pushViewController(controller, animated: true)
    }
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
