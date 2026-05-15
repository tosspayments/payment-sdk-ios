//
//  File.swift
//  
//
//  Created by 김진규 on 2022/12/06.
//

#if canImport(UIKit)

import UIKit
import WebKit
import TossPayments

public final class PaymentWidgetViewController: ViewController {
    enum Constant {
        static let defaultAmount: Double = 1000
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    var isWebLoaded: Bool = false
    
    private lazy var amountInputField = TextField()
    private lazy var orderIdInputField = TextField()
    private lazy var orderNameInputField = TextField()
    private lazy var subOrderMerchantBusinessNumberInputField = TextField()
    private lazy var subOrderMerchantNameInputField = TextField()
    private lazy var subOrderMerchantCountryInputField = TextField()
    private lazy var subOrderMerchantPostalCodeInputField = TextField()
    private lazy var subOrderMerchantAddressInputField = TextField()
    private lazy var subOrderMerchantDetailAddressInputField = TextField()
    private lazy var subOrderNameInputField = TextField()
    
    private lazy var widget: PaymentWidget = PaymentWidget(
        clientKey: Environment.clientKey,
        customerKey: Environment.customerKey,
        options: PaymentWidget.Options(
            brandpay: PaymentWidget.BrandPay(redirectURL: Environment.brandPayRedirectURL)
        )
    )
    private lazy var 빈화면 = UIView()
    
    private lazy var button = UIButton()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "위젯"
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        scrollViewBottomAnchorConstraint?.isActive = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 60),
            button.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        button.backgroundColor = .systemBlue
        button.setTitle("결제하기", for: .normal)
        button.addTarget(self, action: #selector(requestPayment), for: .touchUpInside)
        
        let paymentMethodWidget = widget.renderPaymentMethods(
            amount: PaymentMethodWidget.Amount(
                value: 1000,
                currency: Environment.currencyName,
                country: Environment.countryName
            ),
            options: PaymentMethodWidget.Options(variantKey: Environment.variantKey)
        )
        let agreementWidget = widget.renderAgreement()
        
        stackView.addArrangedSubview(amountInputField)
        stackView.addArrangedSubview(orderIdInputField)
        stackView.addArrangedSubview(orderNameInputField)
        stackView.addArrangedSubview(subOrderMerchantBusinessNumberInputField)
        stackView.addArrangedSubview(subOrderMerchantNameInputField)
        stackView.addArrangedSubview(subOrderMerchantCountryInputField)
        stackView.addArrangedSubview(subOrderMerchantPostalCodeInputField)
        stackView.addArrangedSubview(subOrderMerchantAddressInputField)
        stackView.addArrangedSubview(subOrderMerchantDetailAddressInputField)
        stackView.addArrangedSubview(subOrderNameInputField)
        stackView.addArrangedSubview(paymentMethodWidget)
        stackView.addArrangedSubview(빈화면)
        stackView.addArrangedSubview(agreementWidget)
        
        amountInputField.title = "amount (원)"
        amountInputField.text = "\(Constant.defaultAmount)"
        orderIdInputField.title = "orderId"
        orderIdInputField.text = UUID().uuidString
        orderNameInputField.title = "orderName"
        orderNameInputField.text = "토스페이먼츠 세트"
        subOrderMerchantBusinessNumberInputField.title = "subOrders[0].merchantBusinessNumber"
        subOrderMerchantBusinessNumberInputField.text = "1234567890"
        subOrderMerchantNameInputField.title = "subOrders[0].merchantName"
        subOrderMerchantNameInputField.text = "토스 상점"
        subOrderMerchantCountryInputField.title = "subOrders[0].merchantAddress.country"
        subOrderMerchantCountryInputField.text = "KR"
        subOrderMerchantPostalCodeInputField.title = "subOrders[0].merchantAddress.postalCode"
        subOrderMerchantPostalCodeInputField.text = "06133"
        subOrderMerchantAddressInputField.title = "subOrders[0].merchantAddress.address"
        subOrderMerchantAddressInputField.text = "서울특별시 강남구 테헤란로"
        subOrderMerchantDetailAddressInputField.title = "subOrders[0].merchantAddress.detailAddress"
        subOrderMerchantDetailAddressInputField.text = "10층"
        subOrderNameInputField.title = "subOrders[0].orderName"
        subOrderNameInputField.text = "하위 주문"
        
        amountInputField.textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        amountInputField.textField.keyboardType = .numberPad
        subOrderMerchantBusinessNumberInputField.textField.keyboardType = .numberPad
        subOrderMerchantPostalCodeInputField.textField.keyboardType = .numberPad
        
        widget.delegate = self
        widget.paymentMethodWidget?.widgetUIDelegate = self
        widget.agreementWidget?.agreementUIDelegate = self
        widget.paymentMethodWidget?.widgetStatusDelegate = self
        widget.agreementWidget?.widgetStatusDelegate = self
        
        NSLayoutConstraint.activate([
            빈화면.heightAnchor.constraint(equalToConstant: 200)
        ])
        빈화면.backgroundColor = .lightGray
    }
    
