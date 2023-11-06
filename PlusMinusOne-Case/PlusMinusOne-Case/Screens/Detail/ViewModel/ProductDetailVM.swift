//
//  ProductDetailVM.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

import Foundation

//typealias DetailData = ProductDetailDataModel // TODO: Delete

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
    func getData(_ property: ProductDataAccessor) -> Any?
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
    var data: DetailData?
    
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
        view?.populateUserInterface()
    }
    
    func getData(_ property: ProductDataAccessor) -> Any? {
        guard let productData = data else { return nil }

        let mirror = Mirror(reflecting: productData)
        for (key, value) in mirror.children {
            if key == property.rawValue {
                return value
            }
        }
        return nil
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
