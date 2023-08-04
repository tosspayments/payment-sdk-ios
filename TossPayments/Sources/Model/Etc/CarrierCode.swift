//
//  File.swift
//  
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

public enum CarrierCode: Codable, RawRepresentable {
    case KT
    case LGU
    case SKT
    case HELLO
    case KCT
    case SK7
    case custom(code: String)
    
    public init?(rawValue: String) {
        switch rawValue {
        case "KT": self = .KT
        case "LGU": self = .LGU
        case "SKT": self = .SKT
        case "HELLO": self = .HELLO
        case "KCT": self = .KCT
        case "SK7": self = .SK7
        default: self = .custom(code: rawValue)
        }
    }
    
    public var rawValue: String {
        switch self {
        case .KT: return "KT"
        case .LGU: return "LGU"
        case .SKT: return "SKT"
        case .HELLO: return "HELLO"
        case .KCT: return "KCT"
        case .SK7: return "SK7"
        case let .custom(code): return code
        }
    }
}
