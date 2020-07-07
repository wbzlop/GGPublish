//
//  GGCocosAdapter.h
//  GGSDK_cocos_demo-mobile
//
//  Created by wbz on 2020/6/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GGCocosAdapter : NSObject

/// 初始化sdk
/// @param appkey appkey(运营提供)
/// @param adKey 广告key(运营提供)
/// @param appleAppId appleId(运营提供)
/// @param debug 调试模式，可查看更多日志信息
+(void)initWithAppKey:(NSString * __nonnull)appkey adKey:(NSString * __nonnull)adKey buglyAppId:(NSString *__nonnull)buglyAppId appleAppId:(NSString * __nonnull)appleAppId debug:(BOOL)debug;



/// 统计事件
/// @param name 事件名
/// @param value 事件值（可nil）
/// @param eventId 事件ID（可nil）
/// @param configVersion 策略版本（可nil）
/// @param infoStr 事件map（可nil）
+(void)trackWithName:(NSString *)name eventValue:(NSString *)value eventConfigVersion:(NSString *)configVersion eventInfoStr:(NSString *)infoStr;





@end

NS_ASSUME_NONNULL_END
