//
//  SecondController.swift
//  truthordare
//
//  Created by Alexander Telegin on 20.08.2023.
//

import UIKit

class SecondController: UIViewController {

    private let vaultAddressSection: VaultAddressSectionView = {
        let sectionView = VaultAddressSectionView()
//        sectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return sectionView
    }()

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
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "Vault Settings"

        // Add the section view to the main stack view
        stackView.addArrangedSubview(vaultAddressSection)

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

class VaultAddressSectionView: UIStackView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Vault Address"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.text = DataStore.shared.getVaultAddress() ?? "Please enter vault address"
        label.font = UIFont.systemFont(ofSize: 16)
        label.isUserInteractionEnabled = true
        return label
    }()

    private let editTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Vault Address"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.isHidden = true
        return textField
    }()

    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        axis = .vertical
        spacing = 10

        addArrangedSubview(titleLabel)
        addArrangedSubview(valueLabel)
        addArrangedSubview(editTextField)
        addArrangedSubview(saveButton)
    }

    private func setupActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(valueLabelTapped))
        valueLabel.addGestureRecognizer(tapGesture)

        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    @objc private func valueLabelTapped() {
        valueLabel.isHidden = true
        editTextField.text = valueLabel.text
        editTextField.isHidden = false
        editTextField.becomeFirstResponder()
        editTextField.selectAll(nil)
    }

    @objc private func saveButtonTapped() {
        guard let newAddress = editTextField.text else {
            return
        }
        DataStore.shared.setVaultAddress(newAddress)
        valueLabel.text = newAddress

        valueLabel.isHidden = false
        editTextField.isHidden = true
        editTextField.resignFirstResponder()
    }
}

