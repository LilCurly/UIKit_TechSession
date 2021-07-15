//
//  PurchasableModel.swift
//  TestApp
//
//  Created by Roman Muzikantov on 14/07/2021.
//

import Foundation

class PurchasableModel: Hashable {
    
    static func == (lhs: PurchasableModel, rhs: PurchasableModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum ItemType {
        case meat
        case onions
        case bacon
        case tomato
        case pickles
        case cucumber
        case cheese
        case bum
    }
    
    var itemType: ItemType
    var price: Float
    var name: String
    var id: Int = 0
    
    init(itemType: ItemType, price: Float, name: String) {
        self.itemType = itemType
        self.price = price
        self.name = name
    }
}
