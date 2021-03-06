//
//  FocusTableViewController.m
//  Online_learning
//
//  Created by qf on 14/7/9.
//  Copyright (c) 2014年 qf. All rights reserved.
//

#import "FocusTableViewController.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"
#import "User.h"
#import "CAlertLabel.h"
#import "UserCenterTableViewController.h"
#import "OLNetManager.h"
#define kDefault_portrait @"CuserPhoto"
@interface FocusTableViewController ()

@end

@implementation FocusTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithData:(NSArray *)data{
	if (self = [super initWithStyle:UITableViewStylePlain]) {
		self.data = [data mutableCopy];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//	 self.navigationItem.rightBarButtonItem = self.editButtonItem;
	if (_list) {
		[_list refreshLinkContent];
		_data = _list.linkContent;
	}
	[self setExtraCellLineHidden:self.tableView];
}
//隐藏多余分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}


- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.tabBarController.tabBar.hidden = YES;
	self.navigationController.navigationBarHidden = NO;
	if (_list && [User sharedUser].havaChange) {
		[_list refreshLinkContent];
		_data = _list.linkContent;
		[self.tableView reloadData];
		[User sharedUser].havaChange = NO;
		[User sharedUser].refreshMe = YES;
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	NSInteger count = [_data count];
	if (count == 0) {
		self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 150, 200, 30)];
		label.textColor = [UIColor lightGrayColor];
		label.text = @"这里还没有东西～～";
		[self.tableView addSubview:label];
	}else{
		self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	}
    return count;
//    return [_data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identifier = @"FocusCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
	}
    
    // Configure the cell...
	NSDictionary *focusDic = [_data objectAtIndex:indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:kUrl_image([focusDic objectForKey:@"userPortrait"])] placeholderImage:[UIImage imageNamed:kDefault_portrait]];
	[cell.imageView.layer setBorderWidth:1];
	[cell.imageView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
	cell.textLabel.text = [focusDic objectForKey:@"userName"];
	cell.detailTextLabel.text = [focusDic objectForKey:@"userSign"];
//	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(70, 43, 235, 1)];
//	view.backgroundColor = [UIColor lightGrayColor];
//	[cell.contentView addSubview:view];
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSDictionary *dic = [_data objectAtIndex:indexPath.row];
//	DetailViewController *dvc = [[DetailViewController alloc] initWithUserId:[dic objectForKey:@"userId"]];
	UserCenterTableViewController *usercenter =[[UserCenterTableViewController alloc] initWithUserId:[[dic objectForKey:@"userId"] integerValue]];

	[self.navigationController pushViewController:usercenter animated:YES];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//#warning 网络请求
//		NSInteger result = [OLNetManager focusUserWithUserId:[[_data objectAtIndex:indexPath.row] objectForKey:@"userId"]];
//		if (result != 2){
//			//网络请求 结果错误 提示
//			[[CAlertLabel alertLabelWithAdjustFrameForText:@"删除失败"] showAlertLabel];
//			return ;
//		}
//		[[CAlertLabel alertLabelWithAdjustFrameForText:@"删除成功"] showAlertLabel];
//		[_data removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//		[[User sharedUser] refreshInfo];
//
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
