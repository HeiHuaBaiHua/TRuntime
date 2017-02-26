//
//  OTSAlbum.h
//  OneToSay
//
//  Created by HDD on 16/6/13.
//  Copyright © 2016年 Excetop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProtoAlbum : NSObject

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

@property (strong, nonatomic) NSArray *subscribeUserArray;

@end

@interface HHAlbum : NSObject

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

@property (strong, nonatomic) NSArray *subscribeUserArray;

@end

