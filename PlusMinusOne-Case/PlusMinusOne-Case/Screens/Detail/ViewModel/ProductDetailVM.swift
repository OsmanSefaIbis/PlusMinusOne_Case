//
//  ProductDetailVM.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

import Foundation

// - Class Contract
protocol ContractForProductDetailVM: AnyObject {
    
    func viewDidLoad()
    func getData(_ property: ProductDataAccessor) -> Any?
    func getLatestSocial() -> Social?
    func didEndCountdown()
    func updateSocial(of id: Int)
    func setUpdatedSocial()
}
// - Class Communicator
protocol DelegateOfProductDetailVM: AnyObject {
    
    func updateSocials()
    func didLoadSocial()
}

final class ProductDetailVM {
    
    // - MVVM Variables
    lazy var model = ProductDetailModel()
    weak var view: ContractForProductDetailVC?
    weak var delegate: DelegateOfProductDetailVM?
    
    // - State Variables
    var data: DetailData?
    var latestUpdatedSocial: Social?
    
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
        view?.configureUserInterface()
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
    
    func getLatestSocial() -> Social? {
        guard let data = latestUpdatedSocial else { return nil }
        return data
    }
    
    func didEndCountdown() {
        model.modifySocials()
    }
    
    func updateSocial(of id: Int) {
        model.getSocial(with: id)
    }
    
    func setUpdatedSocial() {
        view?.setUpdatedSocial()
    }
}

// - MVVM Notify
extension ProductDetailVM: DelegateOfProductDetailModel {
    func didFailRetrievalOfSocialFeed(with: Error) {
        // TODO: Later
    }
    
    
    func didModifySocials() {
        delegate?.updateSocials()
    }
    
    func didFailModifySocials() {
        // TODO: Later
    }
    
    func didGetSocial(update: SocialFeed) {
        latestUpdatedSocial = update.social
        delegate?.didLoadSocial()
    }
}

// - Helper Class Methods
extension ProductDetailVM {
    
    // TODO: Later
}
