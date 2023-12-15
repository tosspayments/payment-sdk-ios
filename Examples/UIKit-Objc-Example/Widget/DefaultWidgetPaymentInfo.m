//
//  DefaultWidgetPaymentInfo.m
//  UIKit-Objc-Example
//
//  Created by 김진규 on 2023/12/15.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefaultWidgetPaymentInfo.h"

@interface DefaultWidgetPaymentInfo ()

@end

@implementation DefaultWidgetPaymentInfo

- (instancetype)initWithOrderId:(NSString *)orderId
                      orderName:(NSString *)orderName
             taxExemptionAmount:(nullable NSString *)taxExemptionAmount
                      appScheme:(nullable NSString *)appScheme
                   customerName:(nullable NSString *)customerName
                  customerEmail:(nullable NSString *)customerEmail
                  taxFreeAmount:(nullable NSNumber *)taxFreeAmount
                 cultureExpense:(BOOL)cultureExpense
            customerMobilePhone:(nullable NSString *)customerMobilePhone
        showCustomerMobilePhone:(nullable NSString *)showCustomerMobilePhone
                     useEscrow:(nullable NSNumber *)useEscrow
                escrowProducts:(nullable NSArray<NSString *> *)escrowProducts
                 mobileCarrier:(nullable NSString *)mobileCarrier {
    self = [super init];
    if (self) {
        _orderId = orderId;
        _orderName = orderName;
        _taxExemptionAmount = taxExemptionAmount;
        _appScheme = appScheme;
        _customerName = customerName;
        _customerEmail = customerEmail;
        _taxFreeAmount = taxFreeAmount;
        _cultureExpense = cultureExpense;
        _customerMobilePhone = customerMobilePhone;
        _showCustomerMobilePhone = showCustomerMobilePhone;
        _useEscrow = useEscrow;
        _escrowProducts = escrowProducts;
        _mobileCarrier = mobileCarrier;
    }
    return self;
}

@end
