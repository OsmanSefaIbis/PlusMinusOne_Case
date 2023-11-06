//
//  Products.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

struct ProductsDTO: Decodable {
    let results: [Product]?
}

struct Product: Decodable {
    let id: Int?
    let name, desc: String?
    let image: String?
    let price: Price?
}

struct Price: Decodable {
    let value: Double?
    let currency: String?
}
