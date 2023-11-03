//
//  ProductGalleryVM.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

import Foundation

// - Renaming
typealias RowItem = ProductCellDataModel

// - Class Contract
protocol ContractForProductGalleryVM: AnyObject {
    
    func viewDidLoad()
    func getItem(at index: IndexPath) -> RowItem?
    func didSelectItem(at index: IndexPath)
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
    private var items: [RowItem] = Array(repeating: RowItem(id: 1), count: 30)
    var itemsCount: Int { get { items.count } }
    var columnPreference: Int = 1
    
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
        view?.setupDelegates()
    }
    
    func getItem(at index: IndexPath) -> RowItem? {
        guard index.item < itemsCount else { return nil }
        return items[index.item]
    }
    
    func didSelectItem(at index: IndexPath) {
        // TODO: Detail Page Routing
        guard let productId = getItem(at: index)?.id else { fatalError("Unable.")} // FIXME: return
        view?.navigateToDetail(by: productId)
    }
}

// - MVVM Notify
extension ProductGalleryVM: DelegateOfProductGalleryModel {
    
    // TODO: Handle Later
}

// - Helper Class Methods
extension ProductGalleryVM {
    
    
}
