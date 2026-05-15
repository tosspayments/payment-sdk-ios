//
//  SubOrder.swift
//
//
//  Created by TossPayments on 2026/05/14.
//

import Foundation

public struct SubOrder: Codable {
    public struct MerchantAddress: Codable {
        public let country: String
        public let postalCode: String
        public let address: String
        public let detailAddress: String?

        public init(
            country: String,
            postalCode: String,
            address: String,
            detailAddress: String? = nil
        ) {
            self.country = country
            self.postalCode = postalCode
            self.address = address
            self.detailAddress = detailAddress
        }
    }

    public let merchantBusinessNumber: String
    public let merchantName: String
    public let merchantAddress: MerchantAddress
    public let orderName: String

    public init(
        merchantBusinessNumber: String,
        merchantName: String,
        merchantAddress: MerchantAddress,
        orderName: String
    ) {
        self.merchantBusinessNumber = merchantBusinessNumber
        self.merchantName = merchantName
        self.merchantAddress = merchantAddress
        self.orderName = orderName
    }
}
