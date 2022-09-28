//
//  File.swift
//  
//
//  Created by 김진규 on 2022/09/27.
//

#if canImport(SwiftUI) && canImport(UIKit)
import SwiftUI

@available(iOS 14.0, *)
public struct TossPaymentsView: View {
    
    private let service: TossPaymentsService
    @Binding public var isPresented: Bool
    public init(
        clientKey: String,
        결제수단: 결제수단,
        결제정보: 결제정보,
        isPresented: Binding<Bool>
    ) {
        self.service = TossPaymentsService(
            clientKey: clientKey,
            결제수단: 결제수단,
            결제정보: 결제정보
        )
        _isPresented = isPresented
    }
    
    public var body: some View {
        VStack {
            TossPaymentsWebView(service: service)
        }
    }
    
    public func onSuccess(_ successHandler: @escaping (_ paymentKey: String, _ orderId: String, _ amount: Int64) -> Void) -> Self {
        service.successURLHandler = { url in
            self.isPresented = false
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
            let paymentKey = components.query(for: "paymentKey")
            let orderId = components.query(for: "orderId")
            let amount = Int64(components.query(for: "amount")) ?? 0
            successHandler(paymentKey, orderId, amount)
        }
        
        return self
    }
    
    public func onFail(_ failureHandler: @escaping (_ erroCode: String, _ errorMessage: String, _ orderId: String) -> Void) -> Self {
        service.failURLHandler = { url in
            self.isPresented = false
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
            let errorCode = components.query(for: "code")
            let errorMessage = components.query(for: "message")
            let orderId = components.query(for: "orderId")
            failureHandler(errorCode, errorMessage, orderId)
        }
        return self
    }
}

@available(iOS 14.0, *)
struct View_Previews: PreviewProvider {
    static var previews: some View {
        TossPaymentsView(
            clientKey: "TEST",
            결제수단: .custom(method: "TEST"),
            결제정보: 기본결제정보(
                amount: 100,
                orderId: "TEST",
                orderName: "TESTER",
                successUrl: "tosspayments://",
                failUrl: "tosspayments://"
            ),
            isPresented: .constant(false)
        )
    }
}

#endif
