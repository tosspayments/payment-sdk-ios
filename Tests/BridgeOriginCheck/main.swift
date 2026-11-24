import Foundation

let tosspayments = BridgeOrigin(url: URL(string: "https://tosspayments.com")!)
let brandpay = BridgeOrigin(url: URL(string: "https://Shop.Example.com/brandpay/callback?x=1")!)
let brandpayWithPort = BridgeOrigin(url: URL(string: "https://shop.example.com:8443/callback")!)
let brandpayWithDefaultPort = BridgeOrigin(url: URL(string: "https://shop.example.com:443/callback")!)
let brandpayOverHTTP = BridgeOrigin(url: URL(string: "http://shop.example.com/callback")!)

func sender(_ scheme: String, _ host: String, _ port: Int = 0) -> BridgeOrigin {
    return BridgeOrigin(scheme: scheme, host: host, port: port)
}

func expect(_ allowed: BridgeOrigin, accepts isMainFrame: Bool, from origin: BridgeOrigin, _ expected: Bool, _ name: String) {
    guard allowed.allowsMessage(fromMainFrame: isMainFrame, origin: origin) == expected else {
        fatalError("\(name): expected \(expected ? "accept" : "reject")")
    }
}

expect(tosspayments, accepts: true, from: sender("https", "tosspayments.com"), true, "main frame on the default base URL")
expect(brandpay, accepts: true, from: sender("https", "shop.example.com"), true, "main frame on the brandpay redirect host")
expect(brandpay, accepts: true, from: sender("HTTPS", "SHOP.EXAMPLE.COM"), true, "scheme and host compare without case")
expect(brandpayWithPort, accepts: true, from: sender("https", "shop.example.com", 8443), true, "same explicit port")
expect(brandpayWithPort, accepts: true, from: sender("https", "shop.example.com"), false, "default port when the base URL has another port")
expect(tosspayments, accepts: true, from: sender("https", "tosspayments.com", 443), true, "explicit default port")
expect(tosspayments, accepts: true, from: sender("https", "tosspayments.com", 80), false, "port 80 is not the default port of https")
expect(brandpayWithDefaultPort, accepts: true, from: sender("https", "shop.example.com"), true, "explicit default port on the base URL")
expect(brandpayOverHTTP, accepts: true, from: sender("http", "shop.example.com"), true, "http base URL accepts its own origin")
expect(brandpayOverHTTP, accepts: true, from: sender("http", "shop.example.com", 80), true, "explicit default port on http")
expect(brandpayOverHTTP, accepts: true, from: sender("https", "shop.example.com"), false, "http base URL rejects https")

expect(tosspayments, accepts: false, from: sender("https", "tosspayments.com"), false, "iframe on the same origin")
expect(tosspayments, accepts: false, from: sender("https", "card.example.com"), false, "iframe on another origin")
expect(tosspayments, accepts: true, from: sender("https", "card.example.com"), false, "main frame after navigating to a card issuer")
expect(tosspayments, accepts: true, from: sender("http", "tosspayments.com"), false, "scheme mismatch")
expect(tosspayments, accepts: true, from: sender("https", "tosspayments.com.example.com"), false, "host with the base host as prefix")
expect(tosspayments, accepts: true, from: sender("https", "nottosspayments.com"), false, "host with the base host as suffix")
expect(tosspayments, accepts: true, from: sender("https", "sub.tosspayments.com"), false, "subdomain of the base host")
expect(tosspayments, accepts: true, from: sender("about", ""), false, "about:blank before the HTML loads")
expect(tosspayments, accepts: true, from: sender("", ""), false, "opaque origin")

let hostless = BridgeOrigin(url: URL(string: "about:blank")!)
expect(hostless, accepts: true, from: sender("about", ""), false, "base URL without a host accepts nothing")

let fileBase = BridgeOrigin(url: URL(string: "file:///var/containers/index.html")!)
expect(fileBase, accepts: true, from: sender("file", ""), false, "file base URL accepts nothing")

let dataBase = BridgeOrigin(url: URL(string: "data:text/html,hello")!)
expect(dataBase, accepts: true, from: sender("data", ""), false, "data base URL accepts nothing")

let customSchemeBase = BridgeOrigin(url: URL(string: "myapp://callback")!)
expect(customSchemeBase, accepts: true, from: sender("myapp", "callback"), false, "base URL that is neither https nor http accepts nothing")

let schemelessBase = BridgeOrigin(url: URL(string: "callback")!)
expect(schemelessBase, accepts: true, from: sender("", ""), false, "base URL without a scheme accepts nothing")

print("BridgeOrigin check passed")
