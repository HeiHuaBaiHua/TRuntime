//
//  TRuntimeTests.m
//  TRuntimeTests
//
//  Created by 黑花白花 on 2017/2/23.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "HHAlbum.h"
#import "HHCustomAlbum.h"
#import "HHContainerAlbum.h"

#import "YYModel.h"
#import "MJExtension.h"
#import "NSObject+LogAllProperties.h"
#import "NSObject+ProtobufExtension.h"
@interface TRuntimeTests : XCTestCase

@end

@implementation TRuntimeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (NSDictionary *)normalSourceDictionary {
    return @{@"nickname":@"刘思涵",
             @"avatar":@"voice_album_thumb/1460528146_507.jpg",
             @"userId":@456,
             @"albumId":@"32354",
             @"albumCover":@"voice_album_thumb/1460528146_507.jpg",
             @"albumName":@"刘思涵【二刘之辈】微电台",
             @"albumDesc":@"【二刘之辈】是由歌手刘思涵主持的微电台节目。每月三期，每周二晚22:22分上线。（节目特色：每月有一个星期不更新）",
             @"albumVoiceCount":@"17",
             @"subscribeCount":@"40",@"friendSubscribeCount":@"0",
             @"subscribeUserArray":@[@1, @2]};
}

- (void)testPerformanceOfNormalParse {
    
    NSDictionary *dict = [self normalSourceDictionary];
    ProtoAlbum *protoAlbum = [ProtoAlbum yy_modelWithDictionary:dict];
    [self measureBlock:^{
        
        for (int i = 0; i < 10000; i++) {
            
            [HHAlbum mj_objectWithKeyValues:dict];
//            [HHAlbum yy_modelWithDictionary:dict];
//            [HHAlbum instanceWithProtoObject:protoAlbum];
        }
    }];
}

- (void)testPerformanceOfCustomParse {
    
    NSDictionary *dict = @{@"nickname" : @"刘思涵",
                           @"avatar" : @"voice_album_thumb/1460528146_507.jpg",
                           @"userId" : @456,
                           @"albumId" : @"32354",
                           @"albumCover" : @"voice_album_thumb/1460528146_507.jpg",
                           @"albumName" : @"刘思涵【二刘之辈】微电台",
                           @"albumDesc" : @"【二刘之辈】是由歌手刘思涵主持的微电台节目。每月三期，每周二晚22:22分上线。（节目特色：每月有一个星期不更新）",
                           @"albumVoiceCount" : @"17",
                           @"subscribeCount" : @"40",
                           @"friendSubscribeCount" : @"0",
                           @"subscribeUserArray" : @[@1, @2],
                           
                           @"album": @{@"nickname" : @"刘思涵2",
                                       @"avatar" : @"voice_album_thumb/1460528146_507.jpg2",
                                       @"userId" : @4562,
                                       @"albumId" : @"323542",
                                       @"albumCover" : @"voice_album_thumb/1460528146_507.jpg2",
                                       @"albumName" : @"刘思涵【二刘之辈】微电台2",
                                       @"albumDesc" : @"【二刘之辈】是由歌手刘思涵主持的微电台节目。每月三期，每周二晚22:22分上线。（节目特色：每月有一个星期不更新2",
                                       @"albumVoiceCount" : @"172",
                                       @"subscribeCount" : @"402",
                                       @"friendSubscribeCount" : @"02",
                                       @"subscribeUserArray":@[@1, @2, @4]}
                           };
    ProtoCustomAlbum *protoAlbum = [ProtoCustomAlbum yy_modelWithDictionary:dict];
    [self measureBlock:^{
        
        for (int i = 0; i < 10000; i++) {
            
//            [HHCustomAlbum mj_objectWithKeyValues:dict];
//            [HHCustomAlbum yy_modelWithDictionary:dict];
            [HHCustomAlbum instanceWithProtoObject:protoAlbum];
        }
    }];
}

