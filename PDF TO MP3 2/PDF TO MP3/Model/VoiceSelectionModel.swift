//
//  VoiceSelectionModel.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 14/02/25.
//


import Foundation

// MARK: - VoiceSelectionModel
struct VoiceSelectionModel: Codable {
    let status: Bool
    let message: String
    let data: [VoiceResponse]

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case message, data
    }
}

// MARK: - Datum
struct VoiceResponse: Codable {
    let selectedVoice: String

    enum CodingKeys: String, CodingKey {
        case selectedVoice = "selected_voice"
    }
}
