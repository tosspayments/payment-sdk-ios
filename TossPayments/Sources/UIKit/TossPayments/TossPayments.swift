#if canImport(UIKit)

import UIKit

public class TossPayments: HandleURLResult {
    private let clientKey: String
    public var delegate: TossPaymentsDelegate?
    public init(
        clientKey: String
    ) {
        self.clientKey = clientKey
    }
    public func requestPayment(
        _ paymentMethod: PaymentMethod,
        _ paymentInfo: PaymentInfo,
        on rootViewController: UIViewController
    ) {
        let service = TossPaymentsService(
            clientKey: clientKey,
            paymentMethod: paymentMethod,
            paymentInfo: paymentInfo
        )
        let viewController = TossPaymentsViewController(service: service)
        let navigationController = UINavigationController(rootViewController: viewController)
        service.successURLHandler = { [weak viewController] url in
            viewController?.dismiss(animated: true) {
                self.handleSuccessURL(url)
            }
        }
        service.failURLHandler = { [weak viewController] url in
            viewController?.dismiss(animated: true) {
                self.handleFailURL(url)
            }
        }
        
        rootViewController.present(navigationController, animated: true)
    }
    
    public func requestCardPayment(
        _ paymentInfo: CardPaymentInfo,
        on rootViewController: UIViewController
    ) {
        requestPayment(.카드, paymentInfo, on: rootViewController)
    }
    
    public func requestTransferPayment(
        _ paymentInfo: TransferPaymentInfo,
        on rootViewController: UIViewController
    ) {
        requestPayment(.계좌이체, paymentInfo, on: rootViewController)
    }
    
    public func requestVirtualAccountPayment(
        _ paymentInfo: VirtualAccountPaymentInfo,
        on rootViewController: UIViewController
    ) {
        requestPayment(.가상계좌, paymentInfo, on: rootViewController)
    }

    public func requestMobilePhonePayment(
        _ paymentInfo: MobilePhonePaymentInfo,
        on rootViewController: UIViewController
    ) {
        requestPayment(.휴대폰, paymentInfo, on: rootViewController)
    }

    public func requestGiftCertificatePayment(
        _ giftCertificate: GiftCertificatePaymentMethod,
        _ paymentInfo: GiftCertificatePaymentInfo,
        on rootViewController: UIViewController
    ) {
        let paymentMethod = giftCertificate.paymentMethod
        requestPayment(paymentMethod, paymentInfo, on: rootViewController)
    }
}

#endif
