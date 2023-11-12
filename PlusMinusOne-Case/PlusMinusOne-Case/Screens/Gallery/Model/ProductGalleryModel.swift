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
// - Class Contract
protocol ContractOfProductGalleryModel {
    
    var delegate: DelegateOfProductGalleryModel? { get set }
    var products: [Product] { get }
    var socials: [SocialFeed] { get }
    func getProducts()
    func getSocials()
}

final class ProductGalleryModel: ContractOfProductGalleryModel {
    
    // - MVVM Prop
    var delegate: DelegateOfProductGalleryModel?
    // - Data Prop's
    var products: [Product] = []
    var socials: [SocialFeed] = []
    
    func getProducts(){
        
        DecoderService.decode(resource: "product", as: ProductsInfo.self) { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response.results else { return }
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
                guard let data = response.results else { return }
                self?.socials = data
                self?.delegate?.didGetSocialFeed()
            case .failure(let error):
                self?.delegate?.didFailRetrievalOfSocialFeed(with: error)
            }
        }
    }
}
