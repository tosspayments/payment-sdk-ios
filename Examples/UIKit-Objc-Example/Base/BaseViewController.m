//
//  BaseViewController.h
//  UIKit-Objc-Example
//
//  Created by 김진규 on 2023/12/14.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [scrollView setAlwaysBounceVertical:true];
    [scrollView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    
    UIStackView *stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    [stackView setSpacing:24];
    [stackView setAxis:UILayoutConstraintAxisVertical];
    
    [self.view addSubview:scrollView];
    [scrollView addSubview:stackView];
    
    [scrollView setTranslatesAutoresizingMaskIntoConstraints:false];
    [stackView setTranslatesAutoresizingMaskIntoConstraints:false];
    
    NSLayoutConstraint *scrollViewBottomAnchorConstraint =         [scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor];
    
    [NSLayoutConstraint activateConstraints:@[
        [scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [scrollView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [scrollView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [scrollView.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor],
        scrollViewBottomAnchorConstraint,
        [stackView.topAnchor constraintEqualToAnchor:scrollView.safeAreaLayoutGuide.topAnchor],
        [stackView.leadingAnchor constraintEqualToAnchor:scrollView.safeAreaLayoutGuide.leadingAnchor constant:24],
        [stackView.trailingAnchor constraintEqualToAnchor:scrollView.safeAreaLayoutGuide.trailingAnchor constant:-24],
        [stackView.widthAnchor constraintEqualToAnchor:scrollView.safeAreaLayoutGuide.widthAnchor constant:-48],
        [stackView.bottomAnchor constraintEqualToAnchor:scrollView.safeAreaLayoutGuide.bottomAnchor]
    ]];
    
    self.scrollView = scrollView;
    self.stackView = stackView;
    self.scrollViewBottomAnchorConstraint = scrollViewBottomAnchorConstraint;
    
}


@end

