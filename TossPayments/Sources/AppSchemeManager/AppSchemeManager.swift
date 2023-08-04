//
//  AppSchemeManager.swift
//  
//
//  Created by https://github.com/MussaCharles on 2023/05/17.
//

import UIKit
import Foundation

/// An enumeration holding a list of all different app schemes that the application knows about and can handle.
enum AppSchemeManager: CaseIterable {
    /// 뱅크페이
    case bankpay
    /// ISP/페이북
    case ispmobile
    /// 현대카드 앱카드
    case hdcard
    /// 신한 앱카드
    case shinhan
    /// KB국민 앱카드
    case kb
    /// KB스타뱅킹
    case kbbank
    /// 삼성앱카드
    case samsung
    /// 롯데 모바일결제
    case lottemobile
    /// 롯데 앱카드
    case lottecard
    /// 하나1Q페이(앱카드)
    case hana1qpay
    /// 시티은행 앱카드
    case citi
    /// 페이코
    case payco
    /// 카카오톡
    case kakaotalk
    /// 롯데 L.pay(구)
    case lpay
    /// 롯데 L.pay(L.POINT App)
    case lmslpay
    /// 우리페이
    case woori
    /// 우리카드(신규)
    case wooricard
    /// NH농협카드 올원페이(앱카드)
    case nhcard
    /// 하나카드(하나멤버스 월렛)
    case hanacard
    /// 신세계 SSGPAY
    case ssgpay
    /// 차이
    case chai
    /// 국민 본인인증
    case kbauth
    /// 현대 본인인증
    case hyundaicardappcardid
    /// 페이나우
    case lguthepayxpay
    /// Liiv 국민
    case liivbank
    /// 토스
    case supertoss
    /// 우리WON뱅킹
    case newsmartpib
    /// 네이버앱
    case naversearchthirdlogin
    
    var scheme: String {
        switch self {
            
        case .bankpay:
            return "kftc-bankpay"
        case .ispmobile:
            return "ispmobile"
        case .hdcard:
            return "hdcardappcardansimclick"
        case .shinhan:
            return "shinhan-sr-ansimclick"
        case .kb:
            return "kb-acp"
        case .kbbank:
            return "kbbank"
        case .samsung:
            return "mpocket.online.ansimclick"
        case .lottemobile:
            return "lottesmartpay"
        case .lottecard:
            return "lotteappcard"
        case .hana1qpay:
            return "cloudpay"
        case .citi:
            return "citimobileapp"
        case .payco:
            return "payco"
        case .kakaotalk:
            return "kakaotalk"
        case .lpay:
            return "lpayapp"
        case .woori:
            return "wooripay"
        case .nhcard:
            return "nhallonepayansimclick"
        case .hanacard:
            return "hanawalletmembers"
        case .ssgpay:
            return "shinsegaeeasypayment"
        case .chai:
            return "chaipayment"
        case .kbauth:
            return "kb-auth"
        case .hyundaicardappcardid:
            return "hyundaicardappcardid"
        case .lmslpay:
            return "lmslpay"
        case .wooricard:
            return "com.wooricard.wcard"
        case .lguthepayxpay:
            return "lguthepay-xpay"
        case .liivbank:
            return "liivbank"
        case .supertoss:
            return "supertoss"
        case .newsmartpib:
            return "newsmartpib"
        case .naversearchthirdlogin:
            return "naversearchthirdlogin"
        }
    }
    
    var appID: String {
        switch self {
            
        case .bankpay:
            return "id398456030"
        case .ispmobile:
            return "id369125087"
        case .hdcard:
            return "id702653088"
        case .shinhan:
            return "id572462317"
        case .kb:
            return "id695436326"
        case .kbbank:
            return "id373742138"
        case .samsung:
            return "id535125356"
        case .lottemobile:
            return "id668497947"
        case .lottecard:
            return "id688047200"
        case .hana1qpay:
            return "id847268987"
        case .citi:
            return "id1179759666"
        case .payco:
            return "id924292102"
        case .kakaotalk:
            return "id362057947"
        case .lpay:
            return "id1036098908"
        case .woori:
            return "id1201113419"
        case .nhcard:
            return "id1177889176"
        case .hanacard:
            return "id1038288833"
        case .ssgpay:
            return "id666237916"
        case .chai:
            return "id1459979272"
        case .kbauth:
            return "id695436326"
        case .hyundaicardappcardid:
            return "id702653088"
        case .lmslpay:
            return "id473250588"
        case .wooricard:
            return "id1499598869"
        case .lguthepayxpay:
            return "id760098906"
        case .liivbank:
            return "id1126232922"
        case .supertoss:
            return "id839333328"
        case .newsmartpib:
            return "id1470181651"
        case .naversearchthirdlogin:
            return "id393499958"
        }
    }   
}

// MARK: - Internal Helpers
extension AppSchemeManager {
    
    /**
     This function is used to generate an App Store URL based on a provided app scheme.

     - Parameter scheme: The string value of the app scheme for which the App Store URL is to be generated.

     - Returns: A string representing the App Store URL corresponding to the given app scheme.
        If the app scheme does not correspond to any known app ID the function will return `nil`,
        indicating that the provided scheme needs to be manually added.
     */
    static func appStoreUrlFrom(scheme: String) -> String? {
        let appScheme = appSchemeFrom(scheme)
        
        guard let appId = appScheme?.appID else {
            // In this case we have an id which does not exist in our enum. Manual adding that scheme is needed.
            return nil
        }
        let marketUrl = "itms-apps://itunes.apple.com/app/\(appId)"
        return marketUrl
    }
}

// MARK: - Private Helpers
private extension AppSchemeManager {
    
    /**
     This function is used to retrieve an `AppSchemeManager` object that corresponds 
     to a given raw string representing an app scheme by performing a case-insensitive
      comparison between the provided raw string and the scheme property of each 
      `AppSchemeManager` object.
     - Parameter schemeRawString: The raw string that represents the app scheme for
      which the corresponding `AppSchemeManager` object is to be found.

     - Returns: An `AppSchemeManager` object that corresponds to the given raw string
      if one exists. If the raw string does not correspond to any `AppSchemeManager`
       object, the function will return `nil`.
     */
    static func appSchemeFrom(_ schemeRawString: String) -> AppSchemeManager? {
        
        for value in AppSchemeManager.allCases {
            // swiftlint:disable:next for_where
            if schemeRawString.caseInsensitiveCompare(value.scheme) == .orderedSame {
                return value
            }
        }
        
        return nil
    }
    
}
