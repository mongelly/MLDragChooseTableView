//
//  MLDraggingFakeView.m
//  MLDragChooseTableViewDemo
//
//  Created by MogLu on 02/08/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import "MLDraggingFakeView.h"

@implementation MLDraggingFakeView
{
@private CGPoint _position;
@private BOOL _makeItScale;
}

-(instancetype)initWithCell:(UITableViewCell*)cell
{
    if(self = [super init])
    {
        self.layer.masksToBounds = YES;
        UIGraphicsBeginImageContextWithOptions(cell.bounds.size, NO, 0);
        [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *cellFakeImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.frame = cell.bounds;
        self.image = cellFakeImage;
        _scaleRate = 0.9;
        _makeItScale = NO;
    }
    return self;
}

-(void)setPosition:(CGPoint)position
{
    CGPoint pt = position;
    if(_makeItScale)
    {
        pt.x = self.frame.size.width * (1-_scaleRate)/2;
    }
    self.frame = CGRectMake(pt.x, pt.y, self.frame.size.width, self.frame.size.height);
}

-(CGPoint)position
{
    return self.frame.origin;
}

-(void)setMakeItScale:(BOOL)makeItScale
{
    _makeItScale = makeItScale;
    CGAffineTransform scaleTransform = CGAffineTransformIdentity;
    if(_makeItScale)
    {
        scaleTransform = CGAffineTransformMakeScale(_scaleRate, _scaleRate);
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = scaleTransform;
    }];
}

-(BOOL)makeItScale
{
    return _makeItScale;
}

-(void)setChooseStyle:(BOOL)highlighted setColor:(CGColorRef) color
{
    if(highlighted)
    {
        self.layer.borderWidth = 2.5;
        self.layer.borderColor = color;
    }
    else
    {
        self.layer.borderColor = UIColor.clearColor.CGColor;
    }
}

@end
