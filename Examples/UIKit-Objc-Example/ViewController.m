//
//  ViewController.m
//  UIKit-Objc-Example
//
//  Created by 김진규 on 2023/12/14.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

#import "ViewController.h"
#import "TossPayments/TossPayments-Swift.h"

@interface ViewController ()

@property PaymentWidget *widget;

@end
@interface ViewController (TossPaymentsDelegate) <TossPaymentsDelegate>
@end

@interface ViewController (TossPaymentsWidgetUIDelegate) <TossPaymentsWidgetUIDelegate>
@end

@interface ViewController (TossPaymentsAgreementUIDelegate) <TossPaymentsAgreementUIDelegate>
@end

@interface ViewController (TossPaymentsWidgetStatusDelegate) <TossPaymentsWidgetStatusDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BrandPay* brandPay = [[BrandPay alloc] initWithRedirectURL:@"https://tosspayments.com/redierct"];
    PaymentWidgetOptions* paymentWidgetOptions = [[PaymentWidgetOptions alloc] initWithBrandpay:brandPay];
    PaymentWidget* widget = [[PaymentWidget alloc] initWithClientKey:@"test_ck_5GePWvyJnrKdzdyY29b8gLzN97Eo" customerKey:@"TOSSPAYMENTS" options:paymentWidgetOptions];
    
    Amount *amount = [[Amount alloc] initWithValue:1000 currency:@"KRW" country:@"KR"];
    PaymentMethodWidgetOptions *methodWidgetOptions = [[PaymentMethodWidgetOptions alloc] initWithVariantKey:@"DEFAULT"];
    PaymentMethodWidget* methodWidget = [widget renderPaymentMethodsWithAmount:amount options:methodWidgetOptions];
    AgreementWidget* agreementWidget = [widget renderAgreement];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [scrollView setAlwaysBounceVertical:true];
    [scrollView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    
    UIStackView *stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    [stackView setSpacing:24];
    [stackView setAxis:UILayoutConstraintAxisVertical];
    
    [self.view addSubview:scrollView];
    [scrollView addSubview:stackView];
    [stackView addArrangedSubview:methodWidget];
    [stackView addArrangedSubview:agreementWidget];
    
    [scrollView setTranslatesAutoresizingMaskIntoConstraints:false];
    [stackView setTranslatesAutoresizingMaskIntoConstraints:false];
    
    [NSLayoutConstraint activateConstraints:@[
        [scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [scrollView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [scrollView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [scrollView.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor],
        [stackView.topAnchor constraintEqualToAnchor:scrollView.safeAreaLayoutGuide.topAnchor],
        [stackView.leadingAnchor constraintEqualToAnchor:scrollView.safeAreaLayoutGuide.leadingAnchor constant:24],
        [stackView.trailingAnchor constraintEqualToAnchor:scrollView.safeAreaLayoutGuide.trailingAnchor constant:-24],
        [stackView.widthAnchor constraintEqualToAnchor:scrollView.safeAreaLayoutGuide.widthAnchor constant:-48],
        [stackView.bottomAnchor constraintEqualToAnchor:scrollView.safeAreaLayoutGuide.bottomAnchor]
    ]];
    
    [widget setDelegate:self];
    [[widget paymentMethodWidget] setWidgetUIDelegate:self];
    [[widget paymentMethodWidget] setWidgetStatusDelegate:self];
    [[widget agreementWidget] setAgreementUIDelegate:self];
    [[widget agreementWidget] setWidgetStatusDelegate:self];
    
    self.widget = widget;
}

@end

@implementation ViewController (TossPaymentsDelegate)

- (void)handleFailResult:(Fail * _Nonnull)fail { 
    NSLog(@"fail %@", fail);
}

- (void)handleSuccessResult:(Success * _Nonnull)success { 
    NSLog(@"success %@", success);
}

@end

@implementation ViewController (TossPaymentsWidgetUIDelegate)

- (void)didReceivedCustomPaymentMethodSelected:(PaymentMethodWidget * _Nonnull)widget paymentMethodKey:(NSString * _Nonnull)paymentMethodKey { 
    
}

- (void)didReceivedCustomPaymentMethodUnselected:(PaymentMethodWidget * _Nonnull)widget paymentMethodKey:(NSString * _Nonnull)paymentMethodKey { 
    
}

- (void)didReceivedCustomRequest:(PaymentMethodWidget * _Nonnull)widget paymentMethodKey:(NSString * _Nonnull)paymentMethodKey { 
    
}

- (void)didUpdateHeight:(PaymentMethodWidget * _Nonnull)widget height:(CGFloat)height { 
    
}

@end

@implementation ViewController (TossPaymentsAgreementUIDelegate)

- (void)didUpdateAgreementStatus:(AgreementWidget * _Nonnull)widget agreementStatus:(AgreementStatus * _Nonnull)agreementStatus {
    
}

- (void)didUpdateAgreementWidgetHeight:(AgreementWidget * _Nonnull)agreementWidget height:(CGFloat)height { 
    
}

@end

@implementation ViewController (TossPaymentsWidgetStatusDelegate)


- (void)didReceiveFail:(NSString * _Nonnull)name fail:(Fail * _Nonnull)fail { 
    
}

- (void)didReceivedLoad:(NSString * _Nonnull)name { 
    
}

@end
