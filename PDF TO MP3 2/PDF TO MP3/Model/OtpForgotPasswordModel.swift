//
//  OtpForgotPasswordModel.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 10/02/25.
//

import Foundation
struct OtpForgotPasswordModel: Codable {
    let status: Bool
    let message, data: String

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case message, data
    }
}

