//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by Ujjwal on 24/02/2021.
//

import Foundation
import UIKit

class PokemonViewModel {
  
  let networking    = Networking()
  
  
  func getFlavorText(for pokemon: String, completion: ((_ transLatedText: String?, _ error: String?) -> Void)?)
  {
    networking.performNetworkTask(method: .GET, endpoint: PokemonAPI.species(name: pokemon), dictionary: nil, type: PokemonSpecies.self) { (response, error)  in
      
      if error != nil {
        completion?(nil,error)
      } else if let response = response {
        self.getShakepeareTranslation(for: response.englishTextDescription!.flavorText) { (transLatedText) in
          completion?(transLatedText,nil)
        }
      }
    }
  }
  
  func getSprites(for pokemon: String, completion: ((UIImage?,String?) -> Void)?)
  {
    networking.performNetworkTask(method: .GET, endpoint: PokemonAPI.sprite(name: pokemon), dictionary: nil, type: Sprites.self) { (response, error) in
      
      if error != nil {
        completion?(nil, error)
      } else if let response = response {
        if let data = try? Data(contentsOf: URL(string: response.sprites.frontDefault)!) {
          completion?(UIImage(data: data)!, nil)
        }
      }
    }
    
  }
  
  private func getShakepeareTranslation(for inputText: String, completion: ((String) -> Void)?)
  {
    networking.performNetworkTask(method: .POST, endpoint: PokemonAPI.shakespeare(text: inputText), dictionary: ["text" : inputText], type: Shakespeare.self) { (response, error) in
      
      if error != nil {
        completion?(inputText)
      } else if let response = response {
        completion?(response.contents.translated)
      }
    }
    
  }
  
}
