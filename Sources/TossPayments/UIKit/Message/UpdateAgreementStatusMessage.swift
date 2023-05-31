//
//  UpdateAgreementStatusMessage.swift
//  
//
//  Created by 김진규 on 2023/05/11.
//

import Foundation

final class UpdateAgreementStatusMessage: WidgetMessageProtocol {
    typealias Response = AgreementStatus
    var name: String { "updateAgreementStatus" }
    let jsonObject: [String: Any]
    
    init(jsonObject: [String: Any]) {
        self.jsonObject = jsonObject
    }
}
