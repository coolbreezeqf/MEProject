//
//  CdownlordCell.m
//  ME
//
//  Created by yato_kami on 14-8-6.
//  Copyright (c) 2014年 yatokami. All rights reserved.
//

#import "CdownlordCell.h"



@implementation CdownlordCell

- (void)awakeFromNib
{
    [self.dDownloadButton addTarget:_cellDelegate action:@selector(touchStartorPauseButton:) forControlEvents:UIControlEventTouchUpInside];
    [self setSelectionStyle:UITableViewCellSelectionStyleBlue];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
