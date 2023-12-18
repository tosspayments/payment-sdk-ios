//
//  ViewController.h
//  UIKit-Objc-Example
//
//  Created by 김진규 on 2023/12/14.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property UIScrollView *scrollView;
@property UIStackView *stackView;
@property NSLayoutConstraint *scrollViewBottomAnchorConstraint;

@end

