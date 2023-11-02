//
//  ProductDetailModel.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

import Foundation

// - Class Communicator
protocol DelegateOfProductDetailModel: AnyObject {
    
    // TODO: Decide Next
}

final class ProductDetailModel {
    
    // - MVVM Variables
    weak var delegate: DelegateOfProductDetailModel?
}
