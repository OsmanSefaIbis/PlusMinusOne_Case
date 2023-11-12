//
//  StarContainerView.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 11.11.2023.
//
import UIKit
import Cosmos

final class StarContainerView: UIView {
    
    private let starRatingView: CosmosView = {
        
        let cv = CosmosView()
        cv.backgroundColor = .clear
        cv.tintColor = .systemOrange
        cv.settings.fillMode = .precise
        cv.settings.starSize = 20
        cv.isUserInteractionEnabled = false
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    private func setupSubviews() {
        self.addSubview(starRatingView)
        starRatingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starRatingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            starRatingView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            starRatingView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 145/100)
        ])
    }

    func setRating(_ rating: Double) {
        starRatingView.rating = rating
    }
}

