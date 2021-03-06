//
//  UserInfo.m
//  Online_learning
//
//  Created by qf on 14/7/7.
//  Copyright (c) 2014年 qf. All rights reserved.
//

#import "UserInfo.h"
#import "OLNetManager.h"
@interface UserInfo ()
@property (nonatomic,strong) NSString *userPass;
@end

@implementation UserInfo



- (id)init{
	if (self = [super init]) {
		_data		= nil;
		_userId		= 0;
		_points		= 0;
		_isLogin	= NO;
		_account	= nil;
		_name		= nil;
		_sex		= NO;
//		_image		= nil;
		_imageUrl	= nil;
		_describe	= nil;
		_lcourses	= nil;
		_fightvalue = nil;
		_ccourses	= nil;
		_bcourses	= nil;
		_focus		= nil;
		_focused	= nil;
		_questions	= nil;
		_answers	= nil;
		_testcollection = nil;
		[self lastUserInfo];  //初始化时判断沙盒中是否存在数据 并设置数据
	}
	return self;
}

- (id)initWithUserId:(NSInteger)userId{
	if (self = [super init]) {
		_data		= [[OLNetManager userDataWithId:userId] objectForKey:@"result"];
		_userId		= 0;
		_points		= 0;
		_account	= nil;
		_name		= nil;
		_sex		= NO;
		_imageUrl	= nil;
		_describe	= nil;
		_lcourses	= nil;
		_fightvalue = nil;
		_ccourses	= nil;
		_bcourses	= nil;
		_focus		= nil;
		_focused	= nil;
		_questions	= nil;
		_answers	= nil;
		_testcollection = nil;
		[self setAllData];
	}
	return self;
}

- (void)setAllData{
	if (_data) {
		_userId		= [[_data objectForKey:@"userId"] integerValue];
		_account	= [_data objectForKey:@"userAccount"];
		_name		= [_data objectForKey:@"userName"];
		_sex		= [[_data objectForKey:@"userSex"] boolValue];
		_imageUrl	= [_data objectForKey:@"userPortrait"];
		_describe	= [_data objectForKey:@"userSign"];
		_points		= [[_data objectForKey:@"points"] integerValue];
		_fightvalue = [[ListInfo alloc] initWithDictionary:[_data objectForKey:@"fightvalue"]];
		_lcourses	= [[ListInfo alloc] initWithDictionary:[_data objectForKey:@"lcourses"]];
		_ccourses	= [[ListInfo alloc] initWithDictionary:[_data objectForKey:@"ccourses"]];
		_bcourses	= [[ListInfo alloc] initWithDictionary:[_data objectForKey:@"bcourses"]];
		_focus		= [[ListInfo alloc] initWithDictionary:[_data objectForKey:@"focus"]];
		_focused	= [[ListInfo alloc] initWithDictionary:[_data objectForKey:@"focused"]];
		_questions	= [[ListInfo alloc] initWithDictionary:[_data objectForKey:@"questions"]];
		_answers	= [[ListInfo alloc] initWithDictionary:[_data objectForKey:@"answers"]];
		_testcollection	= [[ListInfo alloc] initWithDictionary:[_data objectForKey:@"test"]];
	}
}

- (void)removeArrayData{
	_lcourses	= nil;
	_ccourses	= nil;
	_bcourses	= nil;
	_focus		= nil;
	_focused	= nil;
	_questions	= nil;
	_answers	= nil;
	_fightvalue = nil;
	_testcollection = nil;
}

- (BOOL)userLogout{
	NSDictionary *result = [OLNetManager logout];
	if ([[result objectForKey:@"success"] integerValue] == 1) {
		_data		= nil;
		
		_isLogin	= NO;
		_account	= nil;
		_name		= nil;
		_sex		= NO;
		_imageUrl	= nil;
		_describe	= nil;
		[self removeArrayData];
		[self saveUserStatus];
		return YES;
	}
	return NO;
}

