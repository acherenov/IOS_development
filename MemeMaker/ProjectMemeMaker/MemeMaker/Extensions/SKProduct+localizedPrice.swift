//
//  SKProduct+localizedPrice.swift
//  ClubhouseAvatarMaker
//
//  Created by Alex Cherenov on 03.04.21.
//

import StoreKit

extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)!
    }
}

extension SKProductDiscount {
    var localizedPrice: String {
        if price == NSDecimalNumber(decimal: 0.00) {
                return NSLocalizedString("free", comment: "")
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)!
    }
}
