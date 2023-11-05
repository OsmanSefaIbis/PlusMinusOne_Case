//
//  UILabel+Extended.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 5.11.2023.
//

import UIKit

extension UILabel {
    static func customLabel(text: String, textAlignment: NSTextAlignment = .center, backgroundColor: UIColor = .white) -> UILabel {
        let label = UILabel()
        label.textAlignment = textAlignment
        label.text = text
        label.backgroundColor = backgroundColor
        return label
    }
}
