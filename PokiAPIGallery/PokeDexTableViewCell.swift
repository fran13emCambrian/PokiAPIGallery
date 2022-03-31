//
//  PokeDexTableViewCell.swift
//  PokiAPIGallery
//
//  Created by Francisco Escobar on 2022-03-31.
//

import UIKit

class PokeDexTableViewCell: UITableViewCell {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        spinner.startAnimating()
        
        // Configure the view for the selected state
    }

}
