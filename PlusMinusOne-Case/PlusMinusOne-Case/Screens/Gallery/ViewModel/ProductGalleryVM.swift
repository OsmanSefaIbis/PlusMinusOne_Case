//
//  ProductGalleryVM.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

import Foundation

// - Renaming
typealias RowItem = ProductCellDataModel
typealias DetailData = ProductCellDataModel

// - Class Contract
protocol ContractForProductGalleryVM: AnyObject {
    
    var items: [RowItem] { get set }
    var itemsCount: Int { get }
    var columnPreference: Int { get }
    var delegate: DelegateOfProductGalleryVM? { get set }
    func viewDidLoad()
    func getItem(at index: IndexPath) -> RowItem?
    func didSelectItem(at index: IndexPath)
}
// - Class Communicator
protocol DelegateOfProductGalleryVM: AnyObject {
    
    func didLoadProducts()
    func didLoadSocialFeed()
}

final class ProductGalleryVM: ContractForProductGalleryVM{
    
    // - MVVM Prop's
    private lazy var model: ContractOfProductGalleryModel = ProductGalleryModel()
    weak var view: ContractForProductGalleryVC?
    weak var delegate: DelegateOfProductGalleryVM?
    
    // - State Prop's
    var items: [RowItem] = []
    var itemsCount: Int { get { items.count} }
    var columnPreference: Int = 2 // optionalTODO: singular OR grid preference
    
    // - Life-cycle: Object
    init(view: ContractForProductGalleryVC) {
        model.delegate = self
        self.view = view
    }
    
    // - Contract Conformance
    func viewDidLoad() {
        view?.setupUserInterface()
        view?.setupDelegates()
        model.getProducts()
        model.getSocials()
    }
    
    func getItem(at index: IndexPath) -> RowItem? {
        guard index.item < itemsCount else { return nil }
        return items[index.item]
    }
    
    func didSelectItem(at index: IndexPath) {
        guard let data = getItem(at: index) else { fatalError(Localize.getItemFailPrompt.raw())}
        view?.navigateToDetail(pass: data)
    }
}

// - MVVM Notify
extension ProductGalleryVM: DelegateOfProductGalleryModel {
    
    func didGetProducts() {
        let data: [RowItem] = model.products.map {
            return RowItem(
                id: $0.id ?? 0,
                productBrand: $0.name ?? "",
                productType: $0.desc ?? "",
                imageUrl: $0.image ?? "",
                priceInfo: $0.price ?? .init(value: nil, currency: nil),
                currentSocialFeed: nil
            )
        }
        items = data
        self.delegate?.didLoadProducts()
    }
    
    func didGetSocialFeed() {
        let data: [SocialFeed] = model.socials.map {
            return SocialFeed(
                id: $0.id ?? 0,
                social: $0.social ?? .init(likeCount: nil, commentCounts: nil)
            )
        }
        
        for socialFeed in data {
            if let id = socialFeed.id {
                if let index = items.firstIndex(where: { $0.id == id }) {
                    items[index].currentSocialFeed = socialFeed.social
                }
            }
        }
        self.delegate?.didLoadSocialFeed()
    }
    
    func didFailRetrievalOfProducts(with: Error) {
        // Not in scope.
    }
    
    func didFailRetrievalOfSocialFeed(with: Error) {
        // Not in scope.
    }
}

// - Helper Class Methods
extension ProductGalleryVM {
    // Ready
}
