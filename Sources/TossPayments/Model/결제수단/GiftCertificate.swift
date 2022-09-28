//
//  GiftCertificate.swift
//
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

public enum 상품권결제수단: String {
    case 문화상품권
    case 도서문화상품권
    case 게임문화상품권
    case CULTURE_GIFT_CERTIFICATE
    case BOOK_GIFT_CERTIFICATE
    case GAME_GIFT_CERTIFICATE
    
    var 결제수단: 결제수단 {
        return .init(rawValue: rawValue) ?? .문화상품권
    }
}
