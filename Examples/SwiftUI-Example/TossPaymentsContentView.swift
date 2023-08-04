//
//  TossPaymentsContentView.swift
//  SwiftUIExample
//
//  Created by 김진규 on 2022/09/27.
//

#if !os(macOS) && canImport(SwiftUI)
import SwiftUI
import TossPayments

private enum Constants {
    static let clientKey: String = "test_ck_P24xLea5zVAqkMGkoG7VQAMYNwW6"
    static let 테스트결제정보: PaymentInfo = DefaultPaymentInfo(
        amount: 1000,
        orderId: "9lD0azJWxjBY0KOIumGzH",
        orderName: "토스 티셔츠 외 2건",
        customerName: "박토스"
    )
}

struct TossPaymentsContentView: View {
    @State private var showingSuccess: Bool = false
    @State private var showingFail: Bool = false
    
    
    @StateObject
    var viewModel = TossPaymentsContentViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                PaymentMethodWidgetView(widget: viewModel.widget, amount: PaymentMethodWidget.Amount(value: 1000))
                AgreementWidgetView(widget: viewModel.widget)
            }
        }
        Button("결제하기") {
            viewModel.requestPayment(info: DefaultWidgetPaymentInfo(orderId: "123", orderName: "김토스"))
        }
        .alert(isPresented: $showingSuccess, content: {
            Alert(title: Text(verbatim: "Success"), message: Text(verbatim: viewModel.onSuccess?.orderId ?? ""))
        })
        .alert(isPresented: $showingFail, content: {
            Alert(title: Text(verbatim: "Fail"), message: Text(verbatim: viewModel.onFail?.orderId ?? ""))
        })
        .onReceive(viewModel.$onSuccess.compactMap { $0 }) { success in
            showingSuccess = true
        }
        .onReceive(viewModel.$onFail.compactMap { $0 }) { fail in
            showingFail = true
        }
    }
}

struct TossPaymentsContentView_Previews: PreviewProvider {
    static var previews: some View {
        TossPaymentsContentView()
    }
}

#endif
