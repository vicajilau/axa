//
//  Utils.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 23/4/22.
//

import Foundation

class Utils {
    
    /// Makes a call to the print function of the system controlling that they are not carried out in RELEASE mode
    static func print(_ object: Any) {
        #if DEBUG
        Swift.print(object)
        #endif
    }
    
    /// Makes a call to the print function of the system controlling that they are not carried out in RELEASE mode
    static func print(_ object: Any...) {
        #if DEBUG
        for item in object {
            Swift.print(item)
        }
        #endif
    }
    
    /// Makes a call to the print error function of the system controlling that they are not carried out in RELEASE mode
    static func printError(_ object: Any) {
        Utils.print("ERROR: \(object)‼️")
    }
    
    /// Makes a call to the print error function of the system controlling that they are not carried out in RELEASE mode
    static func printError(_ object: Any...) {
        Utils.print("ERROR: \(object)‼️")
    }
    
    /// Causes a controlled failure in the app.
    /// ```
    /// controlledFailure(message: "There is no a loaded weather") // Controlled Failure: There is no a loaded weather.
    /// ```
    ///
    /// - Parameter message: The seed message to justify the failure condition.
    static func controlledFailure(message: String) -> Never {
        preconditionFailure("Controlled Failure: \(message)")
    }
}
