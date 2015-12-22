//
//  AL&UITableView.m
//  AutolayoutDemo
//
//  Created by Calios on 5/25/15.
//  Copyright (c) 2015 Calios. All rights reserved.
//

#import "AL&UITableView.h"
#import "AL&UITableViewCell.h"

#define AL_UITableViewCellIdentifier  @"AL_UITableViewCell"

@interface AL_UITableView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, retain) UITableView *tableView;
@property(nonatomic, retain) NSArray *dataArray;
@property(nonatomic, retain) NSArray *detailArray;

@end

@implementation AL_UITableView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[AL_UITableViewCell class] forCellReuseIdentifier:AL_UITableViewCellIdentifier];
        
        // Setting the estimated row height prevents the table view from calling tableView:heightForRowAtIndexPath: for every row in the table on first load;
        // it will only be called as cells are about to scroll onscreen. This is a major performance optimization.
        _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
        [self addSubview:_tableView];
        
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics: 0 views:NSDictionaryOfVariableBindings(_tableView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics: 0 views:NSDictionaryOfVariableBindings(_tableView)]];
        
        
        _dataArray = @[@"A long text.",@"This is a long text.",@"This is a long text. This is a long text.",@"This is a long text.This is a long text.This is a long text.This is a long text.",@"This is a long text.This is a long text.This is a long text.This is a long text.This is a long text.This is a long text.This is a long text.This is a long text.",@"This is a long text.This is a long text.This is a long text.This is a long text.This is a long text.This is a long text.This is a long text.This is a long text.This is a long text.This is a long text."];
        _detailArray = @[@"The correct API to use is UIView systemLayoutSizeFittingSize:, passing either UILayoutFittingCompressedSize or UILayoutFittingExpandedSize.",@"The correct API to use is UIView systemLayoutSizeFittingSize:, passing either UILayoutFittingCompressedSize or UILayoutFittingExpandedSize.",@"The correct API to use is UIView systemLayoutSizeFittingSize:, passing either UILayoutFittingCompressedSize or UILayoutFittingExpandedSize.The correct API to use is UIView systemLayoutSizeFittingSize:, passing either UILayoutFittingCompressedSize or UILayoutFittingExpandedSize.",@"The correct API to use is UIView systemLayoutSizeFittingSize:, passing either UILayoutFittingCompressedSize or UILayoutFittingExpandedSize.The correct API to use is UIView systemLayoutSizeFittingSize:, passing either UILayoutFittingCompressedSize or UILayoutFittingExpandedSize.The correct API to use is UIView systemLayoutSizeFittingSize:, passing either UILayoutFittingCompressedSize or UILayoutFittingExpandedSize.",@"The correct API to use is UIView systemLayoutSizeFittingSize:, passing either UILayoutFittingCompressedSize or UILayoutFittingExpandedSize.The correct API to use is UIView systemLayoutSizeFittingSize:, passing either UILayoutFittingCompressedSize or UILayoutFittingExpandedSize.",@"The correct API to use is UIView systemLayoutSizeFittingSize:, passing either UILayoutFittingCompressedSize or UILayoutFittingExpandedSize."];

        // Used to fix iOS9 tableview margin.(1221)
//        if([self respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)]) {
//            self.cellLayoutMarginsFollowReadableWidth = NO;
//        }
    }
    return self;
}

#pragma mark UITableViewDataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AL_UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AL_UITableViewCellIdentifier];
    
    [cell updateFonts];
    cell.nameLabel.text = [_dataArray objectAtIndex:indexPath.row];
    cell.descLabel.text = [_detailArray objectAtIndex:indexPath.row];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    
    NSLog(@"===> \n content: %f,%f",cell.contentView.frame.size.width,cell.contentView.frame.size.height);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AL_UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AL_UITableViewCellIdentifier];
    if (!cell) {
        cell = [[AL_UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AL_UITableViewCellIdentifier];
    }
    
    [cell updateFonts];

    cell.nameLabel.text = [_dataArray objectAtIndex:indexPath.row];
    cell.descLabel.text = [_detailArray objectAtIndex:indexPath.row];
    
    [cell layoutSubviews];
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];

    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));

    [cell setNeedsLayout];
    [cell layoutIfNeeded];

    // Get the actual height required for the cell
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    
    NSLog(@"===> \n height content: %f,%f",cell.contentView.frame.size.width,cell.contentView.frame.size.height);
    return 1  + size.height;
}

@end
