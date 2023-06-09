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
        static let defaultClientKey = "test_ck_0Poxy1XQL8R4P1zpv14V7nO5Wmlg"
        static let defaultCustomerKey = "TOSSPAYMENTS"
        static let defaultBrandpayRedirectURL = """
        https://testbox.dev.tosspayments.bz/api/brandpay/\(defaultStage)/callback-auth?secretKey=test_sk_GKNbdOvk5rkMyoBb1l43n07xlzmj
        """
        static let defaultStage = "alpha"
    }
    
    static var clientKey: String = UserDefaults.standard.string(forKey: "TossPayments.ClientKey") ?? Constant.defaultClientKey {
        didSet {
            UserDefaults.standard.set(clientKey, forKey: "TossPayments.ClientKey")
        }
    }
    
    static var customerKey: String = UserDefaults.standard.string(forKey: "TossPayments.CustomerKey") ?? Constant.defaultCustomerKey {
        didSet {
            UserDefaults.standard.set(customerKey, forKey: "TossPayments.CustomerKey")
        }
    }
    
    /// 현재 redirectURL의 미구현으로 브랜드페이는 정상적으로 동작하지 않고 있다.
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
}
