//
//  ProductDetail.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 2.11.2023.
//

import UIKit
import Kingfisher

// - Class Contract
protocol ContractForProductDetailVC: AnyObject {
    
    func setupUserInterface()
    func configureUserInterface()
    func updateUIForSuccessState()
    func updateUIForLoadingState()
    func updateUIForErrorState()
    func configureOfflineProductImage()
}

final class ProductDetailVC: UIViewController {
    
    // - MVVM Variables
    private lazy var viewModel: ContractForProductDetailVM = ProductDetailVM(view: self)
    
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
    
    // --User Interface Variables--

    // - ScrollView
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .systemBackground
        return sv
    }()
    // - UIView's
    private let contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()
    private let imageViewContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
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
    private let countDownViewContainer = UIView()
    private let starContainerView = StarContainerView()
    // - StackView's
    private let vStackViewContainer: UIStackView = {
        UIStackView(axis: .vertical)
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
        UIStackView(axis: .horizontal,spacing: 10, alignment: .center, distribution: .fill, backgroundColor: .clear)
    }()
    private let hStackProductInformationLeftSideSecondRow: UIStackView = {
        UIStackView(axis: .horizontal, alignment: .center, distribution: .fillProportionally, backgroundColor: .clear)
    }()
    private let hStackProductInformationLeftSideThirdRow: UIStackView = {
        UIStackView(axis: .horizontal, alignment: .center, distribution: .fillEqually, backgroundColor: .clear)
    }()
    // - ImageView's
    private let imageView: UIImageView = {
        UIImageView(systemName: Localize.symbolOffline.raw(), tintColor: .systemGray4, contentMode: .scaleAspectFit)
    }()
    private let imageViewSocialError: UIImageView = {
        UIImageView(systemName: Localize.symbolErrorTriangle.raw(), tintColor: .systemOrange)
    }()
    private let imageViewOffline: UIImageView = {
        UIImageView(systemName: Localize.symbolOffline.raw(), tintColor: .systemGray4)
    }()
    // - Label's
    private let labelProductCommentTotal: UILabel = {
        UILabel.customLabel(textColor: .systemOrange, textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 15))
    }()
    private let labelPricing: UILabel = {
        UILabel.customLabel(textColor: .black, textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 25))
    }()
    private let imageViewHearth: UIImageView = {
        UIImageView(systemName: Localize.symbolHearth.raw(), tintColor: .systemRed)
    }()
    private let labelLikeCount: UILabel = {
        UILabel.customLabel(textColor: .systemGray2, textAlignment: .center, font: UIFont.boldSystemFont(ofSize: 15))
    }()
    private let labelErrorOccured: UILabel = {
        UILabel.customLabel(text: Localize.labelErrorPrompt.raw() , textColor: .systemGray3, textAlignment: .center, font: UIFont.boldSystemFont(ofSize: 10))
    }()
    private let labelProductBrand: UILabel = {
        UILabel.customLabel(textColor: .black, textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 20))
    }()
    private let labelProductType: UILabel = {
        UILabel.customLabel(textColor: .systemGray2, textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 15))
    }()
    private let labelProductRatingFloat: UILabel = {
        UILabel.customLabel(textColor: .systemOrange, textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 15))
    }()
    // - Spinner's
    private let spinnerMedium: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .systemOrange
        indicator.startAnimating()
        return indicator
    }()
    private let spinnerLarge: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .systemOrange
        indicator.startAnimating()
        return indicator
    }()
} // - Class End

// - MVVM Notify
extension ProductDetailVC: DelegateOfProductDetailVM {
    
    func updateSocials() {
        guard let id = self.productId else { return }
        viewModel.updateSocial(of: id)
    }
    
    func didLoadSocial() {
        viewModel.setUpdatedSocial()
    }
}

// - CountDown Notify
extension ProductDetailVC: DelegateOfCountDownView {
    
    func didEndCountdown() {
        viewModel.didEndCountdown()
    }
}

// - Contract Conformance
extension ProductDetailVC: ContractForProductDetailVC {
    
