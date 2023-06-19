//
//  File.swift
//  
//
//  Created by 김진규 on 2023/01/16.
//

import Foundation

public final class Environment {
    public enum Constant {
        public static let appScheme: String? = {
            guard let infoDictionary = Bundle.main.infoDictionary,
                  let bundleURLTypes = infoDictionary["CFBundleURLTypes"] as? [[String: Any]],
                  let firstBundleURLType = bundleURLTypes.first,
                  let bundleURLSchemes = firstBundleURLType["CFBundleURLSchemes"] as? [String],
                  let scheme = bundleURLSchemes.first else {
                return nil
            }
            return scheme + "://"
        }()

        static let defaultClientKey = "live_ck_JQbgMGZzorzj0ZnKbOjrl5E1em4d"
        static let defaultCustomerKey = "TOSSPAYMENTS"
        static let defaultBrandpayRedirectURL: String = {
            if let infoDictionary = Bundle.main.infoDictionary,
               let brandpayRedirectURL = infoDictionary["BRANDPAY_REDIRECT_URL"] as? String,
               !brandPayRedirectURL.isEmpty {
                return brandpayRedirectURL
            }
            return """
            https://tosspayments.com/redierct
            """
        }()
        static let defaultStage = "beta"
        static let defaultVariantKey = "CardOnly"
    }
    
    // swiftlint:disable:next line_length
    static var clientKey: String = UserDefaults.standard.string(forKey: "TossPayments.ClientKey") ?? Constant.defaultClientKey {
        didSet {
            UserDefaults.standard.set(clientKey, forKey: "TossPayments.ClientKey")
        }
    }
    // swiftlint:disable:next line_length
    static var customerKey: String = UserDefaults.standard.string(forKey: "TossPayments.CustomerKey") ?? Constant.defaultCustomerKey {
        didSet {
            UserDefaults.standard.set(customerKey, forKey: "TossPayments.CustomerKey")
        }
    }
    
    // swiftlint:disable:next line_length
    static var brandPayRedirectURL: String = UserDefaults.standard.string(forKey: "TossPayments.BrandPayRedirectURL") ?? Constant.defaultBrandpayRedirectURL {
        didSet {
            UserDefaults.standard.set(brandPayRedirectURL, forKey: "TossPayments.BrandPayRedirectURL")
        }
    }
    
    static var stage: String = UserDefaults.standard.string(forKey: "TossPayments.Stage") ?? Constant.defaultStage {
        didSet {
            UserDefaults.standard.set(stage, forKey: "TossPayments.Stage")
        }
    }
    
    // swiftlint:disable:next line_length
    static var variantKey: String = UserDefaults.standard.string(forKey: "TossPayments.VariantKey") ?? Constant.defaultVariantKey {
        didSet {
            UserDefaults.standard.set(variantKey, forKey: "TossPayments.VariantKey")
        }
    }

}
