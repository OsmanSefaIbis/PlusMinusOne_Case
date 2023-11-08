//
//  ProductDetailSocialState.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 8.11.2023.
//

import Foundation

enum ProductDetailSocialState: Equatable {
        
    case loading
    case error(Error)
    case success
    
    static func == (lhs: ProductDetailSocialState, rhs: ProductDetailSocialState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case let (.error(lhsError), .error(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.success, .success):
            return true
        default:
            return false
        }
    }
}
