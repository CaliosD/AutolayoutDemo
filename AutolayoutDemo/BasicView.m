//
//  BasicView.m
//  AutolayoutDemo
//
//  Created by Calios on 5/22/15.
//  Copyright (c) 2015 Calios. All rights reserved.
//

#import "BasicView.h"

@interface BasicView ()

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *createLabel;
@property (nonatomic, retain) UILabel *contentLabel;

@end

@implementation BasicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _nameLabel = [[UILabel alloc] init];
        _createLabel = [[UILabel alloc]init];
    }
    [self setupSubviews];
    
    [self setupLayout];
    return self;
}

- (void)layoutSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    // Calios: it is important to be aware that it is also possible to remove constraints from a view. For example, when rotating the device. (0521)
    //    if (self.constraints.count > 0) {
    //        [self removeConstraints:self.constraints];
    //    }
    
    // Calios: this method will be called each time when subviews' frame changes. While the constraints only need to be added once.(0521)
    
//    NSLog(@"=====> constraints: %@",self.constraints);
}

- (void)setupSubviews
{
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _nameLabel.backgroundColor = [UIColor orangeColor];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.text = @"如果你也听说";
    
    [self addSubview:_nameLabel];
    
    _createLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _createLabel.backgroundColor = [UIColor blueColor];
    _createLabel.textColor = [UIColor whiteColor];
    _createLabel.text = @"创建人：阿妹";
    
    [self addSubview:_createLabel];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _contentLabel.backgroundColor = [UIColor redColor];
    _contentLabel.textColor = [UIColor whiteColor];
    _contentLabel.text = @"如果你也听说，会不会想起我";
    
    [self addSubview:_contentLabel];
}

- (void)setupLayout
{
    NSDictionary *viewsDictionary = @{@"nameLabel":_nameLabel,
                                      @"createLabel":_createLabel,
                                      @"contentLabel":_contentLabel};
    NSDictionary *metrics = @{@"yInset":@40,
                              @"xInset":@20,
                              @"yPadding":@10,
                              @"font":@20};
    
    NSArray *name_constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-yInset-[nameLabel(font)]"
                                                                         options:0
                                                                         metrics:metrics
                                                                           views:viewsDictionary];
    
    NSArray *name_constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-xInset-[nameLabel]-xInset-|"
                                                                         options:0
                                                                         metrics:metrics
                                                                           views:viewsDictionary];
    
    [self addConstraints:name_constraint_H];
    [self addConstraints:name_constraint_V];
    
    // Calios: view1.attr1 = view2.attr2 * multiplier + constant
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_nameLabel
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_createLabel
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.f
                                                      constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_nameLabel
                                                     attribute:NSLayoutAttributeLeftMargin
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_createLabel
                                                     attribute:NSLayoutAttributeLeftMargin
                                                    multiplier:1.f
                                                      constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_nameLabel
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_createLabel
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.f
                                                      constant:-10.f]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_nameLabel
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_contentLabel
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.f
                                                      constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_nameLabel
                                                     attribute:NSLayoutAttributeLeftMargin
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_contentLabel
                                                     attribute:NSLayoutAttributeLeftMargin
                                                    multiplier:1.f
                                                      constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_createLabel
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_contentLabel
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.f
                                                      constant:-10.f]];
}
@end