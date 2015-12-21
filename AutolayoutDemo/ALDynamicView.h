//
//  ALDynamicView.h
//  AutolayoutDemo
//
//  Created by Calios on 12/19/15.
//  Copyright © 2015 Calios. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  As I'm still puzzled by this problem(http://stackoverflow.com/questions/34369427/can-i-set-the-property-for-a-class-which-hasnt-been-specified-until-run-in-oc), you can't directly set `lineAdded` from controller.
 *  While you can use `e self.lineAdded = YES` in console to change the value.(1219)
 */
@interface ALDynamicView : UIView

/**
 *  lineAdded property indicates whether dynamicLabel2 shows or not.
 */
@property (nonatomic, assign) BOOL lineAdded;

@end
