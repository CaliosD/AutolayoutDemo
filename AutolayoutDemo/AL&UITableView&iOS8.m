//
//  AL&UITableView&iOS8.m
//  AutolayoutDemo
//
//  Created by Calios on 12/22/15.
//  Copyright © 2015 Calios. All rights reserved.
//

#import "AL&UITableView&iOS8.h"
#import "AL&UITableViewCell&iOS8.h"

#define AL_UITableViewCelliOS8Identifier  @"AL_UITableViewCell_iOS8"

@interface AL_UITableView_iOS8 ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, retain) UITableView *tableView;
@property(nonatomic, retain) NSArray *dataArray;
@property(nonatomic, retain) NSArray *detailArray;

@end

@implementation AL_UITableView_iOS8

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 100;
        [_tableView registerClass:[AL_UITableViewCell_iOS8 class] forCellReuseIdentifier:AL_UITableViewCelliOS8Identifier];
        
        // Setting the estimated row height prevents the table view from calling tableView:heightForRowAtIndexPath: for every row in the table on first load;
        // it will only be called as cells are about to scroll onscreen. This is a major performance optimization.
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
    AL_UITableViewCell_iOS8 *cell = [tableView dequeueReusableCellWithIdentifier:AL_UITableViewCelliOS8Identifier];
    
    cell.bounds = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 99999);
    cell.contentView.bounds = cell.bounds;
    [cell layoutIfNeeded];
    cell.nameLabel.preferredMaxLayoutWidth = CGRectGetWidth(cell.nameLabel.frame) - 24;
    cell.descLabel.preferredMaxLayoutWidth = CGRectGetWidth(cell.descLabel.frame) - 24;

    [cell configureCellWithName:[_dataArray objectAtIndex:indexPath.row] desc:[_detailArray objectAtIndex:indexPath.row]];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

@end
