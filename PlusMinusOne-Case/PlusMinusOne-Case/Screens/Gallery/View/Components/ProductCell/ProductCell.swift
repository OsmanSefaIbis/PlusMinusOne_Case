//
//  ProductCell.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

import UIKit

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
        // TODO: Handle Later
    }
    
    func configure(){ // TODO: Delete Later
        setupUserInterface()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO: Later
        self.imageViewOfProduct.image = nil
    }
    // - User Interface Variables
    
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
        UIImageView(systemName: "person.fill", tintColor: .systemGray4)
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
    private let labelProductType: UILabel = {
        UILabel.customLabel(text: "Product Type", textAlignment: .left)
    }()
    private let labelProductLikeCount: UILabel = {
        UILabel.customLabel(text: "129")
    }()
    private let labelProductRatingFloat: UILabel = {
        UILabel.customLabel(text: "4.5")
    }()
    private let labelProductCommentTotal: UILabel = {
        UILabel.customLabel(text: "26")
    }()
    private let labelProductPrice: UILabel = {
        UILabel.customLabel(text: "180")
    }()
}

extension ProductCell {
    
    private func setupUserInterface() {
        
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
