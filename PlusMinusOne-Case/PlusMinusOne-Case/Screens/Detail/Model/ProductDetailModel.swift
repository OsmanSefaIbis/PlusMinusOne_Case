//
//  ProductDetailModel.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

import Foundation

// - Class Communicator
protocol DelegateOfProductDetailModel: AnyObject {
    func didModifySocials()
    func didFailModifySocials()
    func didGetSocial(update: SocialFeed)
    func didFailRetrievalOfSocialFeed(with: Error)
}

final class ProductDetailModel {
    
    // - MVVM Variables
    weak var delegate: DelegateOfProductDetailModel?
    
    func modifySocials() {
        // TODO: Modify Data
        self.delegate?.didModifySocials()
    }
    
    func getSocial(with productId: Int) {
        DecoderService.decode(resource: "social", as: SocialInfo.self) { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response.results else { return } // FIXME: Return
                guard let social = data.first(where: { $0.id == productId }) else { return } // TODO: handle
                self?.delegate?.didGetSocial(update: social)
            case .failure(let error):
                self?.delegate?.didFailRetrievalOfSocialFeed(with: error)
            }
        }
    }
    
}
