//
//  GitHubAPI.swift
//  NetworkingLayer
//
//  Created by Arturs Derkintis on 01/11/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import Foundation

enum PokemonAPI {
    case species(name: String)
    case sprite(name: String)
    case shakespeare(text: String)
}

extension PokemonAPI: EndpointType {
    var baseURL: URL {
      switch self {
      case .sprite( _),.species( _):
        return URL(string: "https://pokeapi.co/api/v2")!
      case .shakespeare( _):
       return URL(string: "https://api.funtranslations.com/translate/shakespeare.json?")!
      }
    }

    var path: String {
        switch self {
        case .species(let name):
            return "/pokemon-species/\(name)"
        case .sprite(let name):
            return "/pokemon/\(name)"
        case .shakespeare(_):
            return ""
        }
    }

}
