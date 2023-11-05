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
    
    func didLoadProducts()
    func didLoadSocialFeed()
}

final class ProductGalleryVM {
    
    // - MVVM Variables
    lazy var model = ProductGalleryModel()
    weak var view: ContractForProductGalleryVC?
    weak var contract: ContractForProductGalleryVM? // TODO: later
    weak var delegate: DelegateOfProductGalleryVM?
    
    // - State Variables
    // TODO: Decide Next
    private var items: [RowItem] = []
    private var feeds: [Int : Social] = [:] // ThinkTODO: is trivial, delete or use it in another way
    var itemsCount: Int { get { items.count } }
    var columnPreference: Int = 1 // TODO: Handle Later
    
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
        model.getProducts()
        // FIXME: Normally upon products arrival, triggering a id based retrieval is suitable
        // Populated socials as a id-social pair, not quite sure for now, might change
        model.getSocials()
    }
    
    func getItem(at index: IndexPath) -> RowItem? {
        guard index.item < itemsCount else { return nil }
        return items[index.item]
    }
    
    func didSelectItem(at index: IndexPath) {
        guard let data = getItem(at: index) else { fatalError("Unable.")} // FIXME: return
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
                feeds[id] = socialFeed.social // trivial
                if let index = items.firstIndex(where: { $0.id == id }) {
                    items[index].currentSocialFeed = socialFeed.social
                }
            }
        }
        self.delegate?.didLoadSocialFeed()
    }
    
    func didFailRetrievalOfProducts(with: Error) {
        // TODO: Handle Later
    }
    
    func didFailRetrievalOfSocialFeed(with: Error) {
        // TODO: Handle Later
    }
}

// - Helper Class Methods
extension ProductGalleryVM {
    
    
}
