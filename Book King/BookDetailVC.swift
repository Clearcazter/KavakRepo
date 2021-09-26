//
//  BookDetailVC.swift
//  Book King
//
//  Created by Adrian Guerrero on 26/09/21.
//

import UIKit

class BookInfoVC: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let bookTitleLabel   = BKTitleLabel(textAlignment: .center, fontSize: 24)
    let bookImage       = UIImageView()
    let authorLabel     = BKTitleLabel(textAlignment: .center, fontSize: 18)
    let descLabel       = BKBodyLabel(textAlignment: .left)
    var itemsViews: [UIView] = []
        
    var book: BookModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureScrollview()
        layoutUI()
        configureUIElements()
    }
    
    init(book: BookModel) {
        super.init(nibName: nil, bundle: nil)
        self.book = book
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    func configureUIElements() {
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        bookImage.sd_setImage(with: URL(string: book.img))
        bookTitleLabel.text  = book.title
        authorLabel.text    = book.author
        descLabel.text      = book.description
        descLabel.numberOfLines = 10
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func configureViewController() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func configureScrollview() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdgesof(of: view)
        contentView.pinToEdgesof(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1000)
        ])
        
    }
    
    
    func layoutUI() {
        
        let bigpadding: CGFloat     = 30
        let padding: CGFloat        = 20
        let tinypadding: CGFloat    = 12
        
        itemsViews = [bookTitleLabel, bookImage, authorLabel, descLabel]
        
        for itemView in itemsViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            bookTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            bookTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            bookTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            bookTitleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            bookImage.topAnchor.constraint(equalTo: bookTitleLabel.bottomAnchor, constant: padding),
            bookImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: (bigpadding * 2 )),
            bookImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: (-bigpadding * 2)),
            bookImage.heightAnchor.constraint(equalToConstant: 450),
            
            authorLabel.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: padding),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            authorLabel.heightAnchor.constraint(equalToConstant: 28),
            
            descLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: tinypadding),
            descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: tinypadding),
            descLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -tinypadding),
            descLabel.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
}


extension UIView {
    
    func pinToEdgesof(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
        ])
    }
    
    
    func addSubViews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
