
//
//  DefaultWidgetPaymentInfo.h
//  UIKit-Objc-Example
//
//  Created by 김진규 on 2023/12/14.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TossPayments/TossPayments-Swift.h>

@interface DefaultWidgetPaymentInfo: NSObject <WidgetPaymentInfo>

@property (nonatomic, readonly, nonnull) NSString *orderId;
@property (nonatomic, readonly, nonnull) NSString *orderName;
@property (nonatomic, readonly, nullable) NSString *taxExemptionAmount;
@property (nonatomic, readonly, nullable) NSString *appScheme;
@property (nonatomic, readonly, nullable) NSString *customerName;
@property (nonatomic, readonly, nullable) NSString *customerEmail;
@property (nonatomic, readonly, nullable) NSNumber *taxFreeAmount;
@property (nonatomic, readonly) BOOL cultureExpense;
@property (nonatomic, readonly, nullable) NSString *customerMobilePhone;
@property (nonatomic, readonly, nullable) NSString *showCustomerMobilePhone;
@property (nonatomic, readonly, nullable) NSNumber *useEscrow;
@property (nonatomic, readonly, nullable) NSArray<NSString *> *escrowProducts;
@property (nonatomic, readonly, nullable) NSString *mobileCarrier;

- (instancetype _Nonnull)initWithOrderId:(nonnull NSString *)orderId
                      orderName:(nonnull NSString *)orderName
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
                 mobileCarrier:(nullable NSString *)mobileCarrier;
@end

