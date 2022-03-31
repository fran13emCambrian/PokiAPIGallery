//
//  Pokemon.swift
//  PokiAPIGallery
//
//  Created by Francisco Escobar on 2022-03-31.
//

import Foundation

struct Pokemon: Codable{
    var name: String
    var sprites: Sprites
}

struct Sprites: Codable {
    var front_default: String
}
