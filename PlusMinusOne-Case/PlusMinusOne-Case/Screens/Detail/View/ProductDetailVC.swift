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
    init(id: Int){
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        viewModel.productId = id
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
        self.view.backgroundColor = .systemBackground
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// - MVVM Notify
extension ProductDetailVC: DelegateOfProductDetailVM {
    // TODO: Handle Later
}


// - Helper Class Methods
extension ProductDetailVC {
    // TODO: Later
}
