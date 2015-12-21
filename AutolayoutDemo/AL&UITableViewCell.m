//
//  AL&UITableViewCell.m
//  AutolayoutDemo
//
//  Created by Calios on 5/25/15.
//  Copyright (c) 2015 Calios. All rights reserved.
//

#import "AL&UITableViewCell.h"

#define kLabelHorizontalInsets      15.0f
#define kLabelVerticalInsets        10.0f

@interface AL_UITableViewCell ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation AL_UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [UILabel newAutoLayoutView];
        _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _nameLabel.numberOfLines = 0;
        _nameLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1f];
        [self.contentView addSubview:_nameLabel];
        
        _descLabel = [UILabel newAutoLayoutView];
        _descLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descLabel.numberOfLines = 0;
        _descLabel.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.1f];
        [self.contentView addSubview:_descLabel];
        
        [self updateFonts];
    }
    return self;
}

- (void)updateConstraints
{
    if (!_didSetupConstraints) {
        
//        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
//            [_nameLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
//        }];
        [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelHorizontalInsets];
        [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        
        // This is the constraint that connects the title and body labels. It is a "greater than or equal" inequality so that if the row height is
        // slightly larger than what is actually required to fit the cell's subviews, the extra space will go here. (This is the case on iOS 7
        // where the cell separator is only 0.5 points tall, but in the tableView:heightForRowAtIndexPath: method of the view controller, we add
        // a full 1.0 point in extra height to account for it, which results in 0.5 points extra space in the cell.)
        // See https://github.com/smileyborg/TableViewCellWithAutoLayout/issues/3 for more info.
        [_descLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_nameLabel withOffset:kLabelVerticalInsets relation:NSLayoutRelationEqual];
        
//        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
//            [_descLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
//        }];
        [_descLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLabelVerticalInsets];
        [_descLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        [_descLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelHorizontalInsets];
        
        _didSetupConstraints = YES;
        
        
        
        
        
        /* Calios: Auto Layout without PureLayout framework.(0526)
        // Notice that the constraints are added to the contentView property and not directly on self.
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-6-[_nameLabel]-6-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[_nameLabel]-6-[_descLabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel,_descLabel)]];

        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_nameLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_descLabel attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0.f]];
       [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_nameLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_descLabel attribute:NSLayoutAttributeWidth multiplier:1.f constant:0.f]];
//        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_descLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_nameLabel attribute:NSLayoutAttributeWidth multiplier:1.f constant:0.f]];
//        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_nameLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:600.f]];
        
        _didSetupConstraints = YES;
         */
    }
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    // Again, note that the setNeedsLayout and layoutIfNeeded methods are called on the contentView of the cell.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    _nameLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.nameLabel.frame);
    _descLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.descLabel.frame);
}

- (void)updateFonts
{
    self.nameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.descLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
}

@end
