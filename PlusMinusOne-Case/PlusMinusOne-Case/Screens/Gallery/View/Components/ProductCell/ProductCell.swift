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
    
    /// Populates the UI components of the cell with the provided data.
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
    
    // - StackView's
    private let vStackView: UIStackView = {
        UIStackView(axis: .vertical, backgroundColor: .green)
    }()
    private let hStackViewOfThirdRow: UIStackView = {
        UIStackView(axis: .horizontal, distribution: .fillEqually, backgroundColor: .blue)
    }()
    private let hStackViewOfForthRow: UIStackView = {
        UIStackView(axis: .horizontal, distribution: .fillEqually, backgroundColor: .red)
    }()
    // - ImageView's
    private let imageViewOfProduct: UIImageView = {
        UIImageView(systemName: "person.fill", tintColor: .systemGray4, contentMode: .scaleAspectFill)
    }()
    private let imageViewOfHeart: UIImageView = {
        UIImageView(systemName: "heart.fill", tintColor: .red)
    }()
    private let imageViewOfStar: UIImageView = {
        UIImageView(systemName: "star.leadinghalf.filled", tintColor: .yellow)
    }()
    private let imageViewOfComment: UIImageView = {
        UIImageView(systemName: "message.fill", tintColor: .green)
    }()
    private let imageViewOfPrice: UIImageView = {
        UIImageView(systemName: "banknote.fill", tintColor: .black)
    }()
    // - Label's
    private var labelProductType: UILabel = {
        UILabel.customLabel(text: "Product Type", textAlignment: .left)
    }()
    private var labelProductLikeCount: UILabel = {
        UILabel.customLabel(text: "129")
    }()
    private var labelProductRatingFloat: UILabel = {
        UILabel.customLabel(text: "4.5")
    }()
    private var labelProductCommentTotal: UILabel = {
        UILabel.customLabel(text: "26")
    }()
    private var labelProductPrice: UILabel = {
        UILabel.customLabel(text: "180")
    }()
}

extension ProductCell {
    
    private func setupUserInterface() {
        // TODO: rename below
        setupFirstly()
        setupSecondly()
    }
    private func setupFirstly() {
        self.backgroundColor = .systemBackground
    }
    
    private func setupSecondly() {
        setupStackView()
        setupThirdRowOfStackView()
        setupFourthRowOfStackView()
    }
    
    private func setupStackView() {
        self.addSubview(vStackView)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: self.topAnchor),
            vStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            vStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        vStackView.addArrangedSubviews([
            imageViewOfProduct, labelProductType, hStackViewOfThirdRow, hStackViewOfForthRow
        ])
        
        imageViewOfProduct.heightAnchor.constraint(equalTo: vStackView.heightAnchor, multiplier: 0.4).isActive = true
        labelProductType.heightAnchor.constraint(equalTo: vStackView.heightAnchor, multiplier: 0.2).isActive = true
        hStackViewOfThirdRow.heightAnchor.constraint(equalTo: vStackView.heightAnchor, multiplier: 0.3).isActive = true
        hStackViewOfForthRow.heightAnchor.constraint(equalTo: vStackView.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    private func setupThirdRowOfStackView() {
        
        hStackViewOfThirdRow.addArrangedSubviews([
            imageViewOfHeart, imageViewOfStar, imageViewOfComment, imageViewOfPrice
        ])
    }
    
    private func setupFourthRowOfStackView() {
        hStackViewOfForthRow.addArrangedSubviews([
            labelProductLikeCount, labelProductRatingFloat, labelProductCommentTotal, labelProductPrice
        ])
    }
}

extension ProductCell {
    
    private func configureUserInterface(pass data: RowItem) {
        //FIXME: failure onPress
        guard let productImageUrl = getData(.imageUrl, data) as? String,
              let productType = getData(.productType, data) as? String,
              let productSocialFeed = getData(.currentSocialFeed, data) as? Social,
              let productLikeCount = productSocialFeed.likeCount,
              let productRatingFloat = productSocialFeed.commentCounts?.averageRating as? Double,
              let productAnonymousComment = productSocialFeed.commentCounts?.anonymousCommentsCount as? Int,
              let productMemberComment = productSocialFeed.commentCounts?.memberCommentsCount as? Int,
              let productPrice = getData(.priceInfo, data) as? Price,
              let productPriceValue = productPrice.value
        else { fatalError("Invalid operation during populating UI.")} //FIXME: Detected bug, occurs on scroll
        //FIXME: data not exact with detail look up
        
        // TODO: Tuple is lengthy use mapping
        let productTuple: ( imageUrl: String, type: String, likeCount: Int, ratingFloat: Double, commentTotal: Int, priceInfo: String ) = (
            productImageUrl, productType, productLikeCount, productRatingFloat, (productAnonymousComment + productMemberComment), String(productPriceValue).appending(productPrice.currency ?? "")
        )
// TODO: add these to product.json
//    https://dummyimage.com/425x325/4a4a4a/26d6a4
//    https://dummyimage.com/430x310/4a4a4a/26d6a5
//    https://dummyimage.com/460x290/4a4a4a/26d6a6
//    https://dummyimage.com/445x305/4a4a4a/26d6a7
//    https://dummyimage.com/465x285/4a4a4a/26d6a8
//    https://dummyimage.com/440x320/4a4a4a/26d6a9
//    https://dummyimage.com/470x290/4a4a4a/26d6aa
//    https://dummyimage.com/435x325/4a4a4a/26d6a2
        configureProductImage(pass: productTuple.imageUrl)
        configureProductType(pass: productTuple.type)
        configureProductLikeCount(pass: productTuple.likeCount)
        configureProductRatingFloat(pass: productTuple.ratingFloat)
        configureProductCommentTotal(pass: productTuple.commentTotal)
        configureProductPrice(pass: productTuple.priceInfo)
    }
    
    private func configureProductImage(pass unitData: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { fatalError("Unexpected nil self") }
            self.imageViewOfProduct.kf.setImage(
                with: URL(string: unitData),
                placeholder: nil,
                options: [.cacheMemoryOnly],
                progressBlock: nil
            )
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
