//
//  BookModel.swift
//  Book King
//
//  Created by Adrian Guerrero on 26/09/21.
//

import Foundation

struct BooksResultsModel: Decodable {
    
    let results: BooksModel
}

struct BooksModel: Decodable {
    let books: [BookModel]
}

struct BookModel: Decodable, Hashable {
    let isbn:        String
    let title:       String
    let author:      String
    let description: String
    let genre:       String
    let img:         String
    let imported:    Bool
}


struct CategoriesModel: Hashable {
    let title: String
    let image: String
}

