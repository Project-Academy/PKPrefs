//
//  Untitled.swift
//  PKPrefs
//
//  Created by Sarfraz Basha on 3/3/2025.
//

import Foundation

/**
 See https://www.swiftbysundell.com/articles/property-wrappers-in-swift/ for further reading on how this model was built.
 */

/// Property Wrapper for Persisting values to UserDefaults.
@propertyWrapper
public struct Prefs<Value: Codable> {
    
    //--------------------------------------
    // MARK: - VARIABLES -
    //--------------------------------------
    private let defaultValue: Value
    private var storage: UserDefaults = .standard
    
    public let key: String
    public var wrappedValue: Value {
        get {
            if let v = storage.object(forKey: key) as? Value { return v }
            if let d = storage.data(forKey: key),
               let x = try? JSONDecoder().decode(Value.self, from: d) {
                return x
               }
            return defaultValue
        }
        set {
            guard let opt = newValue as? AnyOptional, opt.isNil
            else {
                do {
                    let data = try JSONEncoder().encode(newValue)
                        storage.setValue(data, forKey: key)
                        return
                    
                } catch { print("error", error) }
                storage.setValue(newValue, forKey: key)
                return
            }
            storage.removeObject(forKey: key)
        }
    }
    
    //--------------------------------------
    // MARK: - INITIALISERS -
    //--------------------------------------
    public init(wrappedValue defaultValue: Value,
         _ key: String,
         storage: UserDefaults = .standard) {
        self.defaultValue = defaultValue
        self.key = key
        self.storage = storage
    }
}
