//
//  ProductDetailVM.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

import Foundation

// - Class Contract
protocol ContractForProductDetailVM: AnyObject {

    var delegate: DelegateOfProductDetailVM? { get set }
    var data: DetailData? { get set }
    var latestUpdatedSocial: Social? { get set }
    var socialState: ProductDetailSocialState { get set }
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

final class ProductDetailVM: ContractForProductDetailVM {
    // - MVVM Prop's
    private lazy var model: ContractOfProductDetailModel = ProductDetailModel()
    weak var view: ContractForProductDetailVC?
    weak var delegate: DelegateOfProductDetailVM?
    
    // - State Prop's
    var data: DetailData?
    var latestUpdatedSocial: Social?
    var socialState: ProductDetailSocialState = .success {
        didSet {
            updateUserInterface(for: socialState)
        }
    }
    private var timer: Timer?
    private var internet: InternetManager { InternetManager.shared }
    
    // - Lifecycle: Object
    init(view: ContractForProductDetailVC) {
        model.delegate = self
        self.view = view
    }
    
    // - Contract Conformance
    func viewDidLoad() {
        view?.setupUserInterface()
        view?.configureUserInterface()
        connectivityCheck()
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
            guard let self = self else { fatalError(Localize.nilSelfFatal.raw()) }
            socialState = .success
            timer.invalidate()
        }
    }
}   // - Class End

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
    
    func connectivityCheck() {
        if !internet.isOnline() {
            view?.configureOfflineProductImage()
        }
    }
}
