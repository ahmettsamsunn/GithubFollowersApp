//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 18.04.2024.
//

import Foundation
enum ErrorMessage : String,Error {
    case invalidUsername = "The user you search does not exist. Please try again with a different username"
    case unableToComplete = "Your request couldn’t completed. Please check your internet connection"
    case invalidResponse = "İnvalid response.Please try again"
    case invalidData = "İnvalid data.Please try again."
    case alreadyinfavorites = "This User is already in your favorites list."
}
