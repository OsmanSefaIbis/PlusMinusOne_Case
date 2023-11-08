//
//  ProductCell.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

import UIKit
import Kingfisher

// - Data Model: Cell
struct ProductCellDataModel {
    let id: Int
    let productBrand: String
    let productType: String
    let imageUrl: String
    let priceInfo: Price
    var currentSocialFeed: Social?
}


final class ProductCell: UICollectionViewCell {
    
    static let identifier = "ProductCell"
    private var internet: InternetManager { InternetManager.shared }
    
    /// Setups and configures the UI variables
    func configureCell(with data: RowItem) {
        setupUserInterface() // - Construct UI
        configureUserInterface(pass: data) // - Populate UI
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO: later
        self.imageViewOfProduct.image = nil
        self.labelProductType.text = nil
        self.labelProductLikeCount.text = nil
        self.labelProductRatingFloat.text = nil
        self.labelProductCommentTotal.text = nil
    }
    //   - User Interface Variables
    private let containerView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        v.layer.borderWidth = 1.5
        v.layer.borderColor = UIColor.systemGray3.cgColor
        v.backgroundColor = .systemGray6
        return v
    }()
    // - StackView's
    private let vStackViewOuter: UIStackView = {
        UIStackView(axis: .vertical, backgroundColor: .clear)
    }()
    private let vStackViewInner: UIStackView = {
        UIStackView(axis: .vertical, backgroundColor: .clear)
    }()
    private let hStackViewOfSecondRow: UIStackView = {
        UIStackView(axis: .horizontal,alignment: .center, distribution: .fillEqually, backgroundColor: .clear)
    }()
    private let hStackViewOfThirdRow: UIStackView = {
        UIStackView(axis: .horizontal, alignment: .top, distribution: .fillEqually, backgroundColor: .clear)
    }()
    // - ImageView's
    private let imageViewOfProduct: UIImageView = {
        UIImageView(systemName: "wifi.exclamationmark", tintColor: .systemGray4, contentMode: .scaleAspectFill)
    }()
    private let imageViewOffline: UIImageView = {
        UIImageView(systemName: "wifi.exclamationmark", tintColor: .systemGray4, contentMode: .scaleAspectFill)
    }()
    private let imageViewOfHeart: UIImageView = {
        UIImageView(systemName: "heart.fill", tintColor: .systemRed)
    }()
    private let imageViewOfStar: UIImageView = {
        UIImageView(systemName: "star.leadinghalf.filled", tintColor: .systemOrange)
    }()
    private let imageViewOfComment: UIImageView = {
        UIImageView(systemName: "message.fill", tintColor: .darkGray)
    }()
    private let imageViewOfPrice: UIImageView = {
        UIImageView(systemName: "banknote.fill", tintColor: .systemGreen)
    }()
    // - Label's
    private var labelProductType: UILabel = {
        UILabel.customLabel(font: UIFont.boldSystemFont(ofSize: 12))
    }()
    private var labelProductLikeCount: UILabel = {
        UILabel.customLabel()
    }()
    private var labelProductRatingFloat: UILabel = {
        UILabel.customLabel()
    }()
    private var labelProductCommentTotal: UILabel = {
        UILabel.customLabel()
    }()
    private var labelProductPrice: UILabel = {
        UILabel.customLabel()
    }()
}

extension ProductCell {
    
    private func setupUserInterface() {
        // TODO: rename below
        setupFirstly()
        setupSecondly()
    }
    private func setupFirstly() {
        self.backgroundColor = .clear
    }
    
    private func setupSecondly() {
        setupContainerView()
        setupOuterStackView()
        setupInnerStackView()
        setupThirdRowOfStackView()
        setupFourthRowOfStackView()
    }
    
