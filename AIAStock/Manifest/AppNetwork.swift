//
//  AppNetwork.swift
//  AIAStock
//
//  Created by Bona Deny S on 10/9/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import Foundation

enum Query: String {
    case function = "function"
    case symbol = "symbol"
    case interval = "interval"
    case outputsize = "outputsize"
    case apikey = "apikey"
}

class AppNetwork{
    private var base_key = "T9SRHE6XMYNUBAJ9"
    private var interval = "5min"
    private var outputsize = "compact"
    private let base_url = "https://www.alphavantage.co/"
    
    init() {
        if let receivedData = KeychainSwift().get(Query.apikey.rawValue) {
            self.base_key = receivedData
        }
        
        if UserDefaults.standard.string(forKey: Query.interval.rawValue) != nil {
            self.interval = UserDefaults.standard.string(forKey: Query.interval.rawValue)!
        }
        if UserDefaults.standard.string(forKey: Query.outputsize.rawValue) != nil {
            self.outputsize = UserDefaults.standard.string(forKey: Query.outputsize.rawValue)!
        }
    }

    func get(type: String, queries: [Query:String], completionHandler: @escaping (_ data:Data?, _ response: URLResponse?, _ error: Error?) -> Void){
        let task = URLSession.shared.dataTask(with: query(type: type, queries: queries), completionHandler: completionHandler)
            task.resume()
    }
    private func query(type: String, queries: [Query:String]) -> URL{
        var compounents = URLComponents(string: base_url+type)
        compounents?.queryItems = [
            URLQueryItem(name: Query.function.rawValue, value: queries[Query.function]),
            URLQueryItem(name: Query.symbol.rawValue, value: queries[Query.symbol]),
            URLQueryItem(name: Query.outputsize.rawValue, value: outputsize),
            URLQueryItem(name: Query.apikey.rawValue, value: base_key)
        ]
        if(queries[Query.interval] != nil){
            compounents?.queryItems?.append(URLQueryItem(name: Query.interval.rawValue, value: interval))
        }
        return (compounents?.url)!
    }
}
