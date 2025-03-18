//
//  FetchFavouriteModel.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 19/02/25.
//


import Foundation

// MARK: - FetchFavouriteModel
struct FetchFavouriteModel: Codable {
    let status: Bool
    let message: String
    let data: [FavouritesData]
}

// MARK: - Datum
struct FavouritesData: Codable {
    let id: Int
    let title, fileURL, dateAdded: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case fileURL = "file_url"
        case dateAdded = "date_added"
    }
}
