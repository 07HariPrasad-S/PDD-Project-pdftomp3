//
//  Utils.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 19/02/25.
//

import Foundation
class Utils {
    static func convertISOToDateString(isoDate: String) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        // Convert string to Date
        if let date = isoFormatter.date(from: isoDate) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy"
            outputFormatter.timeZone = TimeZone.current  // Convert to local timezone if needed
            
            return outputFormatter.string(from: date)
        }
        return nil  // Return nil if conversion fails
    }
    static func formatDateString(dateString: String, fromFormat: String = "yyyy-MM-dd HH:mm:ss", toFormat: String = "dd/MM/yyyy") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone.current  // Adjust to local timezone if needed

        // Convert string to Date
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = toFormat
            return dateFormatter.string(from: date)
        }
        return nil  // Return nil if conversion fails
    }
}
