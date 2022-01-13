//
//  Keychain.swift
//  Theeye
//
//  Created by Murad Ibrohimov on 13.11.21.
//  Copyright © 2021 Theeye. All rights reserved.
//

import Foundation
import KeychainSwift

private let keychain = KeychainSwift()

@propertyWrapper
struct KeychainProperty {
    
    private let key: String

    init(key: String) {
        self.key = key
    }

    var wrappedValue: String? {
        get {
            return keychain.get(self.key)
        }
        set {
            if let value = newValue {
                keychain.set(value, forKey: self.key)
            } else {
                keychain.delete(self.key)
            }
        }
    }
}

class Keychain {
    
    @KeychainProperty(key: "Token")
    static var token: String?
    
    @KeychainProperty(key: "Device_id")
    static var deviceToken: String?
    
    class func reset() {
        token = nil
        deviceToken = nil
    }
}
