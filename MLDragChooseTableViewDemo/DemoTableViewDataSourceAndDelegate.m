//
//  DemoTableViewDataSourceAndDelegate.m
//  MLDragChooseTableViewCellDemo
//
//  Created by MogLu on 03/08/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import "DemoTableViewDataSourceAndDelegate.h"
#import "MLDragChooseTableViewComponent.h"
#import "DemoTableViewCell.h"

@implementation DemoTableViewDataSourceAndDelegate
{
@private MLDragChooseTableViewComponent *_component;
}

NSString *cellIdentifier = @"DemoTableViewCell";

#pragma mark -
#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark -
#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_component == nil)
    {
        _component = [[MLDragChooseTableViewComponent alloc] initWithHostTableView:tableView];
        _component.chooseCellColor = UIColor.redColor.CGColor;
        _component.dragCellColor = UIColor.yellowColor.CGColor;
        _component.delegate = self;
    }
    
    DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[DemoTableViewCell alloc] initWithStyle:(UITableViewCellStyle)UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [_component addDragGestureToCell:cell];
    }
    cell.titleLabelText = [NSString stringWithFormat:@"Cell Index of %li",(long)indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableViewCellDidDragOfRowAtIndexPath:(NSIndexPath*) indexPath
{
    NSLog(@"tableViewCellDidDragOfRowAtIndexPath:%li",indexPath.row);
}

-(void)tableViewCellDidEndDraggingWithSourceIndexPath:(NSIndexPath*) sourceIndexPath toDestinationIndexPath:(NSIndexPath*) destinationIndexPath
{
    NSLog(@"sourceIndexPath:%li ----> destinationIndexPath:%li",sourceIndexPath.row,destinationIndexPath.row);
}

-(void)tableViewCellDidCancelDragging
{
    NSLog(@"tableViewCellDidCancelDragging");
}

@end
