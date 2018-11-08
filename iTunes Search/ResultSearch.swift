//
//  ResultSearch.swift
//  iTunes Search
//
//  Created by Dennis Zubkoff on 07/11/2018.
//  Copyright © 2018 Dennis Zubkoff. All rights reserved.
//

import Foundation

// To parse the JSON, add this file to your project and do:
//
//   let resultSearch = try? newJSONDecoder().decode(ResultSearch.self, from: jsonData)

import Foundation

struct ResultSearch: Codable {
    let resultCount: Int?
    let results: [Result]
}

struct Result: Codable {
    let wrapperType: String? // track, collection, artist
    let kind: String?
    let artistId: Int?
    let collectionId: Int?
    let trackId: Int?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewURL: String?
    let collectionViewURL: String?
    let trackViewURL: String?
    let previewURL: String?
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let trackPrice: Double?
    let releaseDate: String?
    let collectionExplicitness: String?
    let trackExplicitness: String?
    let discCount: Int?
    let discNumber: Int?
    let trackCount: Int?
    let trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let isStreamable: Bool?
    let collectionArtistName: String?
    let collectionArtistId: Int?
    let collectionArtistViewUrl: String?
}



