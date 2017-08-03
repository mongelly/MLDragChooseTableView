//
//  DemoTableViewCell.m
//  MLDragChooseTableViewDemo
//
//  Created by MogLu on 04/08/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import "DemoTableViewCell.h"

@implementation DemoTableViewCell
{
@private UIView *_bottomLine;
@private UILabel *_titleLabel;
}

-(void)layoutSubviews
{
    self.backgroundColor = UIColor.whiteColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.layer.borderWidth = 3;
    self.layer.borderColor = UIColor.clearColor.CGColor;
    
    _titleLabel = [UILabel new];
    _titleLabel.text = _titleLabelText;
    _titleLabel.layer.borderColor = UIColor.blueColor.CGColor;
    _titleLabel.layer.borderWidth = 0.3;
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textColor = UIColor.lightGrayColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_titleLabel sizeToFit];
    _titleLabel.frame = CGRectMake(5,5,self.frame.size.width-10,self.frame.size.height-10);
    
    _bottomLine = [UIView new];
    _bottomLine.backgroundColor = UIColor.lightGrayColor;
    _bottomLine.frame = CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5);
    
    [self addSubview:_titleLabel];
    [self addSubview:_bottomLine];
    
}

@end
