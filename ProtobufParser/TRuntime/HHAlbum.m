//
//  OTSAlbum.m
//  OneToSay
//
//  Created by HDD on 16/6/13.
//  Copyright © 2016年 Excetop. All rights reserved.
//

#import "HHAlbum.h"

@implementation ProtoAlbum
@end

@implementation HHAlbum

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

