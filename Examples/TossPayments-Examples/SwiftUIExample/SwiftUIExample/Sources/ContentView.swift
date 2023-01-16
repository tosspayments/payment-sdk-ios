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
    static let clientKey: String = "test_ck_OyL0qZ4G1VODAxdNWDkroWb2MQYg"
    static let 테스트결제정보: PaymentInfo = DefaultPaymentInfo(
        amount: 1000,
        orderId: "9lD0azJWxjBY0KOIumGzH",
        orderName: "토스 티셔츠 외 2건",
        customerName: "박토스"
    )
}

struct ContentView: View {
    @State private var showingTossPayments: Bool = false
    
    @State private var showingResultAlert: Bool = false
    @State private var resultInfo: (title: String, message: String)? = nil
    
    @State private var 입력한결제수단: PaymentMethod = .카드
    @State private var 입력한결제정보: PaymentInfo = Constants.테스트결제정보
    
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
            ForEach(PaymentMethod.allCases, id: \.self) {
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
                paymentMethod: 입력한결제수단,
                paymentInfo: 입력한결제정보,
                isPresented: $showingTossPayments
            )
            .onSuccess { (paymentKey: String, orderId: String, amount: Int64) in
                print("onSuccess paymentKey \(paymentKey)")
                print("onSuccess orderId \(orderId)")
                print("onSuccess amount \(amount)")
                let title = "TossPayments 요청에 성공하였습니다."
                let message = """
                    onSuccess
                    paymentKey: \(paymentKey)
                    orderId: \(orderId)
                    amount: \(amount)
                    """
                resultInfo = (title, message)
                showingResultAlert = true
            }
            .onFail { (errorCode: String, errorMessage: String, orderId: String) in
                print("onFail errorCode \(errorCode)")
                print("onFail errorMessage \(errorMessage)")
                print("onFail orderId \(orderId)")
                let title = "TossPayments 요청에 실패하였습니다."
                let message = """
                onFail
                errorCode: \(errorCode)
                errorMessage: \(errorMessage)
                orderId: \(orderId)
                """
                resultInfo = (title, message)
                showingResultAlert = true
            }
            .alert(isPresented: $showingResultAlert) {
                Alert(
                    title: Text("\(resultInfo?.title ?? "")"),
                    message: Text("\(resultInfo?.message ?? "")"),
                    primaryButton: .default(Text("확인"), action: {
                        resultInfo = nil
                    }),
                    secondaryButton: .destructive(Text("클립보드에 복사하기"), action: {
                        UIPasteboard.general.string = resultInfo?.message
                        resultInfo = nil
                    })
                )
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
