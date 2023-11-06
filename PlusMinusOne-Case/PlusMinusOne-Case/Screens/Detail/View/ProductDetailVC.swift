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
    func configureUserInterface()
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
    // TODO: Group View types under comment
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .systemBackground
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
        UIImageView(systemName: "photo.fill", tintColor: .systemRed, contentMode: .scaleAspectFill)
    }()
    private let productLikeContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
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
        UIStackView(axis: .horizontal, backgroundColor: .clear)
    }()
    private let vStackViewProductInformationLeftSide: UIStackView = {
        UIStackView(axis: .vertical, distribution: .equalSpacing, backgroundColor: .clear)
    }()
    private let vStackViewProductInformationRightSide: UIStackView = {
        UIStackView(axis: .vertical, spacing: 10, distribution: .fillEqually, backgroundColor: .clear)
    }()
    private let vStackViewInnerOfProductInformationRightSize: UIStackView = {
        UIStackView(axis: .vertical, backgroundColor: .clear)
    }()
    private let hStackProductInformationLeftSideFirstRow: UIStackView = {
        UIStackView(axis: .horizontal, alignment: .center, backgroundColor: .clear)
    }()
    private let hStackProductInformationLeftSideSecondRow: UIStackView = {
        UIStackView(axis: .horizontal, alignment: .center, backgroundColor: .clear)
    }()
    private let hStackProductInformationLeftSideThirdRow: UIStackView = {
        UIStackView(axis: .horizontal, alignment: .center, distribution: .fillEqually, backgroundColor: .clear)
    }()
    private let labelProductBrand: UILabel = {
        UILabel.customLabel(textColor: .black, textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 20))
    }()
    private let labelProductType: UILabel = {
        UILabel.customLabel(textColor: .systemGray2, textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 15))
    }()
    private let labelProductRatingFloat: UILabel = {
        UILabel.customLabel(textColor: .systemOrange, textAlignment: .right, font: UIFont.boldSystemFont(ofSize: 15))
    }()
    private let starRatingView: CosmosView = {
        let cv = CosmosView()
        cv.backgroundColor = .clear
        cv.tintColor = .systemOrange
        cv.settings.fillMode = .precise
        cv.settings.starSize = 20
        cv.isUserInteractionEnabled = false
        return cv
    }()
    private let labelProductCommentTotal: UILabel = {
        UILabel.customLabel(textColor: .systemOrange, textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 15))
    }()
    private let labelPricing: UILabel = {
        UILabel.customLabel(textColor: .black, textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 25))
    }()
    private let imageViewHearth: UIImageView = {
        UIImageView(systemName: "heart.fill", tintColor: .systemRed)
    }()
    private let labelLikeCount: UILabel = {
        UILabel.customLabel(textColor: .systemGray2, textAlignment: .center, font: UIFont.boldSystemFont(ofSize: 15))
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
    
    func configureUserInterface() {
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
        self.edgesForExtendedLayout = .top
        self.navigationController?.navigationBar.backgroundColor = .clear
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
        
        setupFirstRowOfProductInformationStackViewRightSide()
        setupInnerOfProductInformationStackViewRightSide()
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
            contentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
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
        
        imageViewContainer.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/3).isActive = true
        productInformationContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 2/3).isActive = true
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
            productInformationView.heightAnchor.constraint(equalTo: productInformationContainerView.heightAnchor, multiplier: 1/5)
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
        
        vStackViewProductInformationLeftSide.widthAnchor.constraint(equalTo: hStackViewProductInformation.widthAnchor, multiplier: 8/9).isActive = true
        vStackViewProductInformationRightSide.widthAnchor.constraint(equalTo: hStackViewProductInformation.widthAnchor, multiplier: 1/9).isActive = true
    }
    
    private func setupLeftOfProductInformationStackView() {
        vStackViewProductInformationLeftSide.addArrangedSubview(hStackProductInformationLeftSideFirstRow)
        vStackViewProductInformationLeftSide.addArrangedSubview(hStackProductInformationLeftSideSecondRow)
        vStackViewProductInformationLeftSide.addArrangedSubview(hStackProductInformationLeftSideThirdRow)
    }
    
    private func setupRightOfProductInformationStackView() {
        vStackViewProductInformationRightSide.addArrangedSubview(productLikeContainerView)
        vStackViewProductInformationRightSide.addArrangedSubview(countDownViewContainer)
    }
    
    private func setupFirstRowOfProductInformationStackViewRightSide() {
        productLikeContainerView.addSubview(vStackViewInnerOfProductInformationRightSize)
        let inset = CGFloat(5)
        vStackViewInnerOfProductInformationRightSize.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStackViewInnerOfProductInformationRightSize.topAnchor.constraint(equalTo: productLikeContainerView.topAnchor, constant: inset),
            vStackViewInnerOfProductInformationRightSize.bottomAnchor.constraint(equalTo: productLikeContainerView.bottomAnchor, constant: -inset),
            vStackViewInnerOfProductInformationRightSize.leadingAnchor.constraint(equalTo: productLikeContainerView.leadingAnchor, constant: inset),
            vStackViewInnerOfProductInformationRightSize.trailingAnchor.constraint(equalTo: productLikeContainerView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func setupInnerOfProductInformationStackViewRightSide() {
        vStackViewInnerOfProductInformationRightSize.addArrangedSubview(imageViewHearth)
        vStackViewInnerOfProductInformationRightSize.addArrangedSubview(labelLikeCount)
        
        imageViewHearth.heightAnchor.constraint(equalTo: vStackViewInnerOfProductInformationRightSize.heightAnchor, multiplier: 2/3).isActive = true
//        let spacing = (vStackViewInnerOfProductInformationRightSize.heightAnchor)*(1/3) -
        labelLikeCount.heightAnchor.constraint(equalTo: vStackViewInnerOfProductInformationRightSize.heightAnchor, multiplier: 1/3).isActive = true
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
            let commentCountOfMember = socialFeed.commentCounts?.memberCommentsCount as? Int
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
            self.labelPricing.text = String(productUnitPrice).appending(" \(productCurrency)")
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
