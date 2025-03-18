//
//  AddFavouriteModel.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 19/02/25.
//


import Foundation

// MARK: - AddFavouriteModel
struct AddFavouriteModel: Codable {
    let status: Bool
    let message: String
    let data: [FavData]

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case message, data
    }
}

// MARK: - Datum
struct FavData: Codable {
    let mp3Files: [Mp3File]

    enum CodingKeys: String, CodingKey {
        case mp3Files = "MP3 FILES"
    }
}

// MARK: - Mp3File
struct Mp3File: Codable {
    let id: Int
    let mp3File, title, date: String
    

    enum CodingKeys: String, CodingKey {
        case id
        case mp3File = "mp3_file"
        case title, date
    }
}
