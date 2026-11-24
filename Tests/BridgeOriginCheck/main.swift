import Foundation

let tosspayments = BridgeOrigin(url: URL(string: "https://tosspayments.com")!)
let brandpay = BridgeOrigin(url: URL(string: "https://Shop.Example.com/brandpay/callback?x=1")!)
let brandpayWithPort = BridgeOrigin(url: URL(string: "https://shop.example.com:8443/callback")!)
let brandpayWithDefaultPort = BridgeOrigin(url: URL(string: "https://shop.example.com:443/callback")!)
let brandpayOverHTTP = BridgeOrigin(url: URL(string: "http://shop.example.com/callback")!)

expect(tosspayments, mainFrame: true, from: sender("https", "tosspayments.com"), accepts: true, "main frame on the default base URL")
expect(brandpay, mainFrame: true, from: sender("https", "shop.example.com"), accepts: true, "main frame on the brandpay redirect host")
expect(brandpay, mainFrame: true, from: sender("HTTPS", "SHOP.EXAMPLE.COM"), accepts: true, "scheme and host compare without case")
expect(brandpayWithPort, mainFrame: true, from: sender("https", "shop.example.com", 8443), accepts: true, "same explicit port")
expect(brandpayWithPort, mainFrame: true, from: sender("https", "shop.example.com"), accepts: false, "default port when the base URL has another port")
expect(tosspayments, mainFrame: true, from: sender("https", "tosspayments.com", 443), accepts: true, "explicit default port")
expect(tosspayments, mainFrame: true, from: sender("https", "tosspayments.com", 80), accepts: false, "port 80 is not the default port of https")
expect(brandpayWithDefaultPort, mainFrame: true, from: sender("https", "shop.example.com"), accepts: true, "explicit default port on the base URL")
expect(brandpayOverHTTP, mainFrame: true, from: sender("http", "shop.example.com"), accepts: true, "http base URL accepts its own origin")
expect(brandpayOverHTTP, mainFrame: true, from: sender("http", "shop.example.com", 80), accepts: true, "explicit default port on http")
expect(brandpayOverHTTP, mainFrame: true, from: sender("https", "shop.example.com"), accepts: false, "http base URL rejects https")

expect(tosspayments, mainFrame: false, from: sender("https", "tosspayments.com"), accepts: false, "iframe on the same origin")
expect(tosspayments, mainFrame: false, from: sender("https", "card.example.com"), accepts: false, "iframe on another origin")
expect(tosspayments, mainFrame: true, from: sender("https", "card.example.com"), accepts: false, "main frame after navigating to a card issuer")
expect(tosspayments, mainFrame: true, from: sender("http", "tosspayments.com"), accepts: false, "scheme mismatch")
expect(tosspayments, mainFrame: true, from: sender("https", "tosspayments.com.example.com"), accepts: false, "host with the base host as prefix")
expect(tosspayments, mainFrame: true, from: sender("https", "nottosspayments.com"), accepts: false, "host with the base host as suffix")
expect(tosspayments, mainFrame: true, from: sender("https", "sub.tosspayments.com"), accepts: false, "subdomain of the base host")
expect(tosspayments, mainFrame: true, from: sender("about", ""), accepts: false, "about:blank before the HTML loads")
expect(tosspayments, mainFrame: true, from: sender("", ""), accepts: false, "opaque origin")

let hostless = BridgeOrigin(url: URL(string: "about:blank")!)
expect(hostless, mainFrame: true, from: sender("about", ""), accepts: false, "base URL without a host accepts nothing")

let fileBase = BridgeOrigin(url: URL(string: "file:///var/containers/index.html")!)
expect(fileBase, mainFrame: true, from: sender("file", ""), accepts: false, "file base URL accepts nothing")

let dataBase = BridgeOrigin(url: URL(string: "data:text/html,hello")!)
expect(dataBase, mainFrame: true, from: sender("data", ""), accepts: false, "data base URL accepts nothing")

let customSchemeBase = BridgeOrigin(url: URL(string: "myapp://callback")!)
expect(customSchemeBase, mainFrame: true, from: sender("myapp", "callback"), accepts: false, "base URL that is neither https nor http accepts nothing")

let schemelessBase = BridgeOrigin(url: URL(string: "callback")!)
expect(schemelessBase, mainFrame: true, from: sender("", ""), accepts: false, "base URL without a scheme accepts nothing")

print("BridgeOrigin check passed")

func sender(_ scheme: String, _ host: String, _ port: Int = 0) -> BridgeOrigin {
    return BridgeOrigin(scheme: scheme, host: host, port: port)
}

func expect(_ allowed: BridgeOrigin, mainFrame isMainFrame: Bool, from origin: BridgeOrigin, accepts expected: Bool, _ name: String) {
    guard allowed.allowsMessage(fromMainFrame: isMainFrame, origin: origin) == expected else {
        fatalError("\(name): expected \(expected ? "accept" : "reject")")
    }
}
