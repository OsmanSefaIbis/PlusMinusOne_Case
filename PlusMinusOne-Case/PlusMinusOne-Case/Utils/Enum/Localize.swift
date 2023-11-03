//
//  Localize.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

import Foundation

/// An enum that serves as a central repository for strings that may be used for localization and acts as a control file for managing strings throughout the app's development.
public enum Localize: String {
    
    case handle
    
    /// Retrieves the raw string associated with each enum case.
    func raw() -> String {
        
        switch self {
            
        case .handle: return "Handle text"
        }
    }
    
}
