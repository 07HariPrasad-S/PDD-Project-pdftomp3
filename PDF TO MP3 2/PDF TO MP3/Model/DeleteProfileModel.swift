//
//  DeleteProfileModel.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 12/02/25.
//

import Foundation
struct DeleteProfileModel: Codable {
    let status: Bool
    let message: String
    let data: [deleteData]

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case message, data
    }
}

// MARK: - Datum
struct deleteData: Codable {
    let username, password: String
}


