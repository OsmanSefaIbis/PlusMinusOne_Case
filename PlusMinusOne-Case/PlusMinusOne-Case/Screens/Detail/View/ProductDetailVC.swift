//
//  ProductDetail.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 2.11.2023.
//

import UIKit
import Kingfisher
import Cosmos

// - Class Contract
protocol ContractForProductDetailVC: AnyObject {
    
    func setupUserInterface()
    func populateUserInterface()
}

final class ProductDetailVC: UIViewController {
    
    // - MVVM Variables
    lazy var viewModel = ProductDetailVM(view: self)
    
    // - State Variables
    var productId: Int?
    
    // Life-cycle: Object
    init(data: DetailData){
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        viewModel.data = data
        productId = data.id
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Life-cycle: View
    override func viewDidLoad(){
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupCountDown()
    }
    
    // - User Interface Variables
    private let scrollView: UIScrollView = {
        // Opted for a scroll view in the detail page to accommodate potential future use-cases.
        // TODO: Make the product image top anchor to the superView topAnchor, so that
        // alsoTODO: Consider the navigation bar, make it .clear
        let sv = UIScrollView()
        sv.backgroundColor = .green
        return sv
    }()
    private let contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()
    private let vStackViewContainer: UIStackView = {
        UIStackView(axis: .vertical)
    }()
    private let imageViewContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemBackground
        iv.image = .init(systemName: "photo.fill")
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
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        v.layer.borderWidth = 1.5
        v.layer.borderColor = UIColor.systemGray5.cgColor
        v.backgroundColor = .systemGray6
        return v
    }()
    private let hStackViewProductInformation: UIStackView = {
        UIStackView(axis: .horizontal, backgroundColor: .clear)
    }()
    private let vStackViewProductInformationLeftSide: UIStackView = {
        UIStackView(axis: .vertical, distribution: .equalSpacing, backgroundColor: .clear)
    }()
    private let vStackViewProductInformationRightSide: UIStackView = {
        // TODO: distribution: .fillEqually --> then aspect ratio for desired look
        UIStackView(axis: .vertical, distribution: .fillEqually, backgroundColor: .clear)
    }()
    private let hStackProductInformationLeftSideFirstRow: UIStackView = {
        UIStackView(axis: .horizontal, distribution: .fillProportionally, backgroundColor: .clear)
    }()
    private let hStackProductInformationLeftSideSecondRow: UIStackView = {
        UIStackView(axis: .horizontal, alignment: .center, distribution: .fillProportionally, backgroundColor: .clear)
    }()
    private let hStackProductInformationLeftSideThirdRow: UIStackView = {
        UIStackView(axis: .horizontal, alignment: .bottom, distribution: .fillEqually, backgroundColor: .clear)
    }()
    private let labelProductBrand: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.font = UIFont.boldSystemFont(ofSize: 25)
        l.backgroundColor = .clear
        return l
    }()
    private let labelProductType: UILabel = {
        let l = UILabel()
        l.textColor = .systemGray2
        l.font = UIFont.italicSystemFont(ofSize: 15)
        l.backgroundColor = .clear
        return l
    }()
    private let labelProductRatingFloat: UILabel = {
        let l = UILabel()
        l.textColor = .systemOrange
        l.textAlignment = .right
        l.font = UIFont.boldSystemFont(ofSize: 12)
        l.backgroundColor = .clear
        return l
    }()
    private let starRatingView: CosmosView = {
        let cv = CosmosView()
        cv.backgroundColor = .clear
        cv.tintColor = .systemOrange
        cv.settings.fillMode = .precise
        cv.settings.starSize = 25
        cv.isUserInteractionEnabled = false
        return cv
    }()
    private let labelProductCommentTotal: UILabel = {
        let l = UILabel()
        l.textColor = .systemOrange
        l.textAlignment = .left
        l.font = UIFont.boldSystemFont(ofSize: 12)
        l.backgroundColor = .clear
        return l
    }()
    private let labelPricing: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.font = UIFont.boldSystemFont(ofSize: 30)
        l.backgroundColor = .clear
        return l
    }()
    private let imageViewHearth: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.image = UIImage(systemName: "heart.fill")
        iv.tintColor = .red
        return iv
    }()
    private let labelLikeCount: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 15)
        l.textColor = .systemGray2
        l.textAlignment = .center
        l.backgroundColor = .clear
        return l
    }()
    private let countDownViewContainer = UIView()
} // - Class End

