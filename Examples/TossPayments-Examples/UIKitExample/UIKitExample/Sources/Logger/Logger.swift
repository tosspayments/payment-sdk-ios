//
//  Logger.swift
//  UIKitExample
//
//  Created by 김진규 on 2023/06/20.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

import Foundation

enum Logger {
    static func debug(_ text: String) {
        print(text)
        OverlayLogDisplayManager.shared.log(text)
    }
}
