//
//  TestCollectionTableViewController.m
//  ME
//
//  Created by qf on 14/8/4.
//  Copyright (c) 2014年 yatokami. All rights reserved.
//

#import "TestCollectionTableViewController.h"
#import "UIImageView+WebCache.h"
#import "JJTestTableViewCell.h"
#import "UILabel+dynamicSizeMe.h"
@interface TestCollectionTableViewController ()
@end

@implementation TestCollectionTableViewController

- (id)initWithStyle:(UITableViewStyle)style withData:(NSMutableArray *)data
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
		_testData = data;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // self.clearsSelectionOnViewWillAppear = NO;
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 90;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_testData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JJTestTableViewCell * lableSwitchCell;
    UINib *n;
    static NSString *CellIdentifier = @"JJTestTableViewCell";
    lableSwitchCell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (lableSwitchCell == nil)
		{
        NSArray *_nib=[[NSBundle mainBundle] loadNibNamed:@"JJTestTableViewCell"
                                                    owner:self  options:nil];
        lableSwitchCell  = [_nib objectAtIndex:0];
        //通过这段代码，来完成LableSwitchXibCell的ReuseIdentifier的设置
        //这里是比较容易忽视的，若没有此段，再次载入LableSwitchXibCell时，dequeueReusableCellWithIdentifier:的值依然为nil
        n= [UINib nibWithNibName:@"PlayTableviewCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:n forCellReuseIdentifier:@"PlayTableviewCell"];
		}
//    JJTestModel *testModel = [[JJTestModel alloc] init];
//    testModel = [self.testArray objectAtIndex:indexPath.row];
	NSDictionary *dic = [_testData objectAtIndex:indexPath.row];
    [lableSwitchCell.imgView setImageWithURL:[NSURL URLWithString:kUrl_image(dic[@"tcPhotoUrl"])]];
    lableSwitchCell.nameLabel.text = [NSString stringWithFormat:@" %@", dic[@"tcName"]];
    lableSwitchCell.nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11];
    lableSwitchCell.personNums.text = [NSString stringWithFormat:@"%@", dic[@"tcNum"]];
    [lableSwitchCell.nameLabel resizeToFit];
    lableSwitchCell.detailLa.text = dic[@"tcIntro"];
    lableSwitchCell.myLabel2.text = @"题数:";
    lableSwitchCell.testNumLa.text = [NSString stringWithFormat:@"%@",dic[@"subjectnums"]];
	
    lableSwitchCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return lableSwitchCell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
#warning 删除数据请求
		[_testData removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
}
@end
