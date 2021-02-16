//
//  TransactionModal.swift
//  DB1-test
//
//  Created by Suporte on 16/02/21.
//

import Foundation

struct Transaction:Codable {
    let status: String
    let  name: String
    let unit: String
    let period: String
    let description: String
    let values: [Axis]?
    
}

struct Axis:Codable{
    let x:Double
    let y:Double
}
