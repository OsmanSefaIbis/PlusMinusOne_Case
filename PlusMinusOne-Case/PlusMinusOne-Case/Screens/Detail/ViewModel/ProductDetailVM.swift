//
//  ProductDetailVM.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

import Foundation

typealias DetailData = ProductDetailDataModel
// - Data Model: ProductDetail
struct ProductDetailDataModel {
    let id: Int
//    let name: String
//    let description: String
//    let imageUrl: String
//    let priceInfo: Price
}

// - Class Contract
protocol ContractForProductDetailVM: AnyObject {
    
    func viewDidLoad()
}
// - Class Communicator
protocol DelegateOfProductDetailVM: AnyObject {
    
    // TODO: Decide Next
}

final class ProductDetailVM {
    
    // - MVVM Variables
    lazy var model = ProductDetailModel()
    weak var view: ContractForProductDetailVC?
    weak var delegate: DelegateOfProductDetailVM?
    
    // - State Variables
    // TODO: Decide Next
    var data: RowItem?
    
    // - Lifecycle: Object
    init(view: ContractForProductDetailVC) {
        model.delegate = self
        self.view = view
    }
}

// - Contract Conformance
extension ProductDetailVM: ContractForProductDetailVM {
    
    func viewDidLoad() {
        view?.setupUserInterface()
    }
}

// - MVVM Notify
extension ProductDetailVM: DelegateOfProductDetailModel {
    
    // TODO: Handle Later
}

// - Helper Class Methods
extension ProductDetailVM {
    
    // TODO: Later
}
