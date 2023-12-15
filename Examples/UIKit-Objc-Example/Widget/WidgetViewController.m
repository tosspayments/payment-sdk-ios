//
//  WidgetViewController.m
//  UIKit-Objc-Example
//
//  Created by 김진규 on 2023/12/14.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

#import "WidgetViewController.h"
#import "TossPayments/TossPayments-Swift.h"
#import "DefaultWidgetPaymentInfo.h"

@interface WidgetViewController ()

@property PaymentWidget *widget;
@property UIButton *button;

@end
@interface WidgetViewController (TossPaymentsDelegate) <TossPaymentsDelegate>
@end

@interface WidgetViewController (TossPaymentsWidgetUIDelegate) <TossPaymentsWidgetUIDelegate>
@end

@interface WidgetViewController (TossPaymentsAgreementUIDelegate) <TossPaymentsAgreementUIDelegate>
@end

@interface WidgetViewController (TossPaymentsWidgetStatusDelegate) <TossPaymentsWidgetStatusDelegate>
@end

@implementation WidgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BrandPay* brandPay = [[BrandPay alloc] initWithRedirectURL:@"https://tosspayments.com/redierct"];
    PaymentWidgetOptions* paymentWidgetOptions = [[PaymentWidgetOptions alloc] initWithBrandpay:brandPay];
    PaymentWidget* widget = [[PaymentWidget alloc] initWithClientKey:@"test_ck_5GePWvyJnrKdzdyY29b8gLzN97Eo" customerKey:@"TOSSPAYMENTS" options:paymentWidgetOptions];
    UIButton *button = [[UIButton alloc] init];
    
    Amount *amount = [[Amount alloc] initWithValue:1000 currency:@"KRW" country:@"KR"];
    PaymentMethodWidgetOptions *methodWidgetOptions = [[PaymentMethodWidgetOptions alloc] initWithVariantKey:@"DEFAULT"];
    PaymentMethodWidget* methodWidget = [widget renderPaymentMethodsWithAmount:amount options:methodWidgetOptions];
    AgreementWidget* agreementWidget = [widget renderAgreement];
    
    [self.stackView addArrangedSubview:methodWidget];
    [self.stackView addArrangedSubview:agreementWidget];
    [self.view addSubview:button];
    
    [button setTranslatesAutoresizingMaskIntoConstraints:false];
    
    [self.scrollViewBottomAnchorConstraint setActive:false];
    [NSLayoutConstraint activateConstraints:@[
        [button.heightAnchor constraintEqualToConstant:60],
        [button.topAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor],
        [button.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [button.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [button.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor]
    ]];
    
    [button setBackgroundColor:UIColor.systemBlueColor];
    [button setTitle:@"결제하기" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(requestPayment) forControlEvents:UIControlEventTouchUpInside];
    
    [widget setDelegate:self];
    [[widget paymentMethodWidget] setWidgetUIDelegate:self];
    [[widget paymentMethodWidget] setWidgetStatusDelegate:self];
    [[widget agreementWidget] setAgreementUIDelegate:self];
    [[widget agreementWidget] setWidgetStatusDelegate:self];
    
    self.widget = widget;
    self.button = button;
}

- (void)requestPayment {
    [self.widget requestPaymentWithInfo: [[DefaultWidgetPaymentInfo alloc] initWithOrderId:@"123" orderName:@"김토스" taxExemptionAmount:NULL appScheme:NULL customerName:NULL customerEmail:NULL taxFreeAmount:NULL cultureExpense:NULL customerMobilePhone:NULL showCustomerMobilePhone:NULL useEscrow:NULL escrowProducts:NULL mobileCarrier:NULL]];
}

@end

@implementation WidgetViewController (TossPaymentsDelegate)

- (void)handleFailResult:(Fail * _Nonnull)fail {
    NSLog(@"fail %@", fail);
}

- (void)handleSuccessResult:(Success * _Nonnull)success {
    NSLog(@"success %@", success);
}

@end

@implementation WidgetViewController (TossPaymentsWidgetUIDelegate)

- (void)didReceivedCustomPaymentMethodSelected:(PaymentMethodWidget * _Nonnull)widget paymentMethodKey:(NSString * _Nonnull)paymentMethodKey {
    
}

- (void)didReceivedCustomPaymentMethodUnselected:(PaymentMethodWidget * _Nonnull)widget paymentMethodKey:(NSString * _Nonnull)paymentMethodKey {
    
}

- (void)didReceivedCustomRequest:(PaymentMethodWidget * _Nonnull)widget paymentMethodKey:(NSString * _Nonnull)paymentMethodKey {
    
}

- (void)didUpdateMethodWidgetHeight:(PaymentMethodWidget * _Nonnull)widget height:(CGFloat)height { 
    
}

@end

@implementation WidgetViewController (TossPaymentsAgreementUIDelegate)

- (void)didUpdateAgreementStatus:(AgreementWidget * _Nonnull)widget agreementStatus:(AgreementStatus * _Nonnull)agreementStatus {
    
}

- (void)didUpdateAgreementWidgetWidgetHeight:(AgreementWidget * _Nonnull)widget height:(CGFloat)height { 
    
}

@end

@implementation WidgetViewController (TossPaymentsWidgetStatusDelegate)


- (void)didReceiveFail:(NSString * _Nonnull)name fail:(Fail * _Nonnull)fail {
    
}

- (void)didReceivedLoad:(NSString * _Nonnull)name {
    
}

@end
