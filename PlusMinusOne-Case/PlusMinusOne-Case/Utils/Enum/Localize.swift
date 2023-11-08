//
//  Localize.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

import Foundation

/// An enum that serves as a central repository for strings that may be used for localization and acts as a control file for managing strings throughout the app's development.
public enum Localize: String {
    
    case decodeDomain
    case decodeDescriptionKey
    case modifySocialDomain
    case modifySocialDescriptionKey
    case nilSelfFatal
    case symbolOffline
    case symbolErrorTriangle
    case symbolHearth
    case labelErrorPrompt
    case identifierDetailPage
    case identifierCollectionView
    case identifierProductCell
    case fatalConfigurePrompt
    case getItemFailPrompt
    case symbolHalfStar
    case symbolMessage
    case symbolPrice
    case fatalDequeueCellPrompt
    
    /// Retrieves the raw string associated with each enum case.
    func raw() -> String {
        
        switch self {
            
        case .decodeDomain: return "DecoderService.decode"
        case .decodeDescriptionKey: return "JSON file not found in project directory."
        case .modifySocialDomain: return "modifySocials()"
        case .modifySocialDescriptionKey: return "Failed to modify JSON in file social.json"
        case .nilSelfFatal: return "Unexpected nil self"
        case .symbolOffline: return "wifi.exclamationmark"
        case .symbolErrorTriangle: return "exclamationmark.triangle.fill"
        case .symbolHearth: return "heart.fill"
        case .labelErrorPrompt: return "Update social failed."
        case .identifierDetailPage: return "detailPageUserInterfaceTestIdentifier"
        case .fatalConfigurePrompt: return "Invalid operation during populating UI."
        case .getItemFailPrompt: return "Unable to get item."
        case .identifierCollectionView: return "collectionViewUserInterfaceTestIdentifier"
        case .identifierProductCell: return "ProductCell"
        case .symbolHalfStar: return "star.leadinghalf.filled"
        case .symbolMessage: return "message.fill"
        case .symbolPrice: return "banknote.fill"
        case .fatalDequeueCellPrompt: return "Failed to dequeue cell for CollectionView in ProductGalleryVC"
        }
    }
    
}
