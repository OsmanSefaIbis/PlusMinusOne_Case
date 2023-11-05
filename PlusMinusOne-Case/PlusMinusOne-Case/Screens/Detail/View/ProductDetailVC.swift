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
    init(data: RowItem){
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        viewModel.data = data
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
    private let scrollView: UIScrollView = {
        // Opted for a scroll view in the detail page to accommodate potential future use-cases.
        let sv = UIScrollView()
        sv.backgroundColor = .green
        return sv
    }()
    private let contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        return v
    }()
    private let vStackViewContainer: UIStackView = {
        UIStackView(axis: .vertical, backgroundColor: .purple)
    }()
    private let imageViewContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .yellow
        return v
    }()
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.image = .init(systemName: "photo.fill")
        iv.tintColor = .red
        return iv
    }()
    private let productInformationContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemOrange
        v.backgroundColor = .brown
        return v
    }()
    private let productInformationView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()
    private let hStackViewProductInformation: UIStackView = {
        UIStackView(axis: .horizontal)
    }()
    private let vStackViewProductInformationLeftSide: UIStackView = {
        UIStackView(axis: .vertical, distribution: .fillEqually, backgroundColor: .systemPurple)
    }()
    private let vStackViewProductInformationRightSide: UIStackView = {
        UIStackView(axis: .vertical, distribution: .fillEqually, backgroundColor: .gray)
    }()
    private let hStackProductInformationLeftSideFirstRow: UIStackView = {
        UIStackView(axis: .horizontal, distribution: .fillEqually, backgroundColor: .red)
    }()
    private let hStackProductInformationLeftSideSecondRow: UIStackView = {
        UIStackView(axis: .horizontal, distribution: .fillEqually, backgroundColor: .green)
    }()
    private let hStackProductInformationLeftSideThirdRow: UIStackView = {
        UIStackView(axis: .horizontal, distribution: .fillEqually, backgroundColor: .blue)
    }()
    private let labelProductBrand: UILabel = {
        let l = UILabel()
        l.backgroundColor = .black
        return l
    }()
    private let labelProductType: UILabel = {
        let l = UILabel()
        l.backgroundColor = .magenta
        return l
    }()
    private let labelProductRatingFloat: UILabel = {
        let l = UILabel()
        l.backgroundColor = .orange
        return l
    }()
    private let starRatingView: UIView = {
        // TODO: spm https://github.com/evgenyneu/Cosmos
        let v = UIView()
        v.backgroundColor = .systemPink
        return v
    }()
    private let labelProductCommentTotal: UILabel = {
        let l = UILabel()
        l.backgroundColor = .black
        return l
    }()
    private let labelPricing: UILabel = {
        let l = UILabel()
        l.backgroundColor = .purple
        return l
    }()
    private let imageViewHearth: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.image = UIImage(systemName: "heart.fill")
        iv.tintColor = .red
        return iv
    }()
    private let labelLikeCount: UILabel = {
        let l = UILabel()
        l.backgroundColor = .orange
        return l
    }()
    private let imageViewSocialUpdateCountDown: UIImageView = {
        // TODO: spm https://github.com/relatedcode/ProgressHUD
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.image = UIImage(systemName: "timelapse")
        iv.tintColor = .systemPink
        return iv
    }()
} // - Class End

// - MVVM Notify
extension ProductDetailVC: DelegateOfProductDetailVM {
    // TODO: Handle Later
}

// - Contract Conformance
extension ProductDetailVC: ContractForProductDetailVC {
    
    func setupUserInterface() {
        setupFirstly() // View related setup
        setupSecondly() // Outmost related setup
        setupThirdly() // Product information-related setup
        setupFourthly() // Product information left and right side related setups
    }
}

// - Helper Class Methods
extension ProductDetailVC {
    
    func setupFirstly() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupSecondly() {
        setupScrollView()
        setupContentView()
        setupOutMostStackView()
        setupImageViewContainer()
        setupProductInformationContainerView()
    }
    
    func setupThirdly() {
        setupProductInformationView()
        setupProductInformationStackView()
    }
    
    func setupFourthly() {
        setupRightOfProductInformationStackView()
        setupLeftOfProductInformationStackView()
        
        setupFirstRowOnLeftSideOfProductInformation()
        setupSecondRowOnLeftSideOfProductInformation()
        setupThirdRowOnLeftSideOfProductInformation()
    }
    
