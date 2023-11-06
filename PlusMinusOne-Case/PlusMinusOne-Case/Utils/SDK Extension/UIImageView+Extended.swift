//
//  UIImageView+Extended.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 5.11.2023.
//

import UIKit

extension UIImageView {
    convenience init(systemName: String, backgroundColor: UIColor = .clear, tintColor: UIColor = .systemBackground, contentMode: UIView.ContentMode = .scaleAspectFit) {
        self.init()
        self.image = UIImage(systemName: systemName)
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.contentMode = contentMode
        self.clipsToBounds = true
    }
}
