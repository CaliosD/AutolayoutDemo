//
//  ALDynamicView.m
//  AutolayoutDemo
//
//  Created by Calios on 12/19/15.
//  Copyright © 2015 Calios. All rights reserved.
//

#import "ALDynamicView.h"

@interface ALDynamicView ()

@property (nonatomic, strong) UILabel *dLabel1;
@property (nonatomic, strong) UILabel *dLabel2;
@property (nonatomic, strong) UILabel *fLabel1;
@property (nonatomic, strong) UILabel *fLabel2;
@property (nonatomic, strong) UILabel *fLabel3;
@property (nonatomic, strong) UILabel *dLabel3;

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation ALDynamicView

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
    UILabel *(^dynamicLabelCreate)(NSInteger) = ^(NSInteger index){
        UILabel *dLabel = [UILabel newAutoLayoutView];
        dLabel.numberOfLines = 0;
        dLabel.text = [NSString stringWithFormat:@"dynamicLabel %ld",(long)index];
        /* These identifiers show up in logs, allowing for easier layout debugging. */
        dLabel.accessibilityIdentifier = [NSString stringWithFormat:@"dynamicLabel %ld",(long)index];
        [self addSubview:dLabel];
        
        return dLabel;
    };
    
    UILabel *(^fixedLabelCreate)(NSInteger) = ^(NSInteger index){
        UILabel *fLabel = [UILabel newAutoLayoutView];
        fLabel.text = [NSString stringWithFormat:@"fixedLabel %ld",(long)index];
        /* These identifiers show up in logs, allowing for easier layout debugging. */
        fLabel.accessibilityIdentifier = [NSString stringWithFormat:@"fixedLabel %ld",(long)index];
        [self addSubview:fLabel];
        return fLabel;
    };
    
    _dLabel1 = dynamicLabelCreate(1);
    _dLabel1.text = @"dynamicLabel 1 dynamicLabel 1 dynamicLabel 1 dynamicLabel 1 dynamicLabel 1 dynamicLabel 1 dynamicLabel 1 dynamicLabel 1 dynamicLabel 1";
    _dLabel2 = dynamicLabelCreate(2);
    _dLabel2.backgroundColor = [UIColor orangeColor];
    _dLabel2.text = @"dynamicLabel 2 dynamicLabel dynamicLabel dynamicLabel dynamicLabel dynamicLabel dynamicLabel dynamicLabel dynamicLabel 2";
    _dLabel3 = dynamicLabelCreate(3);
    _dLabel3.text = @"dynamicLabel 3 dynamicLabel 3 dynamicLabel 3 dynamicLabel 3 dynamicLabel 3 dynamicLabel 3 dynamicLabel 3";
    _fLabel1 = fixedLabelCreate(1);
    _fLabel2 = fixedLabelCreate(2);
    _fLabel3 = fixedLabelCreate(3);
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        [_dLabel1 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 10, 0, 10) excludingEdge:ALEdgeBottom];
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [_dLabel1 autoSetContentHuggingPriorityForAxis:ALAxisVertical];
        }];
        
        [@[_fLabel1,_fLabel2] autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeTop withFixedSpacing:10];
        
        [_fLabel3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_fLabel1 withOffset:10];
        [_fLabel3 autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
        [_fLabel3 autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
        
        [_dLabel3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_fLabel3 withOffset:10];
        [_dLabel3 autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
        [_dLabel3 autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
        
        self.didSetupConstraints = YES;
    }
    
    if (self.lineAdded) {
        [_dLabel2 autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
        [_dLabel2 autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
        [_dLabel2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_dLabel1 withOffset:10];
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [_dLabel2 autoSetContentHuggingPriorityForAxis:ALAxisVertical];
        }];
        
        [_fLabel1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_dLabel2 withOffset:10];
        
    }
    else{
        [UIView autoSetPriority:UILayoutPriorityDefaultLow forConstraints:^{
            [_fLabel1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_dLabel1 withOffset:10];
        }];
    }
    
    [super updateConstraints];
}

- (void)setLineAdded:(BOOL)lineAdded
{
    self.lineAdded = lineAdded;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

@end