    func setupUserInterface() {
        setupViewInitials() // View related setup
        setupUISecondly() // Outmost related setup
        setupUIThirdly() // Product information-related setup
        setupUIFourthly() // Product information left and right side related setups
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

    func updateUIForSuccessState() {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { fatalError(Localize.nilSelfFatal.raw()) }
            self.removeSocials() // Remove Existing
            // Setup original UI
            self.setupSecondRowOnLeftSideOfProductInformation()
            self.setupFirstRowOfProductInformationStackViewRightSide()
            self.setupInnerOfProductInformationStackViewRightSide()
            self.setUpdatedSocial()
        }
    }
    
    func updateUIForLoadingState() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { fatalError(Localize.nilSelfFatal.raw()) }
            self.removeSocials() // Remove Existing
            // Add Spinner instead
            self.setupSpinnersForSocials()
        }
    }
    
    func updateUIForErrorState() {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { fatalError(Localize.nilSelfFatal.raw()) }
            self.removeSocials() // Remove Existing
            self.setupWithErrorAppearance() // Add error appearance instead
        }
    }
    
    func configureOfflineProductImage() {
        imageView.contentMode = .scaleAspectFit
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { fatalError(Localize.nilSelfFatal.raw()) }
            self.imageView.image = self.imageViewOffline.image
        }
    }
}
// - Update UI
extension ProductDetailVC {
    
    func setUpdatedSocial() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError(Localize.nilSelfFatal.raw()) }
            guard let socialFeed = self.viewModel.getLatestSocial(),
                  var productLikeCount = socialFeed.likeCount,
                  var productRatingFloat = socialFeed.commentCounts?.averageRating as? Double,
                  let commentCountOfAnonymous = socialFeed.commentCounts?.anonymousCommentsCount as? Int,
                  let commentCountOfMember = socialFeed.commentCounts?.memberCommentsCount as? Int
            else { return }
            
            // Assumed that the social.json was updated
            // Manually changed the social values to imply update, did a workaround
            var productCommentTotal = commentCountOfAnonymous + commentCountOfMember
            productCommentTotal += Int.random(in: 1...5)
            productLikeCount += Int.random(in: 1...30)
            productRatingFloat = (Double.random(in: 2...5) * 10.0).rounded() / 10.0
            
            self.labelProductRatingFloat.text = String(productRatingFloat)
            self.labelLikeCount.text = String(productLikeCount)
            self.labelProductCommentTotal.text = "Comment: \(productCommentTotal)"
            self.starContainerView.setRating(productRatingFloat)
        }
    }
}

// - Helper Class Methods
extension ProductDetailVC {
    
