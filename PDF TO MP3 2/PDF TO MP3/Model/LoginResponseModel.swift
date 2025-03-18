//
//  LoginResponseModel.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 08/02/25.
//


import Foundation

// MARK: - LoginResponseModel
struct LoginResponseModel: Codable {
    let status: Bool
    let message: String
    let data: [LoginData]

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case message, data
    }
}

// MARK: - Datum
struct LoginData: Codable {
    let id: Int
    let username, passwords: String
}
