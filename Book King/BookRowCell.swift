//
//  BookRowCell.swift
//  Book King
//
//  Created by Adrian Guerrero on 26/09/21.
//

import UIKit

class BookRowCell: UICollectionViewCell {
    
    let bookImage = UIImageView(cornerRadius: 10)
    let bookTitleLabel = BKTitleLabel(textAlignment: .center, fontSize: 20)
    let bookAuthorLabel = BKTitleLabel(textAlignment: .center, fontSize: 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        let verticalSV = UIStackView(arrangedSubviews: [
            bookTitleLabel, bookAuthorLabel,
        ])
        verticalSV.axis = .vertical
        verticalSV.spacing = 4
        
        let stackView = UIStackView(arrangedSubviews: [
            bookImage, verticalSV
        ])
        addSubview(stackView)
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.fillSuperview()
        
        bookImage.widthAnchor.constraint(equalToConstant: 190).isActive = true
        bookImage.heightAnchor.constraint(equalToConstant: 280).isActive = true
        bookImage.backgroundColor = .green
                
        bookTitleLabel.text = "Title"
        bookAuthorLabel.text = "Author"
    }
}