    private func setupViewInitials() {
        self.view.accessibilityIdentifier = Localize.identifierDetailPage.raw() // For: UI-Testing
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.view.backgroundColor = .systemBackground
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupUISecondly() {
        setupScrollView()
        setupContentView()
        setupOutMostStackView()
        setupImageViewContainer()
        setupProductInformationContainerView()
    }
    
    private func setupUIThirdly() {
        setupProductInformationView()
        setupProductInformationStackView()
    }
    
    private func setupUIFourthly() {
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
            contentView.topAnchor.constraint(equalTo: self.view.topAnchor), // change to scrollView.topAnchor
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            // contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor), //
            // contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor) //
            // Scalability Purpose --> do commented outs to make detail within a scrollView
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
        labelLikeCount.heightAnchor.constraint(equalTo: vStackViewInnerOfProductInformationRightSize.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    private func setupFirstRowOnLeftSideOfProductInformation() {
        hStackProductInformationLeftSideFirstRow.addArrangedSubview(labelProductBrand)
        hStackProductInformationLeftSideFirstRow.addArrangedSubview(labelProductType)
        labelProductBrand.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        labelProductType.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    private func setupSecondRowOnLeftSideOfProductInformation() {
        
        hStackProductInformationLeftSideSecondRow.addArrangedSubview(labelProductRatingFloat)
        hStackProductInformationLeftSideSecondRow.addArrangedSubview(starContainerView)
        hStackProductInformationLeftSideSecondRow.addArrangedSubview(labelProductCommentTotal)
        
        labelProductRatingFloat.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        starContainerView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        labelProductCommentTotal.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    private func setupThirdRowOnLeftSideOfProductInformation() {
        hStackProductInformationLeftSideThirdRow.addArrangedSubview(labelPricing)
    }
    
    private func setupCountDown() {
//         let countDownView = CountDownView(frame: countDownViewContainer.bounds, secondsInitial: 2)
        let countDownView = CountDownView(frame: countDownViewContainer.bounds)
        countDownView.delegate = self
        countDownViewContainer.addSubview(countDownView)
        countDownView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countDownView.topAnchor.constraint(equalTo: countDownViewContainer.topAnchor),
            countDownView.leadingAnchor.constraint(equalTo: countDownViewContainer.leadingAnchor),
            countDownView.centerXAnchor.constraint(equalTo: countDownViewContainer.centerXAnchor),
            countDownView.centerYAnchor.constraint(equalTo: countDownViewContainer.centerYAnchor),
        ])
    }
    
    private func removeSocials() {
        for subview in hStackProductInformationLeftSideSecondRow.arrangedSubviews {
            hStackProductInformationLeftSideSecondRow.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        for subview in vStackViewInnerOfProductInformationRightSize.arrangedSubviews {
            vStackViewInnerOfProductInformationRightSize.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
    
    private func setupSpinnersForSocials() {
        hStackProductInformationLeftSideSecondRow.addArrangedSubview(spinnerLarge)
        vStackViewInnerOfProductInformationRightSize.addArrangedSubview(spinnerMedium)
    }

    private func setupWithErrorAppearance() {
        hStackProductInformationLeftSideSecondRow.addArrangedSubview(labelErrorOccured)
        vStackViewInnerOfProductInformationRightSize.addArrangedSubview(imageViewSocialError)
    }
}
// - Configuration of UI variables
extension ProductDetailVC {
    private func configureProductImage() {
        guard let productImageUrlString = viewModel.getData(.imageUrl) as? String
        else { fatalError(Localize.fatalConfigurePrompt.raw())}
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
        else { fatalError(Localize.fatalConfigurePrompt.raw())}
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError(Localize.nilSelfFatal.raw()) }
            self.labelProductBrand.text = productBrandName
        }
    }
    private func configureProductType() {
        guard let productType = viewModel.getData(.productType) as? String
        else { fatalError(Localize.fatalConfigurePrompt.raw())}
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError(Localize.nilSelfFatal.raw()) }
            self.labelProductType.text = productType
        }
    }
    private func configureProductAverageRating() {
        guard let socialFeed = viewModel.getData(.currentSocialFeed) as? Social,
              let ratingFloat = socialFeed.commentCounts?.averageRating as? Double
        else { fatalError(Localize.fatalConfigurePrompt.raw())}
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError(Localize.nilSelfFatal.raw()) }
            self.labelProductRatingFloat.text = String(ratingFloat)
        }
    }
    private func configureProductRatingStarScalar() {
        guard let socialFeed = viewModel.getData(.currentSocialFeed) as? Social,
              let ratingFloat = socialFeed.commentCounts?.averageRating as? Double
        else { fatalError(Localize.fatalConfigurePrompt.raw())}
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError(Localize.nilSelfFatal.raw()) }
            self.starContainerView.setRating(ratingFloat)
        }
    }
    private func configureProductCommentCountTotal() {
        guard let socialFeed = viewModel.getData(.currentSocialFeed) as? Social,
              let commentCountOfAnonymous = socialFeed.commentCounts?.anonymousCommentsCount as? Int,
            let commentCountOfMember = socialFeed.commentCounts?.memberCommentsCount as? Int
        else { fatalError(Localize.fatalConfigurePrompt.raw())}
        let commentTotal = commentCountOfAnonymous + commentCountOfMember
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError(Localize.nilSelfFatal.raw()) }
            self.labelProductCommentTotal.text = "Comment: \(commentTotal)"
        }
    }
    private func configureProductPrice() {
        guard let productPriceInfo = viewModel.getData(.priceInfo) as? Price,
              let productCurrency = productPriceInfo.currency,
                let productUnitPrice = productPriceInfo.value
        else { fatalError(Localize.fatalConfigurePrompt.raw())}
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError(Localize.nilSelfFatal.raw()) }
            self.labelPricing.text = String(productUnitPrice).appending(" \(productCurrency)")
        }
    }
    private func configureProductLikeCount() {
        guard let socialFeed = viewModel.getData(.currentSocialFeed) as? Social,
              let productLikeCount = socialFeed.likeCount
        else { fatalError(Localize.fatalConfigurePrompt.raw())}
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError(Localize.nilSelfFatal.raw()) }
            self.labelLikeCount.text = String(productLikeCount)
        }
    }
    
}
