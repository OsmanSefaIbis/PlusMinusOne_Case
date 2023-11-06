//
//  UILabel+Extended.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 5.11.2023.
//

import UIKit

extension UILabel {
    static func customLabel(
        text: String = "Label",
        textAlignment: NSTextAlignment = .center,
        backgroundColor: UIColor = .clear,
        font: UIFont = .systemFont(ofSize: 10)
    ) -> UILabel {
        let l = UILabel()
        l.textAlignment = textAlignment
        l.text = text
        l.backgroundColor = backgroundColor
        l.font = font
        return l
    }
}

