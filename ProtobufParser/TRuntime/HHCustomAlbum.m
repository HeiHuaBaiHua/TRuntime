//
//  HHCustomAlbum.m
//  TRuntime
//
//  Created by 黑花白花 on 2017/2/25.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "HHCustomAlbum.h"

@implementation ProtoCustomAlbum
@end

@implementation HHCustomAlbum

+ (NSDictionary *)map {
    return @{@"HHavatar" : @"avatar",
             @"HHnickname" : @"nickname",
             @"HHalbumName" : @"albumName",
             @"HHuserId" : @"userId"};
}

#pragma mark - Protobuf

+ (NSDictionary *)replacedPropertyKeypathsForProtobuf {
    return [self map];
}

#pragma mark - YY

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return [self map];
}

#pragma mark - MJ

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return [self map];
}

@end
