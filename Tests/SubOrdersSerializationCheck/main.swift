import Foundation

let subOrders = [
    SubOrder(
        merchantBusinessNumber: "1234567890",
        merchantName: "Toss Store",
        merchantAddress: SubOrder.MerchantAddress(
            country: "KR",
            postalCode: "06133",
            address: "서울특별시 강남구 테헤란로",
            detailAddress: "10층"
        ),
        orderName: "하위 주문 A"
    ),
    SubOrder(
        merchantBusinessNumber: "0987654321",
        merchantName: "Toss Branch",
        merchantAddress: SubOrder.MerchantAddress(
            country: "KR",
            postalCode: "06236",
            address: "서울특별시 강남구 강남대로",
            detailAddress: nil
        ),
        orderName: "하위 주문 B"
    )
]

let paymentInfo = DefaultPaymentInfo(
    amount: 1000,
    orderId: "order-id",
    orderName: "대표 주문",
    subOrders: subOrders
)

guard let paymentSubOrders = paymentInfo.requestJSONObject?["subOrders"] as? [[String: Any]] else {
    fatalError("PaymentInfo request JSON must include subOrders")
}

assert(paymentSubOrders.count == 2)
assert(paymentSubOrders[0]["merchantBusinessNumber"] as? String == "1234567890")
assert(paymentSubOrders[0]["merchantName"] as? String == "Toss Store")
assert(paymentSubOrders[0]["orderName"] as? String == "하위 주문 A")

guard let firstAddress = paymentSubOrders[0]["merchantAddress"] as? [String: Any] else {
    fatalError("PaymentInfo subOrders must include merchantAddress")
}

assert(firstAddress["country"] as? String == "KR")
assert(firstAddress["postalCode"] as? String == "06133")
assert(firstAddress["address"] as? String == "서울특별시 강남구 테헤란로")
assert(firstAddress["detailAddress"] as? String == "10층")

guard let secondAddress = paymentSubOrders[1]["merchantAddress"] as? [String: Any] else {
    fatalError("PaymentInfo subOrders must include merchantAddress")
}

assert(secondAddress["detailAddress"] == nil)

let orderedInfo = paymentInfo.orderedInfo

guard orderedInfo.contains("subOrders: [") else {
    fatalError("PaymentInfo orderedInfo must display subOrders as an object array")
}

assert(orderedInfo.contains("  {\n    merchantBusinessNumber: 1234567890"))
assert(orderedInfo.contains("    merchantName: Toss Store"))
assert(orderedInfo.contains("    merchantAddress: {"))
assert(orderedInfo.contains("      country: KR"))
assert(orderedInfo.contains("      postalCode: 06133"))
assert(orderedInfo.contains("      address: 서울특별시 강남구 테헤란로"))
assert(orderedInfo.contains("      detailAddress: 10층"))
assert(orderedInfo.contains("    orderName: 하위 주문 A\n  }"))
assert(orderedInfo.contains("]"))

let widgetPaymentInfo = DefaultWidgetPaymentInfo(
    orderId: "widget-order-id",
    orderName: "위젯 대표 주문",
    subOrders: subOrders
)

guard let widgetSubOrders = widgetPaymentInfo.convertToPaymentInfo(amount: 2000)?["subOrders"] as? [[String: Any]] else {
    fatalError("WidgetPaymentInfo request JSON must include subOrders")
}

assert(widgetSubOrders.count == 2)
assert(widgetSubOrders[1]["merchantBusinessNumber"] as? String == "0987654321")
assert(widgetSubOrders[1]["merchantName"] as? String == "Toss Branch")
assert(widgetSubOrders[1]["orderName"] as? String == "하위 주문 B")

print("SubOrders serialization check passed")