//登陆 进行网络请求
- (BOOL)userLoginWith:(NSString *)userName andPassword:(NSString *)passWord{
	/*test*/
//	NSDictionary *dic = [OLNetManager loginWith:userName andPassword:passWord succ:^(NSDictionary *successDict) {
//	}];
//	NSDictionary *dic = [OLNetManager userDataWithId:_userId];
	NSDictionary *dic = [OLNetManager loginWith:userName andPassword:passWord];
	NSString *suc= [dic objectForKey:@"success"];

	if ([suc isEqualToString:@"true"]) {
		_data = [dic objectForKey:@"result"];
		[self setAllData];
		_isLogin = YES;
		_userPass = passWord;
		[self saveInfoToDocument];
		return YES;
	}else if([suc isEqualToString:@"no link"]){
		NSLog(@"no link OLNetWorking");
	}
	else{
		NSLog(@"user login is faliure by %@",self);
		return NO;
	}
	return NO;
}

- (BOOL)refresh{
	NSDictionary *dic = [OLNetManager userDataWithId:_userId];
	NSString *suc = [dic objectForKey:@"success"];
	
	if ([suc isEqualToString:@"true"]) {
		_data = dic[@"result"];
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			[self removeArrayData];
			[self setAllData];
			[self saveInfoToDocument];
		});
		return YES;
	}else {
		NSLog(@"user refresh is faliuser by %@",self);
		return NO;
	}
}

- (void)update{
	_data = [OLNetManager userDataWithId:_userId];
}

- (BOOL)lastUserInfo{	//判断沙盒中是否存在用户信息
	if ([[NSFileManager defaultManager] fileExistsAtPath:[self userFilePath]]) {
		NSDictionary *userDic = [NSDictionary dictionaryWithContentsOfFile:[self userFilePath]];
		NSDictionary *status = [userDic objectForKey:@"lastLogin"];
		NSDictionary *userInfo = [userDic objectForKey:@"userInfo"];
		if (status && [[status objectForKey:@"isLogin"] isEqualToString:@"YES"]) {
			_userPass = [status objectForKey:@"password"];
			_data = [[OLNetManager loginWith:[userInfo objectForKey:@"userAccount"] andPassword:_userPass] objectForKey:@"result"];
			[self setAllData];
			_isLogin = YES;
			return YES;
		}
	}
	return NO;
}

- (NSString *)userFilePath{
	static NSString *path = nil;
	if (!path) {
		NSArray *storeFilePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
		NSString *doucumentsDirectiory = [storeFilePath objectAtIndex:0];
		path =[doucumentsDirectiory stringByAppendingPathComponent:@"user.plist"];
	}
	return path;
}
//保存登陆状态到沙盒中
- (void)saveUserStatus{
	static const NSString *statusKey = @"lastLogin";
	NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:[self userFilePath]];
	NSMutableDictionary *status = [dic objectForKey:statusKey];
	if (!status) {
		status = [[NSMutableDictionary alloc] initWithDictionary:@{@"isLogin":_isLogin?@"YES":@"NO",@"password":_userPass,@"account":_account}];
		[dic setObject:status forKey:statusKey];
	}else{
		status[@"isLogin"]	= _isLogin?@"YES":@"NO";
		status[@"password"] = _userPass;
		dic[statusKey] = status;
	}
	[dic writeToFile:[self userFilePath] atomically:YES];
}

//保存数据到沙盒中
- (void)saveInfoToDocument{
    NSFileManager *file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:[self userFilePath]]){
		NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithContentsOfFile:[self userFilePath]];
		userDic[@"userInfo"] = _data;
		[userDic writeToFile:[self userFilePath] atomically:YES];
	}
    else {//若沙盒中没有
		NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithCapacity:42];
		NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithDictionary:_data];
		[userDic setObject:userInfo forKey:@"userInfo"];
		[userDic writeToFile:[self userFilePath] atomically:YES];
	}
	[self saveUserStatus];
}



















@end
