//
//  TrendsViewController.h
//  ME
//
//  Created by Johnny's on 14-9-4.
//  Copyright (c) 2014年 yatokami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrendsViewController : UIViewController

@property(nonatomic, strong) UITableView *trendsTableView;
@property(nonatomic, strong) NSMutableArray *trendsArray;
@property(nonatomic, strong) UIActivityIndicatorView *activityView;
@property(nonatomic) int page;
@end
