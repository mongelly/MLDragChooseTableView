//
//  MLDragChooseTableViewComponentDelegate.h
//  MLDragChooseTableViewDemo
//
//  Created by MogLu on 03/08/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MLDragChooseTableViewComponentDelegate <NSObject>

-(void)tableViewCellDidDragOfRowAtIndexPath:(NSIndexPath*) indexPath;

-(void)tableViewCellDidEndDraggingWithSourceIndexPath:(NSIndexPath*) sourceIndexPath toDestinationIndexPath:(NSIndexPath*) destinationIndexPath;

-(void)tableViewCellDidCancelDragging;

@end
