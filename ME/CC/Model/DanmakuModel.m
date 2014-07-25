//
//  DanmakuModel.m
//  移动教育1.0
//
//  Created by yato_kami on 14-7-15.
//  Copyright (c) 2014年 yatokami. All rights reserved.
//

#import "DanmakuModel.h"

#define maxNum 100

@implementation DanmakuModel

#pragma mark getter and setter
- (NSMutableArray *)moveDanmakuReUseArray
{
    if (_moveDanmakuReUseArray == nil) {
        _moveDanmakuReUseArray = [NSMutableArray arrayWithCapacity:maxNum];
    }
    return _moveDanmakuReUseArray;
}

- (NSMutableArray *)staticDanmakuReUseArray
{
    if (_staticDanmakuReUseArray == nil) {
        _staticDanmakuReUseArray = [NSMutableArray arrayWithCapacity:maxNum];
    }
    return _staticDanmakuReUseArray;
}

- (CGFloat)staticDanmakuY
{
    if (!_staticDanmakuY) {
        _staticDanmakuY = SCREEN_WIDTH;
    }
    return _staticDanmakuY;
}

- (CGFloat)moveDanmukuY
{
    if (!_moveDanmukuY) {
        _moveDanmukuY = SCREEN_HEIGHT;
    }
    return _moveDanmukuY;
}

#pragma mark - 复用
- (DanmakuView *)dequeueReusableDanmakuWithDanmakuType:(DanmakuType)type
{
    switch (type) {
        case moveDanmaku:
        {
            if (self.moveDanmakuReUseArray.count) {
                return self.moveDanmakuReUseArray.lastObject;
            }else
                return nil;
        }
            break;
        case staticDanmaku:
        {
            if (self.staticDanmakuReUseArray.count) {
                UILabel *lable = self.staticDanmakuReUseArray.lastObject;
                lable.alpha = 1.0f;
                return self.staticDanmakuReUseArray.lastObject;
            } else
                return nil;
        }
            break;
        default:
            break;
    }
}

- (void)addNoUseDanmaku:(DanmakuView *)danmakuLabel WithDanmakuType:(DanmakuType)type
{
    switch (type) {
        case moveDanmaku:
        {
            [self.moveDanmakuReUseArray addObject:danmakuLabel];
        }
            break;
        case staticDanmaku:
        {
            [self.staticDanmakuReUseArray addObject:danmakuLabel];
        }
            break;
        default:
            break;
    }
}

#pragma mark - anima

//- (void)danmakuAnimOfStaticDM:(DanmakuView *)dmView
//{
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_async(group, queue, ^{
//        NSTimer *myTimer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(dismissDM:) userInfo:dmView repeats:NO];
//        
//    })
//}


@end
