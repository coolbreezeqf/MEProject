//
//  JJDirectionModel.h
//  在线教育
//
//  Created by Johnny's on 14-7-23.
//  Copyright (c) 2014年 Johnny's. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJDirectionModel : NSObject<NSCopying, NSCoding>

@property(nonatomic ,copy) NSString *link;
@property(nonatomic) int tdId;
@property(nonatomic ,copy) NSString *tdName;
@property(nonatomic ,copy) NSString *tdPic;
@property(nonatomic ,copy) NSString *tdDetail;
@property(nonatomic) int testnum;
@property(nonatomic) int tdpersonnum;
@property(nonatomic, strong) UIImage *directionImage;

- (void)setDirectionModelWithDictionary:(NSDictionary *)dict;
@end
