import UIKit

public class TossPayments {
    private let clientKey: String
    public var delegate: TossPaymentsDelegate?
    public init(
        clientKey: String
    ) {
        self.clientKey = clientKey
    }

    public func requestPayment(
        _ 결제수단: 결제수단,
        _ 결제정보: 결제정보,
        on rootViewController: UIViewController
    ) {
        let service = TossPaymentsService(
            clientKey: clientKey,
            결제수단: 결제수단,
            결제정보: 결제정보
        )
        let viewController = TossPaymentsViewController(service: service)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        service.successURLHandler = { url in
            viewController.dismiss(animated: true) {
                self.handleSuccessURL(url)
            }
        }
        service.failURLHandler = { url in
            viewController.dismiss(animated: true) {
                self.handleFailURL(url)
            }
        }
        
        rootViewController.present(navigationController, animated: true)
    }
}

private extension TossPayments {
    func handleSuccessURL(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        let paymentKey = components.query(for: "paymentKey")
        let orderId = components.query(for: "orderId")
        let amount = Int64(components.query(for: "amount")) ?? 0
        delegate?.didSucceedRequestPayments(paymentKey: paymentKey, orderId: orderId, amount: amount)
    }
    
    func handleFailURL(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        let errorCode = components.query(for: "code")
        let errorMessage = components.query(for: "message")
        let orderId = components.query(for: "orderId")
        delegate?.didFailRequestPayments(erroCode: errorCode, errorMessage: errorMessage, orderId: orderId)
    }
}
