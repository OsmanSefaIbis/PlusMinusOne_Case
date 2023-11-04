//
//  ProductGalleryModel.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

import Foundation

// - Renaming
typealias ProductsInfo = ProductsDTO
typealias SocialInfo = SocialDTO

// - Class Communicator
protocol DelegateOfProductGalleryModel: AnyObject {
    func didGetProducts()
    func didGetSocialFeed()
    func didFailRetrievalOfProducts(with: Error)
    func didFailRetrievalOfSocialFeed(with: Error)
}

final class ProductGalleryModel {
    
    // - MVVM Variables
    weak var delegate: DelegateOfProductGalleryModel?
    // - Data Variables
    private(set) var products: [Product] = []
    private(set) var socials: [SocialFeed] = []
    
    func getProducts(){
        
        DecoderService.decode(resource: "product", as: ProductsInfo.self) { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response.results else { return } // FIXME: Return
                self?.products = data
                self?.delegate?.didGetProducts()
            case .failure(let error):
                self?.delegate?.didFailRetrievalOfProducts(with: error)
            }
        }
    }

    func getSocials() {
        
        DecoderService.decode(resource: "social", as: SocialInfo.self) { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response.results else { return } // FIXME: Return
                self?.socials = data
                self?.delegate?.didGetSocialFeed()
            case .failure(let error):
                self?.delegate?.didFailRetrievalOfSocialFeed(with: error)
            }
        }
    }
}
