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
        static let defaultClientKey = "test_ck_P24xLea5zVA5mxMkelxVQAMYNwW6"
        static let defaultCustomerKey = "TOSSPAYMENTS"
        static let defaultBrandpayRedirectURL: String = {
            if let brandPayRedirectURL = Bundle.main.object(forInfoDictionaryKey: "BRANDPAY_REDIRECT_URL") as? String,
               !brandPayRedirectURL.isEmpty {
                return brandPayRedirectURL
            }
            return """
            https://tosspayments.com/redierct
            """
        }()
        static let defaultCountryName: String = "KR"
        static let defaultCurrencyName: String = "KRW"
        static let defaultStage = "v1"
        static let defaultVariantKey = "DEFAULT"
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

    // swiftlint:disable:next line_length
    static var countryName: String = UserDefaults.standard.string(forKey: "TossPayments.countryName") ?? Constant.defaultCountryName {
        didSet {
            UserDefaults.standard.set(countryName, forKey: "TossPayments.countryName")
        }
    }
    
    // swiftlint:disable:next line_length
    static var currencyName: String = UserDefaults.standard.string(forKey: "TossPayments.currencyName") ?? Constant.defaultCurrencyName {
        didSet {
            UserDefaults.standard.set(currencyName, forKey: "TossPayments.currencyName")
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
