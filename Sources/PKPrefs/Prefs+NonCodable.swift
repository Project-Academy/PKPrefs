//
//  NonCodablePrefs.swift
//  PKPrefs
//
//  Created by Sarfraz Basha on 3/3/2025.
//

import Foundation

/**
 See https://www.swiftbysundell.com/articles/property-wrappers-in-swift/ for further reading on how this model was built.
 */

/// Property Wrapper for Persisting values to UserDefaults.
/// - warning:
/// This does **not** work for custom objects, even if Codable.
/// You must instead declare it as Data and JSONDecode it yourself.
@propertyWrapper
public struct NonCodablePrefs<Value> {
    
    //--------------------------------------
    // MARK: - VARIABLES -
    //--------------------------------------
    private let defaultValue: Value
    private var storage: UserDefaults = .standard
    
    public let key: String
    public var wrappedValue: Value {
        get { storage.object(forKey: key) as? Value ?? defaultValue }
        set {
            guard let opt = newValue as? AnyOptional, opt.isNil
            else { storage.setValue(newValue, forKey: key); return }
            storage.removeObject(forKey: key)
        }
    }
    
    //--------------------------------------
    // MARK: - INITIALISERS -
    //--------------------------------------
    init(wrappedValue defaultValue: Value,
         _ key: String,
         storage: UserDefaults = .standard) {
        self.defaultValue = defaultValue
        self.key = key
        self.storage = storage
    }
}
