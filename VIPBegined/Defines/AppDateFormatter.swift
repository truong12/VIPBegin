//
//  AppDateFormatter.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/15/21.
//

import Foundation

enum DateFormat: String {
    case serverFull = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case entryDisplay = "h.mm a, dd MMM yyyy"
}

struct AppDateFormatter {
}

extension AppDateFormatter {
    static func getServiceString(of date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.serverFull.rawValue
        return dateFormatter.string(from: date)
    }

    static func convertServerToEntryDisplay(with dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.serverFull.rawValue
        let newDate = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = DateFormat.entryDisplay.rawValue
        if let newDate = newDate {
            return  dateFormatter.string(from: newDate)
        } else {
            return ""
        }
    }
}
