//
//  PokeDexTableViewController.swift
//  PokiAPIGallery
//
//  Created by Francisco Escobar on 2022-03-30.
//

import UIKit

class PokeDexTableViewController: UITableViewController {
    var pokeDex = [result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        PokeAPIHelper.getPokeDex { pokeDex in
            switch pokeDex {
            case.success(let pokeDex):
                self.pokeDex = pokeDex.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case.failure(let error):
                print(error)
            }
            
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeDex.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemon", for: indexPath) as! PokeDexTableViewCell
        
        cell.pokeName.text = pokeDex[indexPath.row].name
        
        PokeAPIHelper.fetchImage(url: pokeDex[indexPath.row].url) { PokeImageResult in
            switch PokeImageResult {
            case .success(let uIImage):
                DispatchQueue.main.async {
                    cell.spinner.isHidden = true
                    cell.pokeImage.image = uIImage
                }
            case .failure(let error):
                print(error)
                }
            }
        return cell
        }
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let index = tableView.indexPathForSelectedRow!.row
        let selectedURL = pokeDex[index].url
       let dst = segue.destination as! ViewController
        dst.url = selectedURL
    }
    
}