// - MVVM Notify
extension ProductDetailVC: DelegateOfProductDetailVM {
    // TODO: Handle Later
}

// - Contract Conformance
extension ProductDetailVC: ContractForProductDetailVC {
    
    // TODO: Better Naming
    func setupUserInterface() {
        setupFirstly() // View related setup
        setupSecondly() // Outmost related setup
        setupThirdly() // Product information-related setup
        setupFourthly() // Product information left and right side related setups
    }
    
    func populateUserInterface() {
        /// Populating UI variables with data
        configureProductImage()
        configureProductBrand()
        configureProductType()
        configureProductAverageRating()
        configureProductRatingStarScalar()
        configureProductCommentCountTotal()
        configureProductPrice()
        configureProductLikeCount()
    }
}

// - Helper Class Methods
extension ProductDetailVC {
    
    private func setupFirstly() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupSecondly() {
        setupScrollView()
        setupContentView()
        setupOutMostStackView()
        setupImageViewContainer()
        setupProductInformationContainerView()
    }
    
    private func setupThirdly() {
        setupProductInformationView()
        setupProductInformationStackView()
    }
    
    private func setupFourthly() {
        setupRightOfProductInformationStackView()
        setupLeftOfProductInformationStackView()
        
        setupFirstRowOnLeftSideOfProductInformation()
        setupSecondRowOnLeftSideOfProductInformation()
        setupThirdRowOnLeftSideOfProductInformation()
    }
    
    private func setupScrollView() {
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    private func setupContentView() {
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
    
    private func setupOutMostStackView() {
        contentView.addSubview(vStackViewContainer)
        vStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStackViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            vStackViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            vStackViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStackViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vStackViewContainer.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            vStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        vStackViewContainer.addArrangedSubview(imageViewContainer)
        vStackViewContainer.addArrangedSubview(productInformationContainerView)
        
        imageViewContainer.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
        productInformationContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8 ).isActive = true
    }
    
    private func setupImageViewContainer() {
        imageViewContainer.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: imageViewContainer.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor)
        ])
    }
    
    private func setupProductInformationContainerView() {
        productInformationContainerView.addSubview(productInformationView)
        productInformationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productInformationView.topAnchor.constraint(equalTo: productInformationContainerView.topAnchor, constant: CGFloat(5)),
            productInformationView.leadingAnchor.constraint(equalTo: productInformationContainerView.leadingAnchor, constant: CGFloat(15)),
            productInformationView.trailingAnchor.constraint(equalTo: productInformationContainerView.trailingAnchor, constant: CGFloat(-15)),
            productInformationView.heightAnchor.constraint(equalTo: productInformationContainerView.heightAnchor, multiplier: 1/4)
        ])
    }
    
    private func setupProductInformationView() {
        productInformationView.addSubview(hStackViewProductInformation)
        hStackViewProductInformation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStackViewProductInformation.topAnchor.constraint(equalTo: productInformationView.topAnchor),
            hStackViewProductInformation.bottomAnchor.constraint(equalTo: productInformationView.bottomAnchor),
            hStackViewProductInformation.leadingAnchor.constraint(equalTo: productInformationView.leadingAnchor),
            hStackViewProductInformation.trailingAnchor.constraint(equalTo: productInformationView.trailingAnchor)
        ])
    }
    
    private func setupProductInformationStackView() {
        hStackViewProductInformation.addArrangedSubview(vStackViewProductInformationLeftSide)
        hStackViewProductInformation.addArrangedSubview(vStackViewProductInformationRightSide)
        
        vStackViewProductInformationLeftSide.widthAnchor.constraint(equalTo: hStackViewProductInformation.widthAnchor, multiplier: 3/4).isActive = true
        vStackViewProductInformationRightSide.widthAnchor.constraint(equalTo: hStackViewProductInformation.widthAnchor, multiplier: 1/4).isActive = true
    }
    
    private func setupLeftOfProductInformationStackView() {
        vStackViewProductInformationLeftSide.addArrangedSubview(hStackProductInformationLeftSideFirstRow)
        vStackViewProductInformationLeftSide.addArrangedSubview(hStackProductInformationLeftSideSecondRow)
        vStackViewProductInformationLeftSide.addArrangedSubview(hStackProductInformationLeftSideThirdRow)
    }
    private func setupRightOfProductInformationStackView() {
        vStackViewProductInformationRightSide.addArrangedSubview(imageViewHearth)
        vStackViewProductInformationRightSide.addArrangedSubview(labelLikeCount)
        vStackViewProductInformationRightSide.addArrangedSubview(countDownViewContainer)
    }
    
    private func setupFirstRowOnLeftSideOfProductInformation() {
        hStackProductInformationLeftSideFirstRow.addArrangedSubview(labelProductBrand)
        hStackProductInformationLeftSideFirstRow.addArrangedSubview(labelProductType)
    }
    
    private func setupSecondRowOnLeftSideOfProductInformation() {
        hStackProductInformationLeftSideSecondRow.addArrangedSubview(labelProductRatingFloat)
        hStackProductInformationLeftSideSecondRow.addArrangedSubview(starRatingView)
        hStackProductInformationLeftSideSecondRow.addArrangedSubview(labelProductCommentTotal)
    }
    
    private func setupThirdRowOnLeftSideOfProductInformation() {
        hStackProductInformationLeftSideThirdRow.addArrangedSubview(labelPricing)
    }
    
    private func setupCountDown() {
        let countDownView = CircularTimerView(frame: countDownViewContainer.bounds)
        countDownViewContainer.addSubview(countDownView)
        countDownView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countDownView.topAnchor.constraint(equalTo: countDownViewContainer.topAnchor),
            countDownView.leadingAnchor.constraint(equalTo: countDownViewContainer.leadingAnchor),
            countDownView.centerXAnchor.constraint(equalTo: countDownViewContainer.centerXAnchor),
            countDownView.centerYAnchor.constraint(equalTo: countDownViewContainer.centerYAnchor),
        ])
    }
}

