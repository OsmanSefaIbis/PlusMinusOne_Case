//
//  ProductDetailVM.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

import Foundation

enum ProductDetailSocialState: Equatable {
    static func == (lhs: ProductDetailSocialState, rhs: ProductDetailSocialState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case let (.error(lhsError), .error(rhsError)):
            // Compare the errors, you can use their `localizedDescription` or other properties.
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.success, .success):
            return true
        default:
            return false
        }
    }
    
    case loading
    case error(Error)
    case success
}

// - Class Contract
protocol ContractForProductDetailVM: AnyObject {
    
    //    var view: ContractForProductDetailVC? { get set }
    func viewDidLoad()
    func getData(_ property: ProductDataAccessor) -> Any?
    func getLatestSocial() -> Social?
    func didEndCountdown()
    func updateSocial(of id: Int)
    func setUpdatedSocial()
    func updateUserInterface(for state: ProductDetailSocialState)
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
    var timer: Timer?
    var socialState: ProductDetailSocialState = .success {
        didSet {
            updateUserInterface(for: socialState)
        }
    }
    
    // - Lifecycle: Object
    init(view: ContractForProductDetailVC) {
        model.delegate = self
        self.view = view
    }
}

// - Contract Conformance
extension ProductDetailVM: ContractForProductDetailVM {
    
    func viewDidLoad() {
        socialState = .success // Data is available at first
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
        socialState = .loading
        model.modifySocials()
    }
    
    func updateUserInterface(for state: ProductDetailSocialState) {
        switch state {
        case .success:
            view?.updateUIForSuccessState()
        case .loading:
            view?.updateUIForLoadingState()
        case .error(_):
            view?.updateUIForErrorState()
        }
    }
    
    func updateSocial(of id: Int) {
        model.getSocial(with: id)
    }
    
    func setUpdatedSocial() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] timer in
            guard let self = self else { fatalError("Unexpected nil self") }
            socialState = .success
            timer.invalidate()
        }
    }
}

// - MVVM Notify
extension ProductDetailVM: DelegateOfProductDetailModel {
    func didFailToModifySocials(with: Error) {
        socialState = .error(with)
    }
    
    func didFailRetrievalOfSocialFeed(with: Error) {
        socialState = .error(with)
    }
    
    func didModifySocials() {
        // Assumed that the social.json is updated
        delegate?.updateSocials()
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
