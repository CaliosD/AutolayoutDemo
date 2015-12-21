//
//  ALDetailViewController.m
//  AutolayoutDemo
//
//  Created by Calios on 5/22/15.
//  Copyright (c) 2015 Calios. All rights reserved.
//

#import "ALDetailViewController.h"

@interface ALDetailViewController ()

@property (nonatomic, retain) Class viewClass;

@end

@implementation ALDetailViewController

- (id)initWithTitle:(NSString *)title viewClass:(Class)viewClass
{
    self = [super init];
    if (self) {
        self.title = title;
        self.viewClass = viewClass;
    }
    return self;
}

- (void)loadView
{
    self.view =  _viewClass.new;
    if ([self.view respondsToSelector:@selector(setLineAdded:)]) {
        [self.view setValue:@YES forKey:@"lineAdded"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
}

#ifdef __IPHONE_7_0

- (UIRectEdge)edgesForExtendedLayout
{
    return UIRectEdgeNone;
}
#endif


@end
