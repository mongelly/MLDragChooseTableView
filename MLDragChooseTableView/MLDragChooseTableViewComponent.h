//
//  MLDragChooseTableViewComponent.h
//  MLDragChooseTableViewDemo
//
//  Created by MogLu on 02/08/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLDragChooseTableViewComponentDelegate.h"

@interface MLDragChooseTableViewComponent : NSObject

-(instancetype)initWithHostTableView:(UITableView*) tableview;

@property (nonatomic) CGColorRef dragCellColor;
@property (nonatomic) CGColorRef chooseCellColor;
@property (nonatomic,weak) id<MLDragChooseTableViewComponentDelegate> delegate;

-(void)addDragGestureToCell:(UITableViewCell*) cell;



@end
