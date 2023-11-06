//
//  UIStackView+Extended.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 5.11.2023.
//

import UIKit

extension UIStackView {
    
    convenience init(
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = .zero,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        backgroundColor: UIColor = .systemBackground
    ) {
        self.init()
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        self.backgroundColor = backgroundColor
        
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }

}
