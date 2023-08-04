//
//  WidgetStatus.swift
//  
//
//  Created by 김진규 on 2023/06/20.
//

import Foundation

public class WidgetStatus: NSObject, Codable {
    
    // 위젯 paymentMethods | agreement
    public let widget: String
    
    // status
    public let status: String
}

