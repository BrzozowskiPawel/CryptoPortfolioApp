//
//  Crypto.swift
//  CryptoPiggy
//
//  Created by Paweł Brzozowski on 22/10/2021.
//

import Foundation

struct Crypto: Codable {
    let asset_id: String
    let name: String?
    let type_is_crypto: Int
    let price_usd: Float?
    let id_icon: String?
}

//    "asset_id": "USD",
//    "name": "US Dollar",
//    "type_is_crypto": 0,
//    "data_quote_start": "2014-02-24T17:43:05.0000000Z",
//    "data_quote_end": "2021-10-22T10:30:03.1360822Z",
//    "data_orderbook_start": "2014-02-24T17:43:05.0000000Z",
//    "data_orderbook_end": "2020-08-05T14:38:00.7082850Z",
//    "data_trade_start": "2010-07-17T23:09:17.0000000Z",
//    "data_trade_end": "2021-10-22T10:30:49.5880000Z",
//    "data_symbols_count": 82660,
//    "volume_1hrs_usd": 3674957631401.13,
//    "volume_1day_usd": 153245627986465.38,
//    "volume_1mth_usd": 4528949229778998.37,
//    "id_icon": "0a4185f2-1a03-4a7c-b866-ba7076d8c73b",
//    "data_start": "2010-07-17",
//    "data_end": "2021-10-22"