    func setupScrollView() {
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ])
        let heightConstraintContentView = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        let widthConstraintContentView = contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        
        [heightConstraintContentView, widthConstraintContentView].forEach {
            $0.isActive = true
            $0.priority = UILayoutPriority(50)
        }
    }
    
    func setupOutMostStackView() {
        contentView.addSubview(vStackViewContainer)
        vStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //TODO: Delete some constraints
            vStackViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            vStackViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            vStackViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStackViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vStackViewContainer.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            vStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        vStackViewContainer.addArrangedSubview(imageViewContainer)
        vStackViewContainer.addArrangedSubview(productInformationContainerView)
        
        // TODO: Shorten Naming
        imageViewContainer.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
        productInformationContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8 ).isActive = true
    }
    
    func setupImageViewContainer() {
        imageViewContainer.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: imageViewContainer.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor)
        ])
    }
    
    func setupProductInformationContainerView() {
        productInformationContainerView.addSubview(productInformationView)
        productInformationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productInformationView.topAnchor.constraint(equalTo: productInformationContainerView.topAnchor),
            productInformationView.leadingAnchor.constraint(equalTo: productInformationContainerView.leadingAnchor),
            productInformationView.trailingAnchor.constraint(equalTo: productInformationContainerView.trailingAnchor),
            productInformationView.heightAnchor.constraint(equalTo: productInformationContainerView.heightAnchor, multiplier: 1/4)
        ])
    }
    
    func setupProductInformationView() {
        productInformationView.addSubview(hStackViewProductInformation)
        hStackViewProductInformation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStackViewProductInformation.topAnchor.constraint(equalTo: productInformationView.topAnchor),
            hStackViewProductInformation.bottomAnchor.constraint(equalTo: productInformationView.bottomAnchor),
            hStackViewProductInformation.leadingAnchor.constraint(equalTo: productInformationView.leadingAnchor),
            hStackViewProductInformation.trailingAnchor.constraint(equalTo: productInformationView.trailingAnchor)
        ])
    }
    
    func setupProductInformationStackView() {
        hStackViewProductInformation.addArrangedSubview(vStackViewProductInformationLeftSide)
        hStackViewProductInformation.addArrangedSubview(vStackViewProductInformationRightSide)
        
        vStackViewProductInformationLeftSide.widthAnchor.constraint(equalTo: hStackViewProductInformation.widthAnchor, multiplier: 3/4).isActive = true
        vStackViewProductInformationRightSide.widthAnchor.constraint(equalTo: hStackViewProductInformation.widthAnchor, multiplier: 1/4).isActive = true
    }
    
    func setupLeftOfProductInformationStackView() {
        vStackViewProductInformationLeftSide.addArrangedSubview(hStackProductInformationLeftSideFirstRow)
        vStackViewProductInformationLeftSide.addArrangedSubview(hStackProductInformationLeftSideSecondRow)
        vStackViewProductInformationLeftSide.addArrangedSubview(hStackProductInformationLeftSideThirdRow)
    }
    func setupRightOfProductInformationStackView() {
        vStackViewProductInformationRightSide.addArrangedSubview(imageViewHearth)
        vStackViewProductInformationRightSide.addArrangedSubview(labelLikeCount)
        vStackViewProductInformationRightSide.addArrangedSubview(imageViewSocialUpdateCountDown)
    }
    
    func setupFirstRowOnLeftSideOfProductInformation() {
        hStackProductInformationLeftSideFirstRow.addArrangedSubview(labelProductBrand)
        hStackProductInformationLeftSideFirstRow.addArrangedSubview(labelProductType)
    }
    
    func setupSecondRowOnLeftSideOfProductInformation() {
        hStackProductInformationLeftSideSecondRow.addArrangedSubview(labelProductRatingFloat)
        hStackProductInformationLeftSideSecondRow.addArrangedSubview(starRatingView)
        hStackProductInformationLeftSideSecondRow.addArrangedSubview(labelProductCommentTotal)
    }
    
    func setupThirdRowOnLeftSideOfProductInformation() {
        hStackProductInformationLeftSideThirdRow.addArrangedSubview(labelPricing)
    }
    
}
