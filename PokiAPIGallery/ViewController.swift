//
//  ViewController.swift
//  PokiAPIGallery
//
//  Created by Cambrian on 2022-03-21.
//

import UIKit

class ViewController: UIViewController {

  /*  @IBOutlet weak var pokeimage: UIImageView! */
    @IBOutlet weak var pokeimage: UIImageView!
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    /*    PokeAPIHelper.fetchAllImages { images in
            self.pokeimage.image = images.first!
        }
    }
*/
        spinner.startAnimating()
        
        
        PokeAPIHelper.getPokemonInfo(url: url) { PokemonInfoResult in
            switch PokemonInfoResult {
            case .success(let pokemon):
            PokeAPIHelper.fetch(url: pokemon.sprites.front_default) { imageResult in
                switch imageResult {
                    case .success(let data):
                   let image = UIImage(data: data)
                    DispatchQueue.main.sync {
                        for _ in 0...1000000{
                            continue
                        }
                        self.pokeimage.image = image
                        self.spinner.isHidden = true
                    }
                    case .failure(let error):
                        print(error)
                    }
                }
                DispatchQueue.main.async {
                    self.pokeName.text = pokemon.name
                }
            case .failure(let error):
                print(error)
            }
        }
}

}

