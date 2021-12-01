//
//  Crypto.swift
//  CryptoPiggy
//
//  Created by Paweł Brzozowski on 22/10/2021.
//

import Foundation
import UIKit

struct Cryptocoin: Codable {
    // REQUAIRMENTS: VALID COIN must have value prcie_usd and is_prypto must be true
    let asset_id: String
    let name: String?
    let type_is_crypto: Int
    let price_usd: Double?
}

