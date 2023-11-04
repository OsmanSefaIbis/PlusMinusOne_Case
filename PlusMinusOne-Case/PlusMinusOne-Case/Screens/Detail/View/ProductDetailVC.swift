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
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        return sv
    }()
    private let imageViewContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = .init(systemName: "Profile")
        iv.tintColor = .red
        return iv
    }()
    private let productInformationContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()
    private let productInformationView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()
    private let hStackViewProductInformation: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        return sv
    }()
    private let vStackViewProductInformationLeftSide: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .leading
        sv.distribution = .fillEqually
        return sv
    }()
    private let hStackProductInformationLeftSideFirstRow: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.alignment = .leading
        return sv
    }()
    private let labelProductBrand = UILabel()
    private let labelProductType = UILabel()
    private let hStackProductInformationLeftSideSecondRow: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .leading
        sv.distribution = .fillProportionally
        return sv
    }()
    private let labelProductRatingFloat = UILabel()
    private let starRatingView: UIView = {
        // TODO: spm https://github.com/evgenyneu/Cosmos
        let v = UIView()
        v.backgroundColor = .systemPink
        return v
    }()
    private let labelProductCommentTotal = UILabel()
    private let hStackProductInformationLeftSideThirdRow: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .leading
        sv.distribution = .equalCentering
        return sv
    }()
    private let labelPricing = UILabel()
    private let vStackViewProductInformationRightSide: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .equalCentering
        return sv
    }()
    private let imageViewHearth = UIImageView()
    private let labelLikeCount = UILabel()
    private let countDownView: UIView = {
        // TODO: spm https://github.com/relatedcode/ProgressHUD
        let v = UIView()
        v.backgroundColor = .systemPink
        return v
    }()
} // - Class End

// - Contract Conformance
extension ProductDetailVC: ContractForProductDetailVC {
    
    func setupUserInterface() {
        setupFirstly() // view related
        setupSecondly() // outmost related
        //setupThirdly() // productInformation related
        //setupFourthly() // productInformation left side related
        //setupFifthly() // productInformation right side related
    }
}

// - MVVM Notify
extension ProductDetailVC: DelegateOfProductDetailVM {
    // TODO: Handle Later
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
//        setupOutMostStackView()
//        setupImageViewContainer()
//        setupProductInformationContainerView()
    }
    
    func setupThirdly() {
        setupProductInformationView()
        setupProductInformationStackView()
    }
    
    func setupFourthly() {
        setupLeftOfProductInformationStackView()
        setupFirstRowOnLeftSideOfProductInformation()
        setupSecondRowOnLeftSideOfProductInformation()
        setupThirdRowOnLeftSideOfProductInformation()
    }
    
    func setupFifthly() {
        setupRightOfProductInformationStackView()
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
        //TODO: Delete some constraints
        let heightConstraintContentView = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        let widthConstraintContentView = contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        
        widthConstraintContentView.isActive = true
        widthConstraintContentView.priority = UILayoutPriority(50)
        heightConstraintContentView.isActive = true
        heightConstraintContentView.priority = UILayoutPriority(50)
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
            vStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        vStackViewContainer.addArrangedSubview(imageViewContainer)
        vStackViewContainer.addArrangedSubview(productInformationContainerView)
        
        // TODO: Shorten Naming
        let heightRatioConstraintBetweenImageAndProductInformationViews = imageViewContainer.heightAnchor.constraint(equalTo: productInformationContainerView.heightAnchor, multiplier: 2/3)
        heightRatioConstraintBetweenImageAndProductInformationViews.isActive = true
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
        let widthConstraintRatioLeftRight = vStackViewProductInformationRightSide.heightAnchor.constraint(equalTo: vStackViewProductInformationLeftSide.heightAnchor, multiplier: 1/4)
        widthConstraintRatioLeftRight.isActive = true
    }
    
    func setupLeftOfProductInformationStackView() {
        vStackViewProductInformationLeftSide.addArrangedSubview(hStackProductInformationLeftSideFirstRow)
        vStackViewProductInformationLeftSide.addArrangedSubview(hStackProductInformationLeftSideSecondRow)
        vStackViewProductInformationLeftSide.addArrangedSubview(hStackProductInformationLeftSideThirdRow)
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
    
    func setupRightOfProductInformationStackView() {
        vStackViewProductInformationRightSide.addArrangedSubview(imageViewHearth)
        vStackViewProductInformationRightSide.addArrangedSubview(labelLikeCount)
        vStackViewProductInformationRightSide.addArrangedSubview(imageViewHearth)
    }
}
