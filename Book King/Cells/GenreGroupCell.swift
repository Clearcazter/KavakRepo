//
//  GenreGroupCell.swift
//  Book King
//
//  Created by Adrian Guerrero on 26/09/21.
//

import UIKit

class GenreGroupCell: UICollectionViewCell {

    let titleLabel = UILabel(text: "Genre Group", font: .boldSystemFont(ofSize: 30))
    
    let horizontalController = BooksHorizontalController()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



