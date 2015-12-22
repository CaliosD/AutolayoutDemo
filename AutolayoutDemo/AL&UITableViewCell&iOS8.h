//
//  AL&UITableViewCell&iOS8.h
//  AutolayoutDemo
//
//  Created by Calios on 12/22/15.
//  Copyright © 2015 Calios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AL_UITableViewCell_iOS8 : UITableViewCell

@property(nonatomic, retain) UILabel *nameLabel;
@property(nonatomic, retain) UILabel *descLabel;

//- (void)updateFonts;
- (void)configureCellWithName:(NSString *)name desc:(NSString *)desc;

@end
