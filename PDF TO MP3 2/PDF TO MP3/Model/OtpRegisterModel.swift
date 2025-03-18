//
//  OtpRegisterModel.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 10/02/25.
//

import Foundation
struct OtpRegisterModel: Codable {
    let status: Bool
    let message: String
    let data: [[otpRegisterData]]

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case message, data
    }
}

// MARK: - Datum
struct otpRegisterData: Codable {
    let id: Int
    let username, passwords: String
}

