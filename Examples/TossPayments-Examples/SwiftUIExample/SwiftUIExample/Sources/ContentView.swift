//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by 김진규 on 2022/09/27.
//

#if !os(macOS) && canImport(SwiftUI)
import SwiftUI
import TossPayments

private enum Constants {
    static let clientKey: String = "test_ck_P24xLea5zVAqkMGkoG7VQAMYNwW6"
    static let 테스트결제정보: 결제정보 = 기본결제정보(
        amount: 1000,
        orderId: "9lD0azJWxjBY0KOIumGzH",
        orderName: "토스 티셔츠 외 2건",
        successUrl: "http://localhost:8080/success",
        failUrl: "http://localhost:8080/fail",
        customerName: "박토스"
    )
}

struct ContentView: View {
    @State private var showingTossPayments: Bool = false
    @State private var 입력한결제수단: 결제수단 = .카드
    @State private var 입력한결제정보: 결제정보 = Constants.테스트결제정보
    
    var 입력한결제정보레이블텍스트: String {
        """
        입력한 결제정보:
        \(입력한결제정보.orderedInfo)
        """
    }
    
    var body: some View {
        Text("입력한 결제수단: \(입력한결제수단.rawValue)")
            .padding()
        Text(입력한결제정보레이블텍스트)
            .padding()
        Picker("결제수단 입력", selection: $입력한결제수단) {
            ForEach(결제수단.allCases, id: \.self) {
                Text($0.rawValue)
            }
            Text("새로운 결제수단")
        }
        .padding()
        Button("시작", action: {
            showingTossPayments.toggle()
        })
        .popover(isPresented: $showingTossPayments, content: {
            TossPaymentsView(
                clientKey: Constants.clientKey,
                결제수단: 입력한결제수단,
                결제정보: 입력한결제정보,
                isPresented: $showingTossPayments
            )
            .onSuccess { (paymentKey: String, orderId: String, amount: Int64) in
                print("onSuccess paymentKey \(paymentKey)")
                print("onSuccess orderId \(orderId)")
                print("onSuccess amount \(amount)")
            }
            .onFail { (errorCode: String, errorMessage: String, orderId: String) in
                print("onFail errorCode \(errorCode)")
                print("onFail errorMessage \(errorMessage)")
                print("onFail orderId \(orderId)")
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#endif
