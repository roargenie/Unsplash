//
//  String+Ex.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import Foundation

extension String {
    
    func limitString(limitCount: Int) -> String {
        if self.count > limitCount {
            let index = self.index(self.startIndex, offsetBy: limitCount)
            return String( self[..<index] )
        }
        return self
    }
    
    func isValidEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    
}
