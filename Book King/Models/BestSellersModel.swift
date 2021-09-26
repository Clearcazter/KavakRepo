//
//  BestSellersModel.swift
//  Book King
//
//  Created by Adrian Guerrero on 26/09/21.
//

import Foundation

struct ResultsBestModel: Decodable {
    let results: BestSellersModel
}

struct BestSellersModel: Decodable {
    let bestSellers: [String]
}


