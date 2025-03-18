//
//  UploadedPDFModel.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 13/02/25.
//

import Foundation

// MARK: - UploadedPDFModel
struct UploadedPDFModel: Codable {
    let status: Bool
    let message: String
    let data: [UploadedData]

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case message, data
    }
}

// MARK: - Datum
struct UploadedData: Codable {
    let id: Int
    let title, date: String
}
