//
//  MockProductDetailVC.swift
//  PlusMinusOne-CaseTests
//
//  Created by Sefa İbiş on 7.11.2023.
//

@testable import PlusMinusOne_Case

final class MockProductDetailVC: ContractForProductDetailVC {
    
    var counter_setupUserInterface = 0
    var counter_configureUserInterface = 0
    var counter_updateUIForSuccessState = 0
    var counter_updateUIForLoadingState = 0
    var counter_updateUIForErrorState = 0
    
    func setupUserInterface() {
        counter_setupUserInterface += 1
    }
    
    func configureUserInterface() {
        counter_configureUserInterface += 1
    }
    
    func updateUIForSuccessState() {
        counter_updateUIForSuccessState += 1
    }
    
    func updateUIForLoadingState() {
        counter_updateUIForLoadingState += 1
    }
    
    func updateUIForErrorState() {
        counter_updateUIForErrorState += 1
    }
}
