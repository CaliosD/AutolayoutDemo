//
//  AL&UIScrollView.m
//  AutolayoutDemo
//
//  Created by Calios on 5/25/15.
//  Copyright (c) 2015 Calios. All rights reserved.
//

#import "AL&UIScrollView.h"

@implementation AL_UIScrollView

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
    UIScrollView *sv=[UIScrollView new];
    sv.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:sv];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[sv]|" options:0 metrics: 0 views:NSDictionaryOfVariableBindings(sv)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[sv]|" options:0 metrics: 0 views:NSDictionaryOfVariableBindings(sv)]];
    UIView *lastView=nil;
    int length=100;
    for (int i=0; i<length; i++) {
        UIButton *btn=[UIButton new];
//        btn.backgroundColor=[UIColor colorWithWhite:i*0.01 alpha:1];
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:[NSString stringWithFormat:@"button-%d",i] forState:UIControlStateNormal];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [sv addSubview:btn];
        [sv addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:0
                                                        constant:i*4+100]];
        [sv addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                       attribute:NSLayoutAttributeCenterX
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:sv
                                                       attribute:NSLayoutAttributeCenterX
                                                      multiplier:1
                                                        constant:0]];
        if (i==0) {
            [sv addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:sv
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1
                                                            constant:10]];
        }else{
            [sv addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:lastView
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1
                                                            constant:1]];
        }
        if (i==length-1) {//关键点。非常重要!设置contentsize的height,最大的一个设置width，否则会出错。
            [sv addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:sv
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1
                                                            constant:-10]];
        }
        lastView=btn;
    }
}

@end
