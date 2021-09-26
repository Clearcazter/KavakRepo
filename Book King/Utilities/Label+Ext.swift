//
//  Label+Ext.swift
//  Book King
//
//  Created by Adrian Guerrero on 26/09/21.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
    }
}
