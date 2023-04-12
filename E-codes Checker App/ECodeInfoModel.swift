//
//  ECodeInfoModel.swift
//  E-codes Checker App
//
//  Created by Oleksii Chumak on 06.01.2023.
//

import Foundation

class ECodeInfoModel: Identifiable, CustomStringConvertible {
    var description: String {
        return "(E-code: E-\(eCode), Name: \(name), ColorAndUsage: \(descriptionColorAndUsage), Status: \(status)"
    }
    
    public var eCode: String = ""
    public var name: String = ""
    public var descriptionColorAndUsage: String = ""
    public var status: String = ""
}
