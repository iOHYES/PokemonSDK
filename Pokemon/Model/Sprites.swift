//
//  Sprites.swift
//  Pokemon
//
//  Created by Ujjwal on 23/02/2021.
//

import Foundation

// MARK: - Sprites
struct Sprites: Codable {
    let sprites: SpritesClass
}

// MARK: - SpritesClass
struct SpritesClass: Codable {
    let backDefault, frontDefault: String

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case frontDefault = "front_default"
    }
}
