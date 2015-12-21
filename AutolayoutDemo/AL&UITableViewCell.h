//
//  AL&UITableViewCell.h
//  AutolayoutDemo
//
//  Created by Calios on 5/25/15.
//  Copyright (c) 2015 Calios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AL_UITableViewCell : UITableViewCell

@property(nonatomic, retain) UILabel *nameLabel;
@property(nonatomic, retain) UILabel *descLabel;

- (void)updateFonts;

@end
