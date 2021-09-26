//
//  UIImageView+Ext.swift
//  Book King
//
//  Created by Adrian Guerrero on 26/09/21.
//

import UIKit

extension UIImageView {
    convenience init (cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}