    private func setupContainerView() {
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let inset: CGFloat = 2
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: inset),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -inset)
        ])
    }
    private func setupOuterStackView() {
        containerView.addSubview(vStackViewOuter)
        vStackViewOuter.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStackViewOuter.topAnchor.constraint(equalTo: containerView.topAnchor),
            vStackViewOuter.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            vStackViewOuter.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            vStackViewOuter.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        vStackViewOuter.addArrangedSubviews([
            imageViewOfProduct, vStackViewInner
        ])
        
        imageViewOfProduct.heightAnchor.constraint(equalTo: vStackViewOuter.heightAnchor, multiplier: 0.6).isActive = true
        vStackViewInner.heightAnchor.constraint(equalTo: vStackViewOuter.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    private func setupInnerStackView() {
        vStackViewInner.addArrangedSubviews([
            labelProductType, hStackViewOfSecondRow, hStackViewOfThirdRow
        ])
        labelProductType.heightAnchor.constraint(equalTo: vStackViewInner.heightAnchor, multiplier: 0.4 ).isActive = true
        hStackViewOfSecondRow.heightAnchor.constraint(equalTo: vStackViewInner.heightAnchor, multiplier: 0.3).isActive = true
        hStackViewOfThirdRow.heightAnchor.constraint(equalTo: vStackViewInner.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    private func setupThirdRowOfStackView() {
        
        hStackViewOfSecondRow.addArrangedSubviews([
            imageViewOfHeart, imageViewOfStar, imageViewOfComment, imageViewOfPrice
        ])
    }
    
    private func setupFourthRowOfStackView() {
        hStackViewOfThirdRow.addArrangedSubviews([
            labelProductLikeCount, labelProductRatingFloat, labelProductCommentTotal, labelProductPrice
        ])
    }
}

extension ProductCell {
    
    private func populateProductTuple(pass data: RowItem) -> (
        imageUrl: String,
        type: String,
        likeCount: Int,
        ratingFloat: Double,
        commentTotal: Int,
        priceInfo: String
    ) {
        guard let productImageUrl = getData(.imageUrl, data) as? String,
              let productType = getData(.productType, data) as? String,
              let productSocialFeed = getData(.currentSocialFeed, data) as? Social,
              let productLikeCount = productSocialFeed.likeCount,
              let productRatingFloat = productSocialFeed.commentCounts?.averageRating as? Double,
              let productAnonymousComment = productSocialFeed.commentCounts?.anonymousCommentsCount as? Int,
              let productMemberComment = productSocialFeed.commentCounts?.memberCommentsCount as? Int,
              let productPrice = getData(.priceInfo, data) as? Price,
              let productPriceValue = productPrice.value,
              let productCurrency = productPrice.currency
        else { fatalError("Invalid operation during populating UI with id: \(data.id)")}
        
        let productCommentTotal: Int = productAnonymousComment + productMemberComment
        let productPriceString: String = productCurrency.appending(String(Int(productPriceValue)))
        
        return (productImageUrl, productType, productLikeCount, productRatingFloat, productCommentTotal, productPriceString)
    }

    
    private func configureUserInterface(pass data: RowItem) {

        let product = populateProductTuple(pass: data)
        // Configure's Each UI variable
        configureProductImage(pass: product.imageUrl)
        configureProductType(pass: product.type)
        configureProductLikeCount(pass: product.likeCount)
        configureProductRatingFloat(pass: product.ratingFloat)
        configureProductCommentTotal(pass: product.commentTotal)
        configureProductPrice(pass: product.priceInfo)
    }
    
    private func configureProductImage(pass unitData: String) {
        
        if internet.isOnline() {
            imageViewOfProduct.contentMode = .scaleAspectFill
            DispatchQueue.main.async { [weak self] in
                guard let self else { fatalError("Unexpected nil self") }
                self.imageViewOfProduct.kf.setImage(
                    with: URL(string: unitData),
                    placeholder: nil,
                    options: [.cacheMemoryOnly],
                    progressBlock: nil
                )
            }
        } else {
            imageViewOfProduct.contentMode = .scaleAspectFit
            DispatchQueue.main.async { [weak self] in
                guard let self else { fatalError("Unexpected nil self") }
                self.imageViewOfProduct.image = self.imageViewOffline.image
            }
        }
    }
    
    private func configureProductType(pass unitData: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError("Unexpected nil self") }
            self.labelProductType.text = unitData
        }
    }
    
    private func configureProductLikeCount(pass unitData: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError("Unexpected nil self") }
            self.labelProductLikeCount.text = String(unitData)
        }
    }
    
    private func configureProductRatingFloat(pass unitData: Double) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError("Unexpected nil self") }
            self.labelProductRatingFloat.text = String(unitData)
        }
    }
    
    private func configureProductCommentTotal(pass unitData: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError("Unexpected nil self") }
            self.labelProductCommentTotal.text = String(unitData)
        }
    }
    
    private func configureProductPrice(pass unitData: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError("Unexpected nil self") }
            self.labelProductPrice.text = unitData
        }
    }
    
    func getData(_ property: ProductDataAccessor, _ data: RowItem) -> Any? {
        
        let mirror = Mirror(reflecting: data)
        for (key, value) in mirror.children {
            if key == property.rawValue {
                return value
            }
        }
        return nil
    }
    
}
