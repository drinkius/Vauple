//
//  ViewController.swift
//  truthordare
//
//  Created by Alexander Telegin on 20.08.2023.
//

import UIKit
import XRPLSwift

class ViewController: UIViewController {

    private var client: XrplClient!

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupClient()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            if let key = DataStore.shared.getVaultAddress() {
//
//            }
        }
    }

    func setupClient() {
        let url: String = "wss://hooks-testnet-v3.xrpl-labs.com"
        client = try! XrplClient(server: url)
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "Vault Settings"

        // Add the main stack view to the view
        view.addSubview(stackView)

        // Set up constraints for the main stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

}
