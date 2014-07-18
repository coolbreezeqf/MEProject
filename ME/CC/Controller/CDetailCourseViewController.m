//
//  CDetailCourseViewController.m
//  移动教育1.0
//
//  Created by yato_kami on 14-7-5.
//  Copyright (c) 2014年 yatokami. All rights reserved.
//

#import "CDetailCourseViewController.h"
#import "CDetailHead.h"
#import "CChapterViewController.h"


@interface CDetailCourseViewController ()

@property (strong, nonatomic) NSArray *courseSectionArray; // 课程数组，分阶段
@end

@implementation CDetailCourseViewController

#pragma mark - getter and setter


- (NSArray *)courseSectionArray
{
    if (!_courseSectionArray) {
#warning 待补完连接后台取数据，目前沙盒数据测试
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CourseSectionData" ofType:@"plist"];
        _courseSectionArray = [NSArray arrayWithContentsOfFile:path];
        //NSLog(@"%@",_courseSectionArray);
    }
    return _courseSectionArray;
}

#pragma mark - 类构造方法
+ (instancetype)detailCourseVCwithCourseDirection:(CourseDirection *)courseDirection
{
    CDetailCourseViewController *CDCourseVC = [[CDetailCourseViewController alloc] initWithStyle:UITableViewStylePlain];
    CDCourseVC.courseDirection = courseDirection;
    CDCourseVC.title = courseDirection.CDhead; //设置标题
    return CDCourseVC;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //self.title = self.courseDirection.CDhead;
    }
    return self;
}

#pragma mark - 控制旋转
-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 60.0; //设置cell高度
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.courseSectionArray.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section != 0 ) {
        NSArray *CScontent = [self.courseSectionArray[section-1] objectForKey:@"CScontent"];
        return CScontent.count;
    } else
        return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIentifier = @"CScell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
    }
    NSArray *CScontent = [self.courseSectionArray[indexPath.section-1] objectForKey:@"CScontent"];
    cell.textLabel.text = [CScontent[indexPath.row] objectForKey:@"courseName"];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[CScontent[indexPath.row] objectForKey:@"courseImageUrl"]]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        CDetailHead *headView = [[CDetailHead alloc] init];
        [self setFirstHeadUI:headView];
        return headView;
    } else {
        static NSString *headIdentifier = @"myHead";
        UIView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headIdentifier];
    
        if (!view) {
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 20)];
            label.tag = 201;
            view.backgroundColor = [UIColor colorWithRed:0.2 green:0.8 blue:0.2 alpha:0.8];
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
        }
        UILabel *label = (UILabel *)[view viewWithTag:201];
        label.text = [NSString stringWithFormat:@"学习阶段%d:%@",section,[self.courseSectionArray[section - 1] objectForKey:@"CSname"]];
        return view;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 200;
    } else
        return 30;
}

#pragma mark - 设置首个head的UI
- (void)setFirstHeadUI:(CDetailHead *)headView
{
    headView.imageView.image = self.courseDirection.cacheImage;
    headView.detailTextView.text = self.courseDirection.CDdetail;
    headView.courseNumLabel.text = [NSString stringWithFormat:@"%d",self.courseDirection.CDcourseNum];
    headView.videoNumLabel.text = [NSString stringWithFormat:@"%d",self.courseDirection.CDvideoNum];
    headView.practiceNumLabel.text = [NSString stringWithFormat:@"%d",self.courseDirection.CDpracticeNum];
}

#pragma mark - 选择 进行页面跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section) {
        NSArray *stageArray = self.courseSectionArray[indexPath.section-1][@"CScontent"];
        NSInteger courseID = [stageArray[indexPath.row][@"courseID"] integerValue];
        CChapterViewController *headVC = [CChapterViewController chapterVCwithCourseID:courseID];
        [self.navigationController pushViewController:headVC animated:YES];
        
    }
}



@end