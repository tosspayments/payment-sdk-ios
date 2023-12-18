//
//  BaseTextField.m
//  UIKit-Objc-Example
//
//  Created by 김진규 on 2023/12/18.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTextField.h"

@interface BaseTextField ()

@property NSString *title;
@property NSString *text;
@property UILabel *label;

@end

@implementation BaseTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _textField = [[UITextField alloc] init];
    _label = [[UILabel alloc] init];
    _title = @"";
    _text = @"";
    
    [_label setText:_text];
    [_textField setAdjustsFontSizeToFitWidth:YES];
    [_textField setBorderStyle:UITextBorderStyleRoundedRect];
    [_textField setClearButtonMode:UITextFieldViewModeAlways];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addSubview:_label];
    [self addSubview:_textField];
    [_label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
        [_label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [_label.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [_label.topAnchor constraintEqualToAnchor:self.topAnchor],
        [_textField.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [_textField.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [_textField.topAnchor constraintEqualToAnchor:_label.bottomAnchor constant:8],
        [_textField.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
    ]];
}

@end