- (void)testPerformanceOfContainerParse {
    
    NSDictionary *dict = @{@"nickname" : @"刘思涵",
                           @"avatar" : @"voice_album_thumb/1460528146_507.jpg",
                           @"userId" : @456,
                           @"albumId" : @"32354",
                           @"albumCover" : @"voice_album_thumb/1460528146_507.jpg",
                           @"albumName" : @"刘思涵【二刘之辈】微电台",
                           @"albumDesc" : @"【二刘之辈】是由歌手刘思涵主持的微电台节目。每月三期，每周二晚22:22分上线。（节目特色：每月有一个星期不更新）",
                           @"albumVoiceCount" : @"17",
                           @"subscribeCount" : @"40",
                           @"friendSubscribeCount" : @"0",
                           @"subscribeUserArray" : @[@1, @2],
                           
                           @"albumArray" : @[@{@"nickname" : @"刘思涵1",
                                               @"avatar" : @"voice_album_thumb/1460528146_507.jpg1",
                                               @"userId" : @4561,
                                               @"albumId" : @"323541",
                                               @"albumCover" : @"voice_album_thumb/1460528146_507.jpg1",
                                               @"albumName" : @"刘思涵【二刘之辈】微电台1",
                                               @"albumDesc" : @"【二刘之辈】是由歌手刘思涵主持的微电台节目。每月三期，每周二晚22:22分上线。（节目特色：每月有一个星期不更新）1",
                                               @"albumVoiceCount" : @"171",
                                               @"subscribeCount" : @"401",
                                               @"friendSubscribeCount" : @"1",
                                               @"subscribeUserArray" : @[@1, @2]},
                                             @{@"nickname" : @"刘思涵2",
                                               @"avatar" : @"voice_album_thumb/1460528146_507.jpg2",
                                               @"userId" : @4562,
                                               @"albumId" : @"323542",
                                               @"albumCover" : @"voice_album_thumb/1460528146_507.jpg2",
                                               @"albumName" : @"刘思涵【二刘之辈】微电台2",
                                               @"albumDesc" : @"【二刘之辈】是由歌手刘思涵主持的微电台节目。每月三期，每周二晚22:22分上线。（节目特色：每月有一个星期不更新）2",
                                               @"albumVoiceCount" : @"172",
                                               @"subscribeCount" : @"402",
                                               @"friendSubscribeCount" : @"2",
                                               @"subscribeUserArray" : @[@1, @2]},
                                             @{@"nickname" : @"刘思涵3",
                                               @"avatar" : @"voice_album_thumb/1460528146_507.jpg3",
                                               @"userId" : @4563,
                                               @"albumId" : @"323543",
                                               @"albumCover" : @"voice_album_thumb/1460528146_507.jpg3",
                                               @"albumName" : @"刘思涵【二刘之辈】微电台3",
                                               @"albumDesc" : @"【二刘之辈】是由歌手刘思涵主持的微电台节目。每月三期，每周二晚22:22分上线。（节目特色：每月有一个星期不更新）3",
                                               @"albumVoiceCount" : @"173",
                                               @"subscribeCount" : @"403",
                                               @"friendSubscribeCount" : @"3",
                                               @"subscribeUserArray" : @[@1, @2]}],
                           };
    ProtoResult *result = [ProtoResult new];
    NSMutableArray *albums = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        [albums addObject:[ProtoAlbum yy_modelWithDictionary:[self normalSourceDictionary]]];
    }
    result.albumArray = albums;
    
    ProtoContainerAlbum *protoAlbum = [ProtoContainerAlbum yy_modelWithDictionary:dict];
//    protoAlbum.result = result;
    
    [self measureBlock:^{
        
        for (int i = 0; i < 10000; i++) {
            
//            [HHContainerAlbum mj_objectWithKeyValues:dict];
//            [HHContainerAlbum yy_modelWithDictionary:dict];
            [HHContainerAlbum instanceWithProtoObject:protoAlbum];//这里因为会多解析result中的三个数组所以会比YYModel多三秒左右
        }
    }];
}

@end
