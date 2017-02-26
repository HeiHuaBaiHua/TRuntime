//
//  HHContainerAlbum.h
//  TRuntime
//
//  Created by 黑花白花 on 2017/2/25.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HHAlbum.h"

@interface ProtoResult : NSObject
@property (strong, nonatomic) NSArray *albumArray;
@end

@interface ProtoContainerAlbum : NSObject

@property (copy, nonatomic) NSString *avatar;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *albumDesc;
@property (copy, nonatomic) NSString *albumName;
@property (copy, nonatomic) NSString *albumCover;

@property (assign, nonatomic) BOOL subscribeState;

@property (assign, nonatomic) NSInteger level;
@property (assign, nonatomic) NSInteger userId;
@property (assign, nonatomic) NSInteger albumId;
@property (assign, nonatomic) NSInteger albumType;
@property (assign, nonatomic) NSInteger clickTime;
@property (assign, nonatomic) NSInteger createTime;
@property (assign, nonatomic) NSInteger lastUpdTime;

@property (assign, nonatomic) NSInteger subscribeCount;
@property (assign, nonatomic) NSInteger albumVoiceCount;
@property (assign, nonatomic) NSInteger updateVoiceCount;
@property (assign, nonatomic) NSInteger friendSubscribeCount;

@property (strong, nonatomic) NSArray *albumArray;
@property (strong, nonatomic) ProtoResult *result;

@end

@interface HHContainerAlbum : NSObject

@property (copy, nonatomic) NSString *HHavatar;
@property (copy, nonatomic) NSString *HHnickname;
@property (copy, nonatomic) NSString *albumDesc;
@property (copy, nonatomic) NSString *HHalbumName;
@property (copy, nonatomic) NSString *albumCover;

@property (assign, nonatomic) BOOL subscribeState;

@property (assign, nonatomic) NSInteger level;
@property (assign, nonatomic) NSInteger HHuserId;
@property (assign, nonatomic) NSInteger albumId;
@property (assign, nonatomic) NSInteger albumType;
@property (assign, nonatomic) NSInteger clickTime;
@property (assign, nonatomic) NSInteger createTime;
@property (assign, nonatomic) NSInteger lastUpdTime;

@property (assign, nonatomic) NSInteger subscribeCount;
@property (assign, nonatomic) NSInteger albumVoiceCount;
@property (assign, nonatomic) NSInteger updateVoiceCount;
@property (assign, nonatomic) NSInteger friendSubscribeCount;

@property (strong, nonatomic) NSArray *albumArray;
@property (strong, nonatomic) NSArray *strangeAlbumArray;

@end
