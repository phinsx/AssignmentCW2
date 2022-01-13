//
//  Helper.swift
//  Assignment
//
//  Created by k ph on 8/1/2022.
//

import Foundation
import UIKit

class Helper{
    
    static func isPasswordValid(_ password : String) -> Bool{
        let passwordFormat = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordTest.evaluate(with: password)
    }
}
