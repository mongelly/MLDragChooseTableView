//
//  MLDragChooseTableViewComponent.m
//  MLDragChooseTableViewDemo
//
//  Created by MogLu on 02/08/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import "MLDragChooseTableViewComponent.h"
#import "MLDraggingFakeView.h"

@implementation MLDragChooseTableViewComponent
{
@private __weak UITableView *_weakTableView;
@private MLDraggingFakeView *_fakeView;
@private UITableViewCell *_chooseCell;
@private BOOL _tableViewNeedMove;
@private NSIndexPath *_sourceIndex;
}

-(instancetype)initWithHostTableView:(UITableView*) tableview
{
    if(self = [super init])
    {
        _weakTableView = tableview;
        _dragCellColor = UIColor.blueColor.CGColor;
        _chooseCellColor = UIColor.purpleColor.CGColor;
    }
    return self;
}

-(void)addDragGestureToCell:(UITableViewCell*) cell
{
    [cell addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellDragingGestureHandle:)]];
}

-(void)cellDragingGestureHandle:(UILongPressGestureRecognizer*) draggingGesture
{
    if(_weakTableView.editing || _weakTableView == nil)
    {
        return;
    }
    if(draggingGesture.view != nil && [draggingGesture.view isKindOfClass:UITableViewCell.class])
    {
        UITableViewCell *dragCell = (UITableViewCell*)draggingGesture.view;
        if(_fakeView == nil)
        {
            _fakeView = [[MLDraggingFakeView alloc] initWithCell:dragCell];
        }
        if(dragCell.editingStyle == UITableViewCellEditingStyleNone)
        {
            switch (draggingGesture.state)
            {
                case UIGestureRecognizerStateBegan:
                {
                    _tableViewNeedMove = NO;
                    _fakeView.alpha = 0.8;
                    [_fakeView setChooseStyle:YES setColor:_dragCellColor];
                    _fakeView.position = CGPointMake(0, [draggingGesture locationInView:_weakTableView].y - _fakeView.frame.size.height/2);
                    _sourceIndex = [_weakTableView indexPathForCell:dragCell];
                    dragCell.hidden = YES;
                    [_weakTableView addSubview:_fakeView];
                    if(_delegate != nil && [_delegate respondsToSelector:@selector(tableViewCellDidDragOfRowAtIndexPath:)])
                    {
                        [_delegate tableViewCellDidDragOfRowAtIndexPath:_sourceIndex];
                    }
                    break;
                }
                case UIGestureRecognizerStateChanged:
                {
                    CGFloat judgingY = [draggingGesture locationInView:_weakTableView].y - _weakTableView.contentOffset.y;
                    [self handleCellSelectStyle];
                    if(judgingY <= dragCell.frame.size.height/2)
                    {
                        _tableViewNeedMove = YES;
                        [self tableViewScrollUp];
                    }
                    else if(judgingY >= (_weakTableView.frame.size.height - dragCell.frame.size.height/2))
                    {
                        _tableViewNeedMove = YES;
                        [self tableViewScrollDown];
                    }
                    else
                    {
                        _fakeView.position = CGPointMake(0,[draggingGesture locationInView:_weakTableView].y - (_fakeView.frame.size.height/2));
                        [self handleCellSelectStyle];
                        _tableViewNeedMove = NO;
                    }
                    break;

                }
                case UIGestureRecognizerStateEnded:
                {
                    if(_fakeView != nil)
                    {
                        _fakeView.alpha = 1.0;
                        [_fakeView setChooseStyle:NO setColor:UIColor.clearColor.CGColor];
                        [_fakeView removeFromSuperview];
                        _fakeView = nil;
                    }
                    if(_chooseCell != nil)
                    {
                        [self chooseCellStyleHandle:NO];
                        if(_delegate != nil && [_delegate respondsToSelector:@selector(tableViewCellDidEndDraggingWithSourceIndexPath:toDestinationIndexPath:)])
                        {
                            [_delegate tableViewCellDidEndDraggingWithSourceIndexPath:_sourceIndex toDestinationIndexPath:[_weakTableView indexPathForCell:_chooseCell]];
                        }
                    }
                    else
                    {
                        if(_delegate != nil && [_delegate respondsToSelector:@selector(tableViewCellDidCancelDragging)])
                        {
                            [_delegate tableViewCellDidCancelDragging];
                        }
                    }
                    _tableViewNeedMove = NO;
                    _sourceIndex = nil;
                    dragCell.hidden = NO;
                    break;
                }
                default:
                {
                    if(_fakeView != nil)
                    {
                        _fakeView.alpha = 1.0;
                        [_fakeView setChooseStyle:NO setColor:UIColor.clearColor.CGColor];
                        [_fakeView removeFromSuperview];
                        _fakeView = nil;
                    }
                    if(_chooseCell != nil)
                    {
                        [self chooseCellStyleHandle:NO];
                    }
                    if(_delegate != nil && [_delegate respondsToSelector:@selector(tableViewCellDidCancelDragging)])
                    {
                        [_delegate tableViewCellDidCancelDragging];
                    }
                    _tableViewNeedMove = NO;
                    _sourceIndex = nil;
                    dragCell.hidden = NO;
                    break;
                }
            }
        }
    }
}


