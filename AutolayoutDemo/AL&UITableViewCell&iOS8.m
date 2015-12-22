//
//  AL&UITableViewCell&iOS8.m
//  AutolayoutDemo
//
//  Created by Calios on 12/22/15.
//  Copyright © 2015 Calios. All rights reserved.
//

#import "AL&UITableViewCell&iOS8.h"

#define kLabelHorizontalInsets      15.0f
#define kLabelVerticalInsets        10.0f

@interface AL_UITableViewCell_iOS8 ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation AL_UITableViewCell_iOS8

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [UILabel newAutoLayoutView];
        _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _nameLabel.numberOfLines = 0;
        _nameLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1f];
        _nameLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.nameLabel.frame) - 24;
        [self.contentView addSubview:_nameLabel];
        
        _descLabel = [UILabel newAutoLayoutView];
        _descLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descLabel.numberOfLines = 0;
        _descLabel.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.1f];
        _descLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.descLabel.frame) - 24;
        [self.contentView addSubview:_descLabel];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {

        [_nameLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(kLabelVerticalInsets, kLabelHorizontalInsets, 0, kLabelHorizontalInsets) excludingEdge:ALEdgeBottom];
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [_nameLabel autoSetContentHuggingPriorityForAxis:ALAxisVertical];
        }];
        // This is the constraint that connects the title and body labels. It is a "greater than or equal" inequality so that if the row height is
        // slightly larger than what is actually required to fit the cell's subviews, the extra space will go here. (This is the case on iOS 7
        // where the cell separator is only 0.5 points tall, but in the tableView:heightForRowAtIndexPath: method of the view controller, we add
        // a full 1.0 point in extra height to account for it, which results in 0.5 points extra space in the cell.)
        // See https://github.com/smileyborg/TableViewCellWithAutoLayout/issues/3 for more info.
        [_descLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_nameLabel withOffset:kLabelVerticalInsets];

        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [_descLabel autoSetContentHuggingPriorityForAxis:ALAxisVertical];
        }];
        [_descLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, kLabelHorizontalInsets, kLabelVerticalInsets, kLabelHorizontalInsets) excludingEdge:ALEdgeTop];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsUpdateConstraints];
}

- (void)configureCellWithName:(NSString *)name desc:(NSString *)desc
{
    _nameLabel.text = name;
    _descLabel.text = desc;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
@end
