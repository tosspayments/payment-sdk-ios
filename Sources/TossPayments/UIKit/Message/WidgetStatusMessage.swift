//
//  WidgetStatusMessage.swift
//  
//
//  Created by 김진규 on 2023/06/20.
//

import Foundation

final class WidgetStatusMessage: WidgetMessageProtocol {
    typealias Response = WidgetStatus
    var name: String { "widgetStatus" }
    let jsonObject: [String: Any]
    
    init(jsonObject: [String: Any]) {
        self.jsonObject = jsonObject
    }
}
