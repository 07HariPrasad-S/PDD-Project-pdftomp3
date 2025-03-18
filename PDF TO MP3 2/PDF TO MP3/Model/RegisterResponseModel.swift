import Foundation

// MARK: - RegisterResponseModel
struct RegisterResponseModel: Codable {
    let status: Bool
    let message: String
    let data: [SignupData]

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case message, data
    }
}

// MARK: - Datum
struct SignupData: Codable {
    let otp: Int
}

