//
//  ViewController.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 2.11.2023.
//

import UIKit

// - Class Contract
protocol ContractForProductGalleryVC: AnyObject {
    
    func setupUserInterface()
}

final class ProductGalleryVC: UIViewController {
    
    // - MVVM Variables
    lazy var viewModel = ProductGalleryVM(view: self)
    
    // Life-cycle: Object
    init(){
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Life-cycle: View
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    // - User Interface Variables
    // TODO: Decide Next
}

// - Contract Conformance
extension ProductGalleryVC: ContractForProductGalleryVC {
    
    func setupUserInterface() {
        self.view.backgroundColor = .magenta
    }
}

extension ProductGalleryVC: DelegateOfProductGalleryVM {
    
    // TODO: Handle Later
}

// - Class Helpers
extension ProductGalleryVC {
    // TODO: Later
}

