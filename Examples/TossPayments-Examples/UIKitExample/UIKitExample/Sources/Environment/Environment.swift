//
//  File.swift
//  
//
//  Created by 김진규 on 2023/01/16.
//

import Foundation

final class Environment {
    static var clientKey: String = UserDefaults.standard.string(forKey: "TossPayments.ClientKey") ?? "test_ck_OyL0qZ4G1VODAxdNWDkroWb2MQYg" {
        didSet {
            UserDefaults.standard.set(clientKey, forKey: "TossPayments.ClientKey")
        }
    }
}
