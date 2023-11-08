//
//  MockProductGalleryVC.swift
//  PlusMinusOne-CaseTests
//
//  Created by Sefa İbiş on 8.11.2023.
//

@testable import PlusMinusOne_Case

final class MockProductGalleryVC: ContractForProductGalleryVC {
    
    var counter_setupUserInterface = 0
    var counter_setupDelegates = 0
    var counter_reloadCollectionView = 0
    var counter_navigateToDetail = 0
    
    func setupUserInterface() {
        counter_setupUserInterface += 1
    }
    
    func setupDelegates() {
        counter_setupDelegates += 1
    }
    
    func reloadCollectionView() {
        counter_reloadCollectionView += 1
    }
    
    func navigateToDetail(pass data: PlusMinusOne_Case.DetailData) {
        counter_navigateToDetail += 1
    }
}
