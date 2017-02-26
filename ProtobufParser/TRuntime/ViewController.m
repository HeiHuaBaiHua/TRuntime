//
//  ViewController.m
//  TRuntime
//
//  Created by 黑花白花 on 2017/2/25.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "ViewController.h"

#import "HHAlbum.h"
#import "HHCustomAlbum.h"
#import "HHContainerAlbum.h"

#import "YYModel.h"
#import "NSObject+DataMerge.h"
#import "NSObject+LogAllProperties.h"
#import "NSObject+ProtobufExtension.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //各家解析工具耗时详情请移步TRuntimeTests/TRuntimeTests.m
}

#pragma mark - Action

- (IBAction)normalParse:(UIButton *)sender {
    
    NSDictionary *dict = [self normalSourceDictionary];
    ProtoAlbum *protoAlbum = [ProtoAlbum yy_modelWithDictionary:dict];
    [[HHAlbum instanceWithProtoObject:protoAlbum] log];
}

- (IBAction)customParse:(UIButton *)sender {
    
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
    HHCustomAlbum *customAlbum = [HHCustomAlbum instanceWithProtoObject:protoAlbum];
    [customAlbum log];
    [customAlbum.album log];
}

- (IBAction)containerParse:(UIButton *)sender {
    
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
    ProtoContainerAlbum *protoAlbum = [ProtoContainerAlbum yy_modelWithDictionary:dict];
    NSMutableArray *albums = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        [albums addObject:[ProtoAlbum yy_modelWithDictionary:[self normalSourceDictionary]]];
    }
    result.albumArray = albums;
    protoAlbum.result = result;
    
    HHContainerAlbum *containerAlbum = [HHContainerAlbum instanceWithProtoObject:protoAlbum];
    [containerAlbum log];
    for (HHAlbum *album in containerAlbum.albumArray) {
        NSLog(@"albumArray");
        [album log];
    }
    for (HHAlbum *album in containerAlbum.strangeAlbumArray) {
        NSLog(@"strangeAlbumArray");
        [album log];
    }
}

#pragma mark - Getter

- (NSDictionary *)normalSourceDictionary {
    
    return @{@"nickname":@"刘思涵",
             @"avatar":@"voice_album_thumb/1460528146_507.jpg",
             @"userId":@456,
             @"subscribeState":@1,
             @"albumId":@"32354",
             @"albumCover":@"voice_album_thumb/1460528146_507.jpg",
             @"albumName":@"刘思涵【二刘之辈】微电台",
             @"albumDesc":@"【二刘之辈】是由歌手刘思涵主持的微电台节目。每月三期，每周二晚22:22分上线。（节目特色：每月有一个星期不更新）",
             @"albumVoiceCount":@"17",
             @"subscribeCount":@"40",@"friendSubscribeCount":@"0",
             @"subscribeUserArray":@[@1, @2]};
}

@end
