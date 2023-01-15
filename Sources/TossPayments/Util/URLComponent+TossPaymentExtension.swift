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

extension String {
    var urlEncoded: String {
        urlEncoded(allowedCharacters: "")
    }
    
    func urlEncoded(allowedCharacters: String) -> String {
        let stringSelf = self as String

        // does not include "?" or "/" due to RFC 3986 - Section 3.4
        //
        // 하지만 "/" 문자를 서버에서 받지 못하는 문제로 인해 포함시킵니다.
        // https://tossteam.slack.com/archives/C7V49P7A9/p1661826985586599
        let generalDelimitersToEncode = ":#[]@/"
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        allowedCharacterSet.insert(charactersIn: allowedCharacters)

        return stringSelf.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? stringSelf
    }
}
