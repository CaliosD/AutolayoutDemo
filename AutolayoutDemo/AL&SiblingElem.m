//
//  AL&SiblingElem.m
//  AutolayoutDemo
//
//  Created by Calios on 5/22/15.
//  Copyright (c) 2015 Calios. All rights reserved.
//

#import "AL&SiblingElem.h"

@implementation AL_SiblingElem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Calios: The initialization and addSubview should be here in the init function instead of layoutSubviews funciton.(0525)
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.backgroundColor=[UIColor whiteColor];
    // Attention: self.view并没有self.view.translatesAutoresizingMaskIntoConstraints = NO;
    // Calios: The first button is set as the 'base' one. Maybe there's a better method solving it.(0525)
    UIButton *first = [UIButton new];
    [first setTitle:@"[+] button-0" forState:UIControlStateNormal];
    [first setTitle:@"[-] button-0" forState:UIControlStateSelected];
    first.backgroundColor = [UIColor clearColor];
    [self addSubview:first];
    
    first.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[first]-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(first)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[first(30)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(first)]];
    id lastView=nil;
    for (int i = 1; i <= 10; i++) {
        UIButton *b = [UIButton new];
        [b setTitle:[NSString stringWithFormat:@"[+] button-%d",i] forState:UIControlStateNormal];
        [b setTitle:[NSString stringWithFormat:@"[-] button-%d",i] forState:UIControlStateSelected];
        b.backgroundColor = [UIColor orangeColor];
        b.tag = i;
        [b addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:b];
        
        b.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:b
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:(i == 1 ? first : lastView)
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.f
                                                          constant:20.f]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:b
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:first
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1.f
                                                          constant:0.f]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:b
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:first
                                                         attribute:NSLayoutAttributeTrailing
                                                        multiplier:1.f
                                                          constant:0.f]];
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:b
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:0
                                                                             constant:43];
        heightConstraint.identifier = @"myHeight";
        [b addConstraint:heightConstraint];
        
        lastView = b;
    }
}

- (void)buttonPressed:(id)sender
{
    UIButton *btn=sender;
    for (NSLayoutConstraint *c in btn.constraints) {
        if ([c.identifier isEqualToString:@"myHeight"]) {
            c.constant = (c.constant==100 ? 43 : 100);
            btn.selected = c.constant==100;
        }
    }
    __block UIButton *b = btn;
    [UIView animateWithDuration:.25 animations:^{
        [b layoutIfNeeded];
    }];

}

@end
