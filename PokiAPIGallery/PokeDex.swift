//
//  PokeDex.swift
//  PokiAPIGallery
//
//  Created by Francisco Escobar on 2022-03-30.
//

import Foundation

class PokeDex: Codable{
    var results: [result]
}

struct result: Codable{
    var name: String
    var url: String
}
