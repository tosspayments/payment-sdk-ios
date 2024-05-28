//
//  File.swift
//  
//
//  Created by 김진규 on 2022/09/27.
//

import Foundation

public enum PaymentMethod: Hashable, Codable, CaseIterable, RawRepresentable {
    case 카드
    case 계좌
    case 토스페이
    case 가상계좌
    case 계좌이체
    case 휴대폰
    case 문화상품권
    case 도서문화상품권
    case 게임문화상품권
    case 해외간편결제

    case CARD
    case TOSSPAY
    case VIRTUAL_ACCOUNT
    case TRANSFER
    case MOBILE_PHONE
    case CULTURE_GIFT_CERTIFICATE
    case BOOK_GIFT_CERTIFICATE
    case GAME_GIFT_CERTIFICATE
    case FOREIGN_EASY_PAY

    case custom(method: String)

    // swiftlint:disable:next cyclomatic_complexity
    public init?(rawValue: String) {
        switch rawValue {
        case "카드": self = .카드
        case "계좌": self = .계좌
        case "토스페이": self = .토스페이
        case "가상계좌": self = .가상계좌
        case "계좌이체": self = .계좌이체
        case "휴대폰": self = .휴대폰
        case "문화상품권": self = .문화상품권
        case "도서문화상품권": self = .도서문화상품권
        case "게임문화상품권": self = .게임문화상품권
        case "해외간편결제": self = .해외간편결제
        case "CARD": self = .CARD
        case "TOSSPAY": self = .TOSSPAY
        case "VIRTUAL_ACCOUNT": self = .VIRTUAL_ACCOUNT
        case "TRANSFER": self = .TRANSFER
        case "MOBILE_PHONE": self = .MOBILE_PHONE
        case "CULTURE_GIFT_CERTIFICATE": self = .CULTURE_GIFT_CERTIFICATE
        case "BOOK_GIFT_CERTIFICATE": self = .BOOK_GIFT_CERTIFICATE
        case "GAME_GIFT_CERTIFICATE": self = .GAME_GIFT_CERTIFICATE
        case "FOREIGN_EASY_PAY": self = .FOREIGN_EASY_PAY
        default: self = .custom(method: rawValue)
        }
    }

    public var rawValue: String {
        switch self {
        case .카드: return "카드"
        case .계좌: return "계좌"
        case .토스페이: return "토스페이"
        case .가상계좌: return "가상계좌"
        case .계좌이체: return "계좌이체"
        case .휴대폰: return "휴대폰"
        case .문화상품권: return "문화상품권"
        case .도서문화상품권: return "도서문화상품권"
        case .게임문화상품권: return "게임문화상품권"
        case .해외간편결제: return "해외간편결제"
        case .CARD: return "CARD"
        case .TOSSPAY: return "TOSSPAY"
        case .VIRTUAL_ACCOUNT: return "VIRTUAL_ACCOUNT"
        case .TRANSFER: return "TRANSFER"
        case .MOBILE_PHONE: return "MOBILE_PHONE"
        case .CULTURE_GIFT_CERTIFICATE: return "CULTURE_GIFT_CERTIFICATE"
        case .BOOK_GIFT_CERTIFICATE: return "BOOK_GIFT_CERTIFICATE"
        case .GAME_GIFT_CERTIFICATE: return "GAME_GIFT_CERTIFICATE"
        case .FOREIGN_EASY_PAY: return "FOREIGN_EASY_PAY"
        case let .custom(method):
            return method
        }
    }

    public static var allCases: [PaymentMethod] {
        return [
            .카드, .계좌, .토스페이, .가상계좌, .계좌이체, .휴대폰, .문화상품권, .도서문화상품권,
            .게임문화상품권, .해외간편결제, .CARD, .TOSSPAY, .VIRTUAL_ACCOUNT, .TRANSFER, .MOBILE_PHONE,
            .CULTURE_GIFT_CERTIFICATE, .BOOK_GIFT_CERTIFICATE, .GAME_GIFT_CERTIFICATE, .FOREIGN_EASY_PAY
        ]
    }
}
