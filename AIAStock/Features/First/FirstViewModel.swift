//
//  FirstViewModel.swift
//  AIAStock
//
//  Created by Bona Deny S on 10/8/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import Foundation

class FirstViewModel {
    private let type = "query"
    private let function = "TIME_SERIES_INTRADAY"
    private let interval = "5min"
    
    func fetch(symbol: String, completion: @escaping ([Stock]) -> Void) {
        AppNetwork().get(type: type, queries: [Query.function:function, Query.interval:interval, Query.symbol:symbol]) { (data, response, error) in
            DispatchQueue.main.async {
                let results = try! JSONDecoder().decode(Stocks.self, from: data!)
                var stocks: [Stock] = []
                var intraday: [String: Stock]?
                
                if let interval = UserDefaults.standard.string(forKey: Query.interval.rawValue) {
                    switch interval {
                    case "1min":
                        intraday = results.intraday1
                        break
                    case "5min":
                        intraday = results.intraday5
                        break
                    case "15min":
                        intraday = results.intraday15
                        break
                    case "30min":
                        intraday = results.intraday30
                        break
                    case "60min":
                        intraday = results.intraday60
                        break
                    default:
                        break
                    }
                }
                if let results = intraday {
                    for result in results {
                        stocks.append(Stock(date: result.key, open: result.value.open, high: result.value.high, low: result.value.low, close: result.value.close, volume: result.value.volume))
                    }
                }
                if stocks.count > 0 {
                    completion(stocks)
                }else {
                    completion([])
                }
            }
        }
    }
}
