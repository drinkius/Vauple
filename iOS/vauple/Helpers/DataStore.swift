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

    // Store value in UserDefaults
    func setValueForKey(_ key: String, value: String) {
        UserDefaults.standard.set(value, forKey: key)
    }

    // Retrieve value from UserDefaults
    func geValue(_ key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
}
