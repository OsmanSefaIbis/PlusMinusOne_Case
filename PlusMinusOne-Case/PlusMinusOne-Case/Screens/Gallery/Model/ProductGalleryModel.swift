//
//  ProductGalleryModel.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

import Foundation

// - Class Communicator
protocol DelegateOfProductGalleryModel: AnyObject {
    
    // TODO: Decide Next
}

final class ProductGalleryModel {
    
    // - MVVM Variables
    weak var delegate: DelegateOfProductGalleryModel?
}
