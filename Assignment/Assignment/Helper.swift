//
//  Helper.swift
//  
//
//  Created by k ph on 8/1/2022.
//

import Foundation
import UIKit

class Helper{
    
    static func isPasswordValid(_ password : String) -> Bool{
        let password = NSPredicate(format: "SELF MATCHES %@",
            "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&][8,]")
        return password.evaluate(with: passwd)
    }
}
