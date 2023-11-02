//
//  ProductGalleryVM.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

import Foundation

// - Class Contract
protocol ContractForProductGalleryVM: AnyObject {
    
    func viewDidLoad()
}
// - Class Communicator
protocol DelegateOfProductGalleryVM: AnyObject {
    
    // TODO: Decide Next
}

final class ProductGalleryVM {
    
    // - MVVM Variables
    lazy var model = ProductGalleryModel()
    weak var view: ContractForProductGalleryVC?
    weak var delegate: DelegateOfProductGalleryVM?
    
    // - State Variables
    // TODO: Decide Next
    
    // - Lifecycle: Object
    init(view: ContractForProductGalleryVC) {
        model.delegate = self
        self.view = view
    }
}

// - Contract Conformance
extension ProductGalleryVM: ContractForProductGalleryVM {
    
    func viewDidLoad() {
        view?.setupUserInterface()
    }
}

// - MVVM Notify
extension ProductGalleryVM: DelegateOfProductGalleryModel {
    
    // TODO: Handle Later
}

// - Class Helpers
extension ProductGalleryVM {
    
    // TODO: Later
}
