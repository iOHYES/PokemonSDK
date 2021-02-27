//
//  PokemonSpecies.swift
//  Pokemon
//
//  Created by Ujjwal on 23/02/2021.
//

import Foundation

// MARK: - Pokemon
struct PokemonSpecies: Codable {
    let flavorTextEntries: [FlavorTextEntry]

    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
  
  var englishTextDescription: FlavorTextEntry? {
          get {
            for text in flavorTextEntries{
              if text.language.name == "en"{
                return text
              }
            }
            return nil
          }
      }
}

// MARK: - FlavorTextEntry
struct FlavorTextEntry: Codable {
    let flavorText: String
    let language: Language

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
    }
}

// MARK: - Language
struct Language: Codable {
    let name: String
}
