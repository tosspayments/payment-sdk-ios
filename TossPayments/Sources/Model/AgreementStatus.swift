//
//  AgreementStatus.swift
//  
//
//  Created by 김진규 on 2023/05/09.
//

import Foundation

public class AgreementStatus: NSObject, Codable {
    
    // 고객이 모든 필수 약관에 동의했는지 알려줍니다.
    public let agreedRequiredTerms: Bool
    
    // 개별 약관에 동의했는지 알려줍니다.
    public let terms: [AgreementTerm]
}

public struct AgreementTerm: Codable {
    
    // 약관의 식별자입니다.
    public let id: String
    
    // 약관의 고객 동의 여부입니다.
    public let agreed: Bool
    
    // 약관의 필수 여부입니다.
    public let required: Bool
}
