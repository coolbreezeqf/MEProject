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

@end