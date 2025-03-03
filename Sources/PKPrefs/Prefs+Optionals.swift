//
//  Optionals.swift
//  PKPrefs
//
//  Created by Sarfraz Basha on 3/3/2025.
//

import Foundation

//--------------------------------------
// MARK: - HANDLING OPTIONALS -
//--------------------------------------
// Since our property wrapper's Value type isn't optional, but
// can still contain nil values, we'll have to introduce this
// protocol to enable us to cast any assigned value into a type
// that we can compare against nil:
internal protocol AnyOptional {
    var isNil: Bool { get }
}
extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}



public extension Prefs where Value: ExpressibleByNilLiteral {
    init(_ key: String, storage: UserDefaults = .standard) {
        self.init(wrappedValue: nil, key, storage: storage)
    }
}
public extension NonCodablePrefs where Value: ExpressibleByNilLiteral {
    init(_ key: String, storage: UserDefaults = .standard) {
        self.init(wrappedValue: nil, key, storage: storage)
    }
}


