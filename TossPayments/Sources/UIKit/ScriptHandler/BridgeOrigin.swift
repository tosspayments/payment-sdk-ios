import Foundation

struct BridgeOrigin: Equatable {
    let scheme: String
    let host: String
    let port: Int

    init(url: URL) {
        self.init(scheme: url.scheme ?? "", host: url.host ?? "", port: url.port ?? 0)
    }

    init(scheme: String, host: String, port: Int) {
        let scheme = scheme.lowercased()
        self.scheme = scheme
        self.host = host.lowercased()
        self.port = BridgeOrigin.normalizedPort(port, scheme: scheme)
    }

    func allowsMessage(fromMainFrame isMainFrame: Bool, origin: BridgeOrigin) -> Bool {
        return isMainFrame && !isOpaque && origin == self
    }

    var isOpaque: Bool {
        return host.isEmpty || (scheme != "https" && scheme != "http")
    }

    private static func normalizedPort(_ port: Int, scheme: String) -> Int {
        switch (scheme, port) {
        case ("https", 443), ("http", 80):
            return 0
        default:
            return port
        }
    }
}
