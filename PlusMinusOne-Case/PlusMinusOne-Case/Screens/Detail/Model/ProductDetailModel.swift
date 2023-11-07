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
    func didFailToModifySocials(with: Error)
    func didGetSocial(update: SocialFeed)
    func didFailRetrievalOfSocialFeed(with: Error)
}

final class ProductDetailModel {
    
    // - MVVM Variables
    weak var delegate: DelegateOfProductDetailModel?
    let modifiedFlag: Bool = true
    
    func modifySocials() {
//        DecoderService.decodeModifyEncodeSave(resource: "social", as: SocialInfo.self) { [weak self] result in
//            switch result {
//            case .success():
//                self?.delegate?.didModifySocials()
//            case .failure(let error):
//                self?.delegate?.didFailToModifySocials(with: error)
//            }
//        }
        
        // Intended to modify the JSON file but aborted because could not figure it out.
        // Faced with the problem: file-access
        if modifiedFlag {
            self.delegate?.didModifySocials()
        } else {
            let error = NSError(domain: "ProductDetailModel", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Failed to modify JSON in file social.json"])
            self.delegate?.didFailToModifySocials(with: error)
        }
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
