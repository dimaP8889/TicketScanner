//
//  Keychain.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 20.06.2021.
//

import Foundation

import Foundation

final class Keychain {
    
    static let shared = Keychain()
    private init() {}
}

// MARK: - Get
extension Keychain {
    
    func get(_ key: String) -> String? {
        if let data = getData(key) {
            if let currentString = String(data: data, encoding: .utf8) {
                return currentString
            }
        }
        return nil
    }
    
    func getBool(_ key: String) -> Bool? {
        guard let data = getData(key) else { return nil }
        guard let firstBit = data.first else { return nil }
        return firstBit == 1
    }
    
    func getData(_ key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass.string        : kSecClassGenericPassword,
            kSecAttrAccount.string  : key,
            kSecReturnData.string   : true,
            kSecMatchLimit.string   : kSecMatchLimitOne
        ]
        var result: AnyObject?
        let code = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        if code == noErr {
            return result as? Data
        } else {
            return nil
        }
    }
}

// MARK: - Set
extension Keychain {
    
    func set(_ value: String, forKey key: String) -> Int32? {
        if let data = value.data(using: String.Encoding.utf8) {
            return set(data, forKey: key)
        }
        // Random created number
        return -4004001
    }
    
    func set(_ value: Bool, forKey key: String) -> Int32? {
        let bytes: [UInt8] = value ? [1] : [0]
        let data = Data(bytes)
        return set(data, forKey: key)
    }
    
    func set(_ value: Data, forKey key: String) -> Int32? {
        _ = delete(by: key)
        let query: [String : Any] = [
            kSecClass.string            : kSecClassGenericPassword,
            kSecAttrAccount.string      : key,
            kSecValueData.string        : value,
            kSecAttrAccessible.string   : kSecAttrAccessibleWhenUnlocked.string
        ]
        let code = SecItemAdd(query as CFDictionary, nil)
        return code == noErr ? nil : code
    }
}

// MARK: - Delete
extension Keychain {
    
    @discardableResult
    func delete(by key: String) -> Int32? {
        let query: [String: Any] = [
            kSecClass.string        : kSecClassGenericPassword,
            kSecAttrAccount.string  : key
        ]
        let code = SecItemDelete(query as CFDictionary)
        return code == noErr ? nil : code
    }
}

fileprivate extension CFString {
    
    var string: String {
        return self as String
    }
}

// MARK: - Clear
extension Keychain {
    
    func clear() {
        Keychain.shared.removeAccess()
    }
}
