//
//  Defaults.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 13.11.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import UIKit

protocol OptionalProperty {
    var isNil: Bool { get }
}

extension Optional : OptionalProperty {
    var isNil: Bool { self == nil }
}

@propertyWrapper
struct DefaultsProperty<T> {
    
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: self.key) as? T ?? self.defaultValue
        }
        set {
            if let value = newValue as? OptionalProperty, value.isNil {
                UserDefaults.standard.removeObject(forKey: key)
            } else {
                UserDefaults.standard.set(newValue, forKey: key)
            }
            UserDefaults.standard.synchronize()
        }
    }
}

@propertyWrapper
public struct DefaultsPropertyCodable<T: Codable> {
    let key: String
    let defaultValue: T? = nil
    
    public var wrappedValue: T? {
        get {
            if let r = UserDefaults.standard.object(forKey: key) as? Data,
               let orgVal = try? JSONDecoder().decode(T.self, from: r) {
                return orgVal
            }
            return defaultValue
        }
        set {
            if let n = newValue {
                let s = try! JSONEncoder().encode(n)
                UserDefaults.standard.set(s, forKey: key)
            } else {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
}

class Defaults {
    
    @DefaultsProperty(key: "IsAuthorized", defaultValue: false)
    static var isAuthorized: Bool
    
    class func reset() {
        isAuthorized = false
    }
    
}
