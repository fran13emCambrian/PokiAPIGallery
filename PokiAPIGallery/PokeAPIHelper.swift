//
//  PokeAPIHelper.swift
//  PokiAPIGallery
//
//  Created by Cambrian on 2022-03-21.
//

import Foundation
import UIKit

enum pokeFetchResult{
    case success(Data)
    case failure(Error)
}

enum PokeDexResult{
    case success(PokeDex)
    case failure(Error)
}

enum PokemonInfoResult{
    case success(Pokemon)
    case failure(Error)
}

enum PokeImageResults{
    case success(UIImage)
    case failure(Error)
}

class PokeAPIHelper {
    private static var baseURL: String = "https://pokeapi.co/api/v2/pokemon?limit=151"
    
    private static var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    static func fetch(url: String, callback: @escaping (pokeFetchResult)->Void){
        guard let url = URL(string: url)
        else {return}
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            data, response, error in
            
            if let data = data {
                callback(.success(data))
            } else if let error = error {
                callback(.failure(error))
            }
    }
        task.resume()
    }
    
    static func getPokeDex(callback: @escaping (PokeDexResult)->Void){
        fetch(url: baseURL) {pokeDex in
            switch pokeDex {
            case .success(let data):
                do{
                    let decoder = JSONDecoder()
                    let pokeDex = try decoder.decode(PokeDex.self, from: data)
                    callback(.success(pokeDex))
                } catch let e{
                    callback(.failure(e))
                }
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    static func getPokemonInfo(url: String, callback: @escaping (PokemonInfoResult)->Void){
        fetch(url: url) { pokeFetchResult in
            switch pokeFetchResult {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let pokemon = try decoder.decode(Pokemon.self, from: data)
                    callback(.success(pokemon))
                }catch let e{
                    callback(.failure(e))
                }
            case .failure(let error):
                callback(.failure(error))
            }
        }
        
    }
    static func fetchImage(url: String, callback: @escaping (PokeImageResults)->Void){
        getPokemonInfo(url: url) { PokemonInfoResult in
            switch PokemonInfoResult {
            case .success(let pokemon):
                PokeAPIHelper.fetch(url: pokemon.sprites.front_default) { imageResult in
                    switch imageResult {
                        case .success(let data):
                        guard
                            let image = UIImage(data: data)
                        else{return}
                        callback(.success(image))
                        case .failure(let error):
                        callback(.failure(error))
                        }
                    }
            case.failure(let error):
                callback(.failure(error))
            }
        }
    }
}
    /*
   static func fetchPokeImageURL(callback: @escaping ([URL])->Void){
        var imageURLs = [URL]()
        let group = DispatchGroup()
        fetchURLs { urls in
            for url in urls {
                let request = URLRequest(url: url)
                group.enter()
                let task = session.dataTask(with: request) { data, response, error in
                    if let data = data {
                        let decoder = JSONDecoder()
                        do{
                            let pokemon = try decoder.decode(PokeImage.self, from: data)
                            imageURLs.append(URL(string: pokemon.sprites.front_default)!)
                        } catch let err {
                            print(err)
                        }
                    }
                    group.leave()
                }
                task.resume()
            }
            group.notify(queue: .main){
                print(imageURLs)
                callback(imageURLs)
            }
        }
    }
    
    static func fetchPokeImage(pokeImage: URL, callback: @escaping (UIImage)->Void){
        let request = URLRequest(url: pokeImage)
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                callback(UIImage(data: data)!)
            }
        }
        task.resume()
    }
    
    static func fetchAllImages(callback: @escaping ([UIImage])->Void){
        fetchPokeImageURL{ urls in
            let group = DispatchGroup()
            var images = [UIImage]()
            for url in urls {
                group.enter()
                fetchPokeImage(pokeImage: url) { image in
                    images.append(image)
                    group.leave()
                }
            }
            group.notify(queue: .main){
                callback(images)
            }
        }

    } */

