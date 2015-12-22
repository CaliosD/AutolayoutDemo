
//
//  ALListViewController.m
//  AutolayoutDemo
//
//  Created by Calios on 5/22/15.
//  Copyright (c) 2015 Calios. All rights reserved.
//

#import "ALListViewController.h"
#import "ALDetailViewController.h"
#import "BasicView.h"
#import "AL&SiblingElem.h"
#import "AL&UIScrollView.h"
#import "AL&UITableView.h"
#import "AL&UITableView&iOS8.h"
#import "ALDynamicView.h"

static NSString *cellIdentifier = @"ALListViewControllerCell";

@interface ALListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *vcArray;

@end

@implementation ALListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"What can AL bring you?";
    _vcArray = @[[[ALDetailViewController alloc]initWithTitle:@"BasicView"
                                                    viewClass:[BasicView class]],
                 [[ALDetailViewController alloc]initWithTitle:@"AL&SiblingElem"
                                                    viewClass:[AL_SiblingElem class]],
                 [[ALDetailViewController alloc]initWithTitle:@"AL&UIScrollView"
                                                    viewClass:[AL_UIScrollView class]],
                 [[ALDetailViewController alloc]initWithTitle:@"AL&UITableView"
                                                    viewClass:[AL_UITableView class]],
                 [[ALDetailViewController alloc]initWithTitle:@"AL&UITableView&iOS8"
                                                    viewClass:[AL_UITableView_iOS8 class]],
                 [[ALDetailViewController alloc]initWithTitle:@"ALDynamicView"
                                                    viewClass:[ALDynamicView class]]];
    
    _tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:_tableView];
    
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics: 0 views:NSDictionaryOfVariableBindings(_tableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics: 0 views:NSDictionaryOfVariableBindings(_tableView)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _vcArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController = [_vcArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = viewController.title;
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ALDetailViewController *viewController = [_vcArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
