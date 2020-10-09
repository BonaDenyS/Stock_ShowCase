//
//  StockModel.swift
//  AIAStock
//
//  Created by Bona Deny S on 10/8/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import Foundation

// MARK: - Stocks
struct Stocks: Codable {
    let intraday15, intraday1, intraday5, intraday30, intraday60, daily: [String: Stock]?

    enum CodingKeys: String, CodingKey {
        case intraday5 = "Time Series (5min)"
        case intraday15 = "Time Series (15min)"
        case intraday1 = "Time Series (1min)"
        case intraday30 = "Time Series (30min)"
        case intraday60 = "Time Series (60min)"
        case daily = "Time Series (Daily)"
    }
}

struct Stock: Codable {
    let date: String?
    let open, high, low, close, volume: String

    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
        case date = ""
    }
}
