//
//  PokemonPopupView.swift
//  Pokemon
//
//  Created by Ujjwal on 25/02/2021.
//

import UIKit


public protocol PokemonErrorDelegate {
  func didFailToFetchPokemon(error:(errorCode: Int,message: String))
}


class PokemonPopupView: UIViewController {
  
  @IBOutlet weak var holderView: UIView!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var errorDelegate: PokemonErrorDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func addShadow<T:UIView>(view: T){
    view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
    view.layer.shadowRadius = 5
    view.layer.shadowOffset = .zero
    view.layer.shadowOpacity = 1
  }
  
  func initialise(with searchText: String) {
    let viewModel = PokemonViewModel()
    viewModel.getFlavorText(for: searchText) { (result, error)  in
      if error != nil {
        self.errorDelegate?.didFailToFetchPokemon(error: (500,error!))
        DispatchQueue.main.async {
          setUpUI(error:searchText)
        }
      } else {
        DispatchQueue.main.async {
          setUpUI(error:nil)
          self.textView.text = result
        }
      }
    }
    
    func setUpUI(error:String?)
    {
      activityIndicator.stopAnimating()
      if let error = error {
        errorLabel.text = "Oops!!! Could not find Pokemon with name \(searchText). Please try searching with some other name"
        errorLabel.isHidden.toggle()
      } else {
        imageView.isHidden.toggle()
        textView.isHidden.toggle()

      }
    }
    
    viewModel.getSprites(for: searchText) { (image, error) in
      
      if error != nil {
        //show some error for image
      } else {
        DispatchQueue.main.async {
          self.imageView.image = image
        }
      }
    }
  }
  
  @IBAction func closePopup(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
