//
//  ForgotPasswordModel.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 10/02/25.
//

import Foundation
struct ForgotPasswordModel: Codable {
    let status: Bool
    let message: String
    let data: ForgotData

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case message, data
    }
}

// MARK: - DataClass
struct ForgotData: Codable {
    let yourOTP: Int

    enum CodingKeys: String, CodingKey {
        case yourOTP = " your OTP"
    }
}

