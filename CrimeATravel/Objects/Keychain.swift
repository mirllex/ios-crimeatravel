//
//  Keychain.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 13.11.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
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
    
    @KeychainProperty(key: "AccessToken")
    static var accessToken: String?
    
    @KeychainProperty(key: "Device_id")
    static var deviceToken: String?
    
    class func reset() {
        accessToken = nil
        deviceToken = nil
    }
}
