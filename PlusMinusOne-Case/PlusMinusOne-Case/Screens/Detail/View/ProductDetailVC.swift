//
//  ProductDetail.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 2.11.2023.
//

import UIKit

// - Class Contract
protocol ContractForProductDetailVC: AnyObject {
    
    func setupUserInterface()
}

final class ProductDetailVC: UIViewController {
    
    // - MVVM Variables
    lazy var viewModel = ProductDetailVM(view: self)
    
    // Life-cycle: Object
    init(){
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Life-cycle: View
    override func viewDidLoad(){
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    // - User Interface Variables
    // TODO: Decide Next
}

// - Contract Conformance
extension ProductDetailVC: ContractForProductDetailVC {
    
    func setupUserInterface() {
        self.view.backgroundColor = .orange
    }
}

// - MVVM Notify
extension ProductDetailVC: DelegateOfProductDetailVM {
    // TODO: Handle Later
}


// - Class Helpers
extension ProductDetailVC {
    // TODO: Later
}
