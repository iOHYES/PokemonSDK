//
//  PokemonUtils.swift
//  Pokemon
//
//  Created by Ujjwal on 25/02/2021.
//

import UIKit

open class PokemonUtils: NSObject {

  public var errorDelegate: PokemonErrorDelegate?

  open func showPokemonPopup(presenter: UIViewController, searchText: String)
  {
    if searchText.isEmpty {
      errorDelegate?.didFailToFetchPokemon(error: (501,"Please enter Pokemon name"))
      return
    }
    if let bundlePath = Bundle.main.path(forResource: "PokemonResources", ofType: "bundle") {
      let bundle = Bundle(path: bundlePath)
      let popupView = PokemonPopupView(nibName: "PokemonPopupView", bundle: bundle)
      popupView.initialise(with: searchText.lowercased())
      popupView.modalPresentationStyle  = .overCurrentContext
      popupView.modalTransitionStyle    = .crossDissolve
      presenter.present(popupView, animated: true, completion: nil)
    } else {
      errorDelegate?.didFailToFetchPokemon(error: (501,"Can not load Pokemon View"))
    }
    
  }
  
}
