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
        sectionView.titleText = "Vault address"
        sectionView.labelPlaceholder = "Enter Vault Address"
        sectionView.storageKey = "VaultAddressKey"
        return sectionView
    }()

    private let signerPublicKeySection: VaultAddressSectionView = {
        let sectionView = VaultAddressSectionView()
        sectionView.titleText = "Signer address"
        sectionView.labelPlaceholder = "Enter Address"
        sectionView.storageKey = "SignerAddress"
        return sectionView
    }()

    private let signerPrivateKeySection: VaultAddressSectionView = {
        let sectionView = VaultAddressSectionView()
        sectionView.titleText = "Signer private key"
        sectionView.labelPlaceholder = "Enter Private Key"
        sectionView.storageKey = "SignerPrivateKey"
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
        stackView.addArrangedSubview(signerPublicKeySection)
        stackView.addArrangedSubview(signerPrivateKeySection)

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

    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }

    var labelPlaceholder: String? {
        didSet {
            editTextField.placeholder = labelPlaceholder
            if valueLabel.text?.isEmpty ?? true {
                valueLabel.text = labelPlaceholder
            }
        }
    }

    var storageKey: String? {
        didSet {
            guard let key = storageKey else { return }
            if DataStore.shared.geValue(key)?.isEmpty ?? true {
                valueLabel.text = labelPlaceholder
            } else {
                valueLabel.text = DataStore.shared.geValue(key)
            }
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.isUserInteractionEnabled = true
        return label
    }()

    private let editTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Placeholder"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.isHidden = true
        return textField
    }()

    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        return button
    }()

    init(placeholder: String) {
        labelPlaceholder = placeholder
        super.init(frame: .zero)
    }

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
        guard let newValue = editTextField.text else {
            return
        }
        DataStore.shared.setValueForKey(storageKey!, value: newValue)
        valueLabel.text = newValue

        valueLabel.isHidden = false
        editTextField.isHidden = true
        editTextField.resignFirstResponder()
    }
}

