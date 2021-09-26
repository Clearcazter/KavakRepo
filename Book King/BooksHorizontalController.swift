//
//  BooksHorizontalController.swift
//  Book King
//
//  Created by Adrian Guerrero on 26/09/21.
//

import UIKit
import SDWebImage

class BooksHorizontalController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    let cellId = "cellId"
    
    var bookGroup: [BookModel]?
    var groups = [BookModel]()
    
    var didselecHandler: ((BookModel) -> ())?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let book = bookGroup?[indexPath.item] {
        didselecHandler?(book)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(BookRowCell.self, forCellWithReuseIdentifier: cellId)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return bookGroup?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BookRowCell
        
        let book = bookGroup?[indexPath.item]
        
        cell.bookTitleLabel.text = book?.title
        cell.bookAuthorLabel.text = book?.author
        cell.bookImage.sd_setImage(with: URL(string: book?.img ?? ""))
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lineSpacing: CGFloat = 10
        let topBottomPadding: CGFloat = 12
        let heigh = ((view.frame.height - 2 * topBottomPadding - 2 * lineSpacing) / 1)
        
        return .init(width: view.frame.width - 48, height: heigh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 16, bottom: 12, right: 16)
    }

}