-(void)handleCellSelectStyle
{
    NSIndexPath *targetIndexPath = [_weakTableView indexPathForRowAtPoint:_fakeView.center];
    if(targetIndexPath != nil && _sourceIndex != nil && _sourceIndex.row != targetIndexPath.row)
    {
        UITableViewCell *tempCell = [_weakTableView cellForRowAtIndexPath:targetIndexPath];
        if(tempCell != nil)
        {
            if(_chooseCell != nil && _chooseCell != tempCell)
            {
                [self chooseCellStyleHandle:NO];
            }
            _chooseCell = tempCell;
            [self chooseCellStyleHandle:YES];
            _fakeView.makeItScale = YES;
        }
        else
        {
            if( _chooseCell != nil)
            {
                [self chooseCellStyleHandle:NO];
                _chooseCell = nil;
            }
            _fakeView.makeItScale = NO;
        }
    }
    else
    {
        if( _chooseCell != nil)
        {
            [self chooseCellStyleHandle:NO];
            _chooseCell = nil;
        }
        _fakeView.makeItScale = NO;
    }
}

-(void)chooseCellStyleHandle:(BOOL)highlighted
{
    if(highlighted)
    {
        _chooseCell.layer.borderWidth = 2.5;
        _chooseCell.layer.borderColor = _chooseCellColor;
    }
    else
    {
        _chooseCell.layer.borderColor = UIColor.clearColor.CGColor;
    }
}

-(void)tableViewScrollUp
{
    if(_weakTableView.contentOffset.y>0)
    {
        CGFloat moveOffsetY = _weakTableView.contentOffset.y - 1;
        if(moveOffsetY>0)
        {
            [UIView animateWithDuration:0.1 animations:^{
                _weakTableView.contentOffset = CGPointMake(_weakTableView.contentOffset.x, moveOffsetY);
                _fakeView.position = CGPointMake(0,_fakeView.position.y - 1);
                [self handleCellSelectStyle];
            } completion:^(BOOL finished)
             {
                 if(_tableViewNeedMove)
                 {
                     [self tableViewScrollUp];
                 }
             }];
        }
    }
}

-(void)tableViewScrollDown
{
    if(_weakTableView.contentOffset.y < (_weakTableView.contentSize.height - _weakTableView.frame.size.height))
    {
        CGFloat moveOffsetY = _weakTableView.contentOffset.y + 1;
        if(moveOffsetY<(_weakTableView.contentSize.height - _weakTableView.frame.size.height))
        {
            [UIView animateWithDuration:0.1 animations:^{
                _weakTableView.contentOffset = CGPointMake(_weakTableView.contentOffset.x, moveOffsetY);
                _fakeView.position = CGPointMake(0,_fakeView.position.y + 1);
                [self handleCellSelectStyle];
            } completion:^(BOOL finished)
             {
                 if(_tableViewNeedMove)
                 {
                     [self tableViewScrollDown];
                 }
             }];
        }
    }
}

@end
