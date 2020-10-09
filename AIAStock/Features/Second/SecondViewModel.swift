//
//  SecondViewModel.swift
//  AIAStock
//
//  Created by Bona Deny S on 10/9/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import Foundation

class SecondViewModel {
    private let type = "query"
    private let function = "TIME_SERIES_DAILY"
    
    func fetch(symbol: String, completion: @escaping ([Stock]) -> Void) {
        AppNetwork().get(type: type, queries: [Query.function:function, Query.symbol:symbol]) { (data, response, error) in
            DispatchQueue.main.async {
                let results = try! JSONDecoder().decode(Stocks.self, from: data!)
                var stocks: [Stock] = []
                if let results = results.daily {
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
