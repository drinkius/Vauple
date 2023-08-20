//
//  SecondController.swift
//  truthordare
//
//  Created by Alexander Telegin on 20.08.2023.
//

import UIKit

class SecondController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
        
    private func setupUI() {
        view.backgroundColor = .blue
        // Creating the label
        let label = UILabel()
        label.text = "Second Controller!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        
        // Adding the label to the view and setting its constraints
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
