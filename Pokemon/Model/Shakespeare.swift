//
//  Shakespeare.swift
//  Pokemon
//
//  Created by Ujjwal on 23/02/2021.
//

import Foundation

// MARK: - Shakespeare
struct Shakespeare: Codable {
    let success: Success
    let contents: Contents
}

// MARK: - Contents
struct Contents: Codable {
    let translated, text, translation: String
}

// MARK: - Success
struct Success: Codable {
    let total: Int
}
