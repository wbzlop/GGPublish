//
//  GGSDK.h
//  GG
//
//  Created by wbz on 2020/6/15.
//  Copyright © 2020 GameGoing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GGSDK : NSObject

typedef void(^GetChannelComplete)(NSString *);


/// 获取渠道
/// @param onChannel <#onChannel description#>
+(void)getChannel:(GetChannelComplete)onChannel;


/// 初始化sdk
/// @param appkey appkey(运营提供)
/// @param adKey 广告key(运营提供)
/// @param buglyAppId 广告key(运营提供)
/// @param appleAppId appleId(运营提供)
/// @param debug 调试模式，可查看更多日志信息
+(void)initWithAppKey:(NSString *)appkey adKey:(NSString *)adKey buglyAppId:(NSString *)buglyAppId appleAppId:(NSString *)appleAppId debug:(BOOL)debug;



///  如需自定义af key ,请务必在初始化之前调用
/// @param afKey <#afKey description#>
+(void)setAFKey:(NSString *)afKey;



@end

NS_ASSUME_NONNULL_END
