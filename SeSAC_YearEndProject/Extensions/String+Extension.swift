//
//  String+Extension.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/06.
//

import Foundation

extension String {
    func isValidString() -> Bool {
        if self.removeSpace().count > 0 {
            return true
        }
        
        return false
    }
    
    func removeSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }
}
