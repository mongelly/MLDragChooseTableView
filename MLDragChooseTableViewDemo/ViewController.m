//
//  ViewController.m
//  MLDragChooseTableViewDemo
//
//  Created by MogLu on 02/08/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import "ViewController.h"
#import "DemoTableViewDataSourceAndDelegate.h"

@interface ViewController ()

@end

@implementation ViewController
{
@private UITableView *_demoTableView;
@private DemoTableViewDataSourceAndDelegate *_tableViewDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     _tableViewDelegate = [DemoTableViewDataSourceAndDelegate new];
    _demoTableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 50, self.view.frame.size.width-100, self.view.frame.size.height - 100)];
    _demoTableView.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
    _demoTableView.separatorStyle = UITableViewCellAccessoryNone;
    _demoTableView.dataSource = _tableViewDelegate;
    _demoTableView.delegate = _tableViewDelegate;
    
    [self.view addSubview:_demoTableView];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
