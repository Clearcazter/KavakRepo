//
//  BKErrorMessage.swift
//  Book King
//
//  Created by Adrian Guerrero on 26/09/21.
//

import Foundation

enum BKErrorMessage: String, Error {
    case invalidRequest     = "Invalid request please try again"
    case unableToComplete   = "Unable to complete your request. Check the internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again"
    case invalidData        = "The data received from the server was invalid. Please try again"
}
