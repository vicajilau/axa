//
//  Double+Extension.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 5/5/22.
//

import Foundation

extension Double {
    
    /// Check if the decimal part is not zero
    func hasDecimalValue() -> Bool {
        if self == Double(integerValue()) {
            return false
        } else {
            return true
        }
    }
    
    /// Returns the integer part of the this double number
    func integerValue() -> Int {
        return Int(self)
    }
    
    func toStringWith(decimals: Int) -> String {
        return String(format: "%.\(decimals)f", self)
    }
}
