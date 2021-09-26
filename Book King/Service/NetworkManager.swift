//
//  NetworkManager.swift
//  Book King
//
//  Created by Adrian Guerrero on 26/09/21.
//

import Foundation

class NetworkManager {
    
    static let shared   = NetworkManager()
    let baseUrl         = "https://raw.githubusercontent.com/"
    
    private init () { }
    
    func getBooks(completed: @escaping (BooksResultsModel?, BKErrorMessage?) -> Void) {
        let endpoint = baseUrl.appending("ejgteja/files/main/books.json")
        guard let url = URL(string: endpoint) else {
            return completed(nil, .invalidRequest)
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(nil, .unableToComplete)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completed(nil, .invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let books = try decoder.decode(BooksResultsModel.self, from: data)
                completed(books, nil)
            }
            catch {
                completed(nil, .invalidData)
            }
        }
        task.resume()
    }
    
    
    func getBestsellers(completed: @escaping (Result<ResultsBestModel, BKErrorMessage>) -> Void) {
        let endpoint = baseUrl.appending("ejgteja/files/main/best_sellers.json")
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let betsSellersBooks = try decoder.decode(ResultsBestModel.self, from: data)
                completed(.success(betsSellersBooks))
            }
            catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}