extension ProductDetailVC {
    private func configureProductImage() {
        guard let productImageUrlString = viewModel.getData(.imageUrl) as? String
        else { fatalError("Invalid operation during populating UI.")}
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError("Unexpected nil self") }
            self.imageView.kf.setImage(
                with: URL(string: productImageUrlString),
                placeholder: nil,
                options: [.cacheMemoryOnly],
                progressBlock: nil
            )
        }
    }
    private func configureProductBrand() {
        guard let productBrandName = viewModel.getData(.productBrand) as? String
        else { fatalError("Invalid operation during populating UI.")}
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError("Unexpected nil self") }
            self.labelProductBrand.text = productBrandName
        }
    }
    private func configureProductType() {
        guard let productType = viewModel.getData(.productType) as? String
        else { fatalError("Invalid operation during populating UI.")}
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError("Unexpected nil self") }
            self.labelProductType.text = productType
        }
    }
    private func configureProductAverageRating() {
        guard let socialFeed = viewModel.getData(.currentSocialFeed) as? Social,
              let ratingFloat = socialFeed.commentCounts?.averageRating as? Double
        else { fatalError("Invalid operation during populating UI.")}
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError("Unexpected nil self") }
            self.labelProductRatingFloat.text = String(ratingFloat)
        }
    }
    private func configureProductRatingStarScalar() {
        guard let socialFeed = viewModel.getData(.currentSocialFeed) as? Social,
              let ratingFloat = socialFeed.commentCounts?.averageRating as? Double
        else { fatalError("Invalid operation during populating UI.")}
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError("Unexpected nil self") }
            self.starRatingView.rating = ratingFloat
        }
    }
    private func configureProductCommentCountTotal() {
        guard let socialFeed = viewModel.getData(.currentSocialFeed) as? Social,
              let commentCountOfAnonymous = socialFeed.commentCounts?.anonymousCommentsCount as? Int,
            let commentCountOfMember = socialFeed.commentCounts?.anonymousCommentsCount as? Int
        else { fatalError("Invalid operation during populating UI.")}
        let commentTotal = commentCountOfAnonymous + commentCountOfMember
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError("Unexpected nil self") }
            self.labelProductCommentTotal.text = "Comment: \(commentTotal)"
        }
    }
    private func configureProductPrice() {
        guard let productPriceInfo = viewModel.getData(.priceInfo) as? Price,
              let productCurrency = productPriceInfo.currency,
                let productUnitPrice = productPriceInfo.value
        else { fatalError("Invalid operation during populating UI.")}
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError("Unexpected nil self") }
            self.labelPricing.text = "\(productCurrency)".appending(String(productUnitPrice))
        }
    }
    private func configureProductLikeCount() {
        guard let socialFeed = viewModel.getData(.currentSocialFeed) as? Social,
              let productLikeCount = socialFeed.likeCount
        else { fatalError("Invalid operation during populating UI.")}
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError("Unexpected nil self") }
            self.labelLikeCount.text = String(productLikeCount)
        }
    }
    
}
