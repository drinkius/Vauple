//
//  GenericTableDataSource.swift
//  vauple
//
//  Created by Alexander Telegin on 21.08.2023.
//

import Foundation

class DataStore {
    // Create a shared instance (Singleton)
    static let shared = DataStore()

    private init() {}

    // UserDefaults keys
    private let vaultAddressKey = "VaultAddressKey"

    // MARK: - Vault Address

    // Store vault address in UserDefaults
    func setVaultAddress(_ address: String) {
        UserDefaults.standard.set(address, forKey: vaultAddressKey)
    }

    // Retrieve vault address from UserDefaults
    func getVaultAddress() -> String? {
        return UserDefaults.standard.string(forKey: vaultAddressKey)
    }

    // Clear vault address from UserDefaults
    func clearVaultAddress() {
        UserDefaults.standard.removeObject(forKey: vaultAddressKey)
    }

}
