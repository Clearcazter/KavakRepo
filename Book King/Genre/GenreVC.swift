//
//  GenreVC.swift
//  Book King
//
//  Created by Adrian Guerrero on 26/09/21.
//

import UIKit

class GenreVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "id"
    
    var books: [BookModel]?
    var bestSellers: [String]?
    
    var genres = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBooksAndBestSellers()
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.register(GenreGroupCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func getBooksAndBestSellers() {
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        NetworkManager.shared.getBooks { [weak self] (books, errorMessage) in
            guard let self = self else { return }
            
            guard let books = books else {
                self.showAlertOnmainThread(title: "Error", message: errorMessage?.rawValue ?? "invalid Request")
                return
            }
            self.books = books.results.books
            
            var allGenres = [String]()
            
            books.results.books.forEach { (bookItem) in
                allGenres.append(bookItem.genre)
            }
            allGenres.append("Best Sellers")
            allGenres.sort()
            let uniqueGenre = Array(Set(allGenres))
            self.genres = uniqueGenre
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        NetworkManager.shared.getBestsellers { [weak self] (results) in
            guard let self = self else { return }
            switch results {
            case .success(let bestSellers):
                self.bestSellers = bestSellers.results.bestSellers
                dispatchGroup.leave()
            case .failure(let error):
                self.showAlertOnmainThread(title: "Error", message: error.rawValue)
            }
        }
        dispatchGroup.notify(queue: .main) {
            DispatchQueue.main.async { self.collectionView.reloadData() }
            self.updateData()
        }
    }
    
    func updateData() {
        
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GenreGroupCell
        
        let localBooks = books
        
        genres.sort()
        let categorie = genres[indexPath.item]
        
        print(categorie)
        print("----")
        
        if categorie == "Best Sellers" {
            cell.titleLabel.text = categorie
            var bestBooks = [BookModel]()
            bestSellers?.forEach({ (bestItem) in
                localBooks?.forEach({ (itemBook) in
                    if itemBook.isbn == bestItem {
                        bestBooks.append(itemBook)
                    }
                })
            })
            cell.horizontalController.bookGroup = bestBooks
            cell.horizontalController.collectionView.reloadData()
        }
        else {
            cell.titleLabel.text = categorie
            var categorieBook = [BookModel]()
                localBooks?.forEach({ (itemBook) in
                    if itemBook.genre == categorie {
                        categorieBook.append(itemBook)
                    }
            })
            cell.horizontalController.bookGroup = categorieBook
            cell.horizontalController.collectionView.reloadData()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
}



extension UICollectionViewController {
    
    func showAlertOnmainThread(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(cancelAction)
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            self.present(alert, animated: true)
        }
    }
    
    
    func presentInFullScreen(_ viewController: UIViewController,
                             animated: Bool,
                             completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated, completion: completion)
    }
}
