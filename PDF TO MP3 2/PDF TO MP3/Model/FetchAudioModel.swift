//
//  FetchAudioModel.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 14/02/25.
//


import Foundation

// MARK: - FetchAudioModel
struct FetchAudioModel: Codable {
    let status: Bool
    let message: String
    let data: [AudioData]

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case message, data
    }
}

// MARK: - Datum
struct AudioData: Codable {
    let pdfFiles, mp3Files: [File]?

    enum CodingKeys: String, CodingKey {
        case pdfFiles = "PDF Files"
        case mp3Files = "MP3 Files"
    }
}

// MARK: - File
struct File: Codable {
    let id, userID: Int
    let title: String
    let mp3File: String?
    let date: String
    let pdfFile: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title
        case mp3File = "mp3_file"
        case date
        case pdfFile = "pdf_file"
    }
}

