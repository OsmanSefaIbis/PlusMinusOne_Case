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
    
    private let imageView: UIImageView = { // TODO: Delete later
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "person.fill")
        iv.tintColor = .systemGray4
        iv.clipsToBounds = true
        return iv
    }()
    
    /// Populates the UI components of the cell with the provided data.
    func configureCell(with data: RowItem) {
        // TODO: Handle Later
    }
    
    func configure(){ // TODO: Delete Later
        setupUserInterface()
    }
    
    private func setupUserInterface() {
        self.backgroundColor = .systemBackground
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    
    
}
