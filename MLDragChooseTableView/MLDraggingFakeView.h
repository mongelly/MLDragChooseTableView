//
//  MLDraggingFakeView.h
//  MLDragChooseTableViewDemo
//
//  Created by MogLu on 02/08/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLDraggingFakeView : UIImageView

@property (nonatomic) CGPoint position;
@property (nonatomic) BOOL makeItScale;
@property (nonatomic) CGFloat scaleRate;

-(instancetype)initWithCell:(UITableViewCell*)cell;

-(void)setChooseStyle:(BOOL)highlighted setColor:(CGColorRef) color;

@end
