//
//  File.swift
//  
//
//  Created by 김진규 on 2023/03/16.
//

import Foundation

enum TossPaymentsEnvironment {
    static var stage: String {
        UserDefaults.standard.string(forKey: "TossPayments.Stage") ?? "v1"
    }
}
