//
//  ArtModel.swift
//  collectionViewExample
//
//  Created by Halil Ibrahim Andic on 11.01.2023.
//

import Foundation

// MARK: - ArtModel
struct ArtModel: Codable {
    let data: [Datum]
}

struct Datum: Codable {

    let artist_display, image_id, title: String
    //let thumbnail: Thumbnail
}

//struct Thumbnail: Codable {
//    let width, height: Int
//}
