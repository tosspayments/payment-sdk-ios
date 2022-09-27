//
//  File.swift
//  
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

extension URLComponents {
    func query(for key: String) -> String {
        return queryItems?.first(where: { $0.name == key })?.value ?? ""
    }
}
