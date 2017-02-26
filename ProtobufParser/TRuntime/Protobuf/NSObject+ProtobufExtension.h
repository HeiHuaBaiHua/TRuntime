//
//  NSObject+ProtobufExtension.h
//  TRuntime
//
//  Created by 黑花白花 on 16/6/15.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kHHObjectClassName;
extern NSString *const kHHProtobufObjectKeyPath;
@protocol HHProtobufExtension <NSObject>

+ (NSArray *)igonrePropertiesForProtobuf;/**< 从protobuf解析时忽略的属性 */
+ (NSDictionary *)replacedPropertyKeypathsForProtobuf;/**< protobuf替换键值 */
+ (NSDictionary *)containerPropertyKeypathsForProtobuf;/**< model中有model/model数组 时对应的keypath */

@end

@interface NSObject (ProtobufExtension)

+ (instancetype)instanceWithProtoObject:(id)protoObject;/**< protobuf数据转换为模型 */

@end
