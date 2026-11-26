import WebKit

extension WKUserContentController {
    func add(_ handler: WKScriptMessageHandler, name: String, allowedOrigin: URL) {
        add(OriginCheckedScriptHandler(handler, allowedOrigin: allowedOrigin), name: name)
    }
}

final class OriginCheckedScriptHandler: NSObject, WKScriptMessageHandler {
    private let handler: WKScriptMessageHandler
    private let allowedOrigin: BridgeOrigin

    init(_ handler: WKScriptMessageHandler, allowedOrigin: URL) {
        self.handler = handler
        self.allowedOrigin = BridgeOrigin(url: allowedOrigin)
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let securityOrigin = message.frameInfo.securityOrigin
        let sender = BridgeOrigin(scheme: securityOrigin.protocol, host: securityOrigin.host, port: securityOrigin.port)
        guard allowedOrigin.allowsMessage(fromMainFrame: message.frameInfo.isMainFrame, origin: sender) else { return }
        handler.userContentController(userContentController, didReceive: message)
    }
}
