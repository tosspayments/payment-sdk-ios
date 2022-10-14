//
//  GiftCertificate.swift
//
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

public enum GiftCertificatePaymentMethod: String {
    case 문화상품권
    case 도서문화상품권
    case 게임문화상품권
    case CULTURE_GIFT_CERTIFICATE
    case BOOK_GIFT_CERTIFICATE
    case GAME_GIFT_CERTIFICATE
    
    var paymentMethod: PaymentMethod {
        return .init(rawValue: rawValue) ?? .문화상품권
    }
}
