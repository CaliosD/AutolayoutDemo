//
//  ALDynamicView.h
//  AutolayoutDemo
//
//  Created by Calios on 12/19/15.
//  Copyright © 2015 Calios. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  This is a dynamic view consists of many subviews. You can set one of the subviews show or not using a property named `lineAdded`.
 */
@interface ALDynamicView : UIView

/**
 *  lineAdded property indicates whether dynamicLabel2 shows or not.
 */
@property (nonatomic, assign) BOOL lineAdded;

@end
