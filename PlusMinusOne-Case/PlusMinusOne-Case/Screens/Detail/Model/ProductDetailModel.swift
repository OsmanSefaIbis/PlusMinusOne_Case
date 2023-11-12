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
// - Class Contract
protocol ContractOfProductDetailModel {
    var delegate: DelegateOfProductDetailModel? { get set }
    func modifySocials()
    func getSocial(with productId: Int)
}

final class ProductDetailModel: ContractOfProductDetailModel{
    
    weak var delegate: DelegateOfProductDetailModel? // - MVVM prop
    private var modifiedFlag: Bool = true // error appearance on UI make -> false
    
    func modifySocials() {
        if modifiedFlag {
            self.delegate?.didModifySocials()
        } else {
            let error = NSError(domain: Localize.modifySocialDomain.raw(), code: 1004, userInfo: [NSLocalizedDescriptionKey: Localize.modifySocialDescriptionKey.raw()])
            modifiedFlag.toggle()
            self.delegate?.didFailToModifySocials(with: error)
        }
    }
    func getSocial(with productId: Int) {
        DecoderService.decode(resource: "social", as: SocialInfo.self) { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response.results else { return }
                guard let social = data.first(where: { $0.id == productId }) else { return }
                self?.delegate?.didGetSocial(update: social)
            case .failure(let error):
                self?.delegate?.didFailRetrievalOfSocialFeed(with: error)
            }
        }
    }
    
    // Intended to modify the JSON file but aborted because could not figure it out.
    // Faced with the problem: file-access
    // abortedTODO: Update Local JSON File
    
    /*
    func modifySocials() {
        DecoderService.decodeModifyEncodeSave(resource: "social", as: SocialInfo.self) { [weak self] result in
            switch result {
            case .success():
                self?.delegate?.didModifySocials()
            case .failure(let error):
                self?.delegate?.didFailToModifySocials(with: error)
            }
        }
    }
    */
    
}

