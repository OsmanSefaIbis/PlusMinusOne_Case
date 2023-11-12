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
    var counter_setNavigationBarItemToSingular = 0
    var counter_setNavigationBarItemToGrid = 0
    var flag_navigateToDetail = false
    var passedData: RowItem?
    
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
        flag_navigateToDetail = true
    }
    
    func setNavigationBarItemToSingular() {
        counter_setNavigationBarItemToSingular += 1
    }
    
    func setNavigationBarItemToGrid() {
        counter_setNavigationBarItemToGrid += 1
    }
}
