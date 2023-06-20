//
//  File.swift
//  
//
//  Created by 김진규 on 2023/06/20.
//

import Foundation
import WebKit

typealias PaymentWidgetComponent = WKUIDelegate & CanUpdateHeight & BrowserPopupHandler & HasWidgetStatusDelegate

protocol HasWidgetStatusDelegate {
    var widgetStatusDelegate: TossPaymentsWidgetStatusDelegate? { get }
}