    @objc func requestPayment() {
        let selectedPaymentMethod = widget.paymentMethodWidget?.getSelectedPaymentMethod()
        Logger.debug("getSelectedPaymentMethod: \(selectedPaymentMethod)")
        widget.requestPayment(
            info: DefaultWidgetPaymentInfo(
                orderId: orderIdInputField.textField.text ?? UUID().uuidString,
                orderName: orderNameInputField.textField.text ?? "테스트 결제",
                appScheme: Environment.Constant.appScheme,
                subOrders: [makeSubOrder()]
            )
        )
    }

    private func makeSubOrder() -> SubOrder {
        SubOrder(
            merchantBusinessNumber: textValue(subOrderMerchantBusinessNumberInputField, default: "1234567890"),
            merchantName: textValue(subOrderMerchantNameInputField, default: "토스 상점"),
            merchantAddress: SubOrder.MerchantAddress(
                country: textValue(subOrderMerchantCountryInputField, default: "KR"),
                postalCode: textValue(subOrderMerchantPostalCodeInputField, default: "06133"),
                address: textValue(subOrderMerchantAddressInputField, default: "서울특별시 강남구 테헤란로"),
                detailAddress: optionalTextValue(subOrderMerchantDetailAddressInputField)
            ),
            orderName: textValue(subOrderNameInputField, default: "하위 주문")
        )
    }

    private func textValue(_ textField: TextField, default defaultValue: String) -> String {
        guard let text = textField.textField.text, !text.isEmpty else {
            return defaultValue
        }
        return text
    }

    private func optionalTextValue(_ textField: TextField) -> String? {
        guard let text = textField.textField.text, !text.isEmpty else {
            return nil
        }
        return text
    }
}

extension PaymentWidgetViewController {
    @objc func textFieldDidChanged(_ sender: Any) {
        if let amountString = (sender as? UITextField)?.text,
           let amount = Double(amountString) {
            widget.updateAmount(amount)
        }
    }
}

extension PaymentWidgetViewController: TossPaymentsDelegate {
    public func handleSuccessResult(_ success: TossPaymentsResult.Success) {
        let viewModel = ResultViewModel(
            result1: ("paymentKey", success.paymentKey),
            result2: ("orderId", success.orderId),
            result3: ("amount", "\(success.amount)")
        )
        
        let additionalParameters = success.additionalParameters
        
        let paymentType = additionalParameters?["paymentType"] as? String
            
        if paymentType == "BRANDPAY" {
            // 브랜드페이 승인
        } else {
            // 일반결제 승인 -> 추후 일반결제/브랜드페이 승인으로 Migration 예정되어있음
        }
        let viewController = ResultViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    public func handleFailResult(_ fail: TossPaymentsResult.Fail) {
        let viewModel = ResultViewModel(
            result1: ("errorCode", fail.errorCode),
            result2: ("errorMessage", fail.errorMessage),
            result3: ("orderId", fail.orderId ?? "unknown")
        )
        let viewController = ResultViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension PaymentWidgetViewController: TossPaymentsWidgetUIDelegate {
    public func didReceivedCustomRequest(_ widget: PaymentMethodWidget, paymentMethodKey: String) {
        Logger.debug("PaymentMethodWidget didReceivedCustomRequest \(paymentMethodKey)")
    }
    
    public func didReceivedCustomPaymentMethodSelected(_ widget: PaymentMethodWidget, paymentMethodKey: String) {
        Logger.debug("PaymentMethodWidget didReceivedCustomPaymentMethodSelected \(paymentMethodKey)")
    }
    
    public func didReceivedCustomPaymentMethodUnselected(_ widget: PaymentMethodWidget, paymentMethodKey: String) {
        Logger.debug("PaymentMethodWidget didReceivedCustomPaymentMethodUnselected \(paymentMethodKey)")
    }
    
    public func didUpdateHeight(_ widget: PaymentMethodWidget, height: CGFloat) {
        Logger.debug("PaymentMethodWidget didUpdateHeight \(height)")
    }
}

extension PaymentWidgetViewController: TossPaymentsAgreementUIDelegate {
    public func didUpdateHeight(_ widget: AgreementWidget, height: CGFloat) {
        Logger.debug("AgreementWidget didUpdateHeight \(height)")
    }
    
    public func didUpdateAgreementStatus(_ widget: AgreementWidget, agreementStatus: AgreementStatus) {
        Logger.debug("AgreemenetWidget didUpdateAgreementStatus \(agreementStatus)")
        button.backgroundColor = agreementStatus.agreedRequiredTerms ? .systemBlue : .systemRed
        button.isEnabled = agreementStatus.agreedRequiredTerms
    }
}

extension PaymentWidgetViewController: TossPaymentsWidgetStatusDelegate {
    public func didReceivedLoad(_ name: String) {
        Logger.debug("didReceivedLoad \(name)")
    }
    
    public func didReceiveFail(_ name: String, fail: TossPaymentsResult.Fail) {
        Logger.debug("didReceiveFail \(name), \(fail)")
    }
}

#endif
