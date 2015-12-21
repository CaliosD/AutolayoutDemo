//
//  ViewController.m
//  AutolayoutDemo
//
//  Created by Calios on 5/20/15.
//  Copyright (c) 2015 Calios. All rights reserved.
//


#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, retain) DetailView *detailView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view, typically from a nib.
    _detailView = [[DetailView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.view.autoresizesSubviews = YES;   // Not work.
    _detailView.autoresizingMask = self.view.autoresizingMask;  // Works.
//    self.view.autoresizingMask = YES;   // Not work.
//    [_detailView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];     // Work.
    [self.view addSubview: _detailView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end