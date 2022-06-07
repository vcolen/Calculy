//
//  String+Extension.swift
//  Calculy
//
//  Created by Victor Colen on 04/06/22.
//

import Foundation

extension String {
    
    subscript(desiredIndex: Int) -> Character {
        return self[index(startIndex, offsetBy: desiredIndex)]
    }
    
    subscript(range: ClosedRange<Int>) -> String {
        return String(self[index(startIndex, offsetBy: range.lowerBound)...index(startIndex, offsetBy: range.upperBound)])
    }
    
    subscript(range: Range<Int>) -> String {
        return String(self[index(startIndex, offsetBy: range.lowerBound)..<index(startIndex, offsetBy: range.upperBound)])
    }
    
}
