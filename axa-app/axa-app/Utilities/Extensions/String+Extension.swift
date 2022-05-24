//
//  String+Extension.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 5/5/22.
//

import Foundation

extension String {
    
    /**
     Convert this string to a `Bool` if it matches any of the following, else return `nil`.
     - `"True"`, `"true"`, `"yes"` and `"1"` return **true**.
     - `"False"`, `"false"`, `"no"` and `"0"` return **false**.
     - The rest of the strings return `nil`.

     - Returns: The generated `Bool` or `nil` if none were matched.
     */
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    /**
     Convert this string to `Double` or `nil` if your code can't.
     - Returns : The generated `Double` or `nil` if the casting was wrong.
     */
    func toDouble() -> Double? {
        return Double(self)
    }
    
    /**
     Convert this string to `Int` or `nil` if your code can't.
     - Returns : The generated `Int` or `nil` if the casting was wrong.
     */
    func toInt() -> Int? {
        return Int(self)
    }
}
