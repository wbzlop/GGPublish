//
//  GGCocosAdapter.m
//  GGSDK_cocos_demo-mobile
//
//  Created by wbz on 2020/6/16.
//

#import "GGCocosAdapter.h"
#import "cocos2d.h"
#include "cocos/scripting/js-bindings/jswrapper/SeApi.h"
#import <GGPublish/GG.h>
#import <ZZAnalyticsSDK/AnalyticsSDK.h>
@interface GGCocosAdapter()<GGRewardedVideoDelegate,GGInterstitialAdDelegate>

@end

@implementation GGCocosAdapter

+ (instancetype)defaultAdapter {
    static id instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
    });
    return instance;
}

+(void)initWithAppKey:(NSString *)appkey adKey:(NSString *)adKey buglyAppId:(NSString *)buglyAppId appleAppId:(NSString *)appleAppId debug:(BOOL)debug
{
    [GGSDK initWithAppKey:appkey adKey:adKey buglyAppId:buglyAppId appleAppId:appleAppId debug:debug];
    [GGRewardedVideo setDelegate:[GGCocosAdapter defaultAdapter]];
    [GGInterstitialAd setDelegate:[GGCocosAdapter defaultAdapter]];
}


+(void)trackWithName:(NSString *)name eventValue:(NSString *)value eventConfigVersion:(NSString *)configVersion eventInfoStr:(NSString *)infoStr
{

    [AnalyticsSDK trackWithName:name eventValue:value eventId:nil eventConfigVersion:configVersion enentInfoStr:infoStr];
 
}


+(void)showInterstitial:(NSString *)placementId
{
    [GGInterstitialAd show:placementId];
}

+(void)showRewardedVideo:(NSString *)placementId
{
    [GGRewardedVideo show:placementId];
}

+(BOOL)hasRewardedVideo
{
    return [GGRewardedVideo hasRewardedVideo];
}

#pragma rewardedVideo delegate

/**
 Called after a rewarded video has been viewed completely and the user is eligible for reward.
*/
- (void)didReceiveReward
{
 
    std::string jsCallStr = cocos2d::StringUtils::format("GGSDK.DidReward();");
    se::Value *ret = new se::Value();
    se::ScriptEngine::getInstance()->evalString(jsCallStr.c_str() , -1 , ret);
}

/**
Called after a rewarded video has attempted to show but failed.

@param error The reason for the error
*/
- (void)rewardedVideoDidFailToShowWithError:(NSError *)error
{
    std::string strRet = [error.userInfo.description UTF8String];
    std::string jsCallStr = cocos2d::StringUtils::format("GGSDK.DidFailed(\"%s\");", strRet.c_str());
    se::Value *ret = new se::Value();
    se::ScriptEngine::getInstance()->evalString(jsCallStr.c_str() , -1 , ret);
}

/**
 Called after a rewarded video has been opened.
 */
- (void)rewardedVideoDidOpen{
    std::string jsCallStr = cocos2d::StringUtils::format("GGSDK.DidShow();");
    se::Value *ret = new se::Value();
    se::ScriptEngine::getInstance()->evalString(jsCallStr.c_str() , -1 , ret);
}

/**
 Called after a rewarded video has been dismissed.
 */
- (void)rewardedVideoDidClose{
    std::string jsCallStr = cocos2d::StringUtils::format("GGSDK.DidClose();");
    se::Value *ret = new se::Value();
    se::ScriptEngine::getInstance()->evalString(jsCallStr.c_str() , -1 , ret);
}


#pragma interstitial delegate
/**
 Called after an interstitial has been loaded
 */
- (void)interstitialDidLoad
{
    
}

/**
 Called after an interstitial has attempted to load but failed.

 @param error The reason for the error
 */
- (void)interstitialDidFailToLoadWithError:(NSError *)error{

}

/**
  Called after an interstitial has been dismissed.
 */
- (void)interstitialDidClose{
    std::string jsCallStr = cocos2d::StringUtils::format("GGSDK.DidClose();");
    se::Value *ret = new se::Value();
    se::ScriptEngine::getInstance()->evalString(jsCallStr.c_str() , -1 , ret);
}

/**
 Called after an interstitial has been displayed on the screen.
 */
- (void)interstitialDidShow{
    std::string jsCallStr = cocos2d::StringUtils::format("GGSDK.DidShow();");
    se::Value *ret = new se::Value();
    se::ScriptEngine::getInstance()->evalString(jsCallStr.c_str() , -1 , ret);
}

/**
 Called after an interstitial has attempted to show but failed.

 @param error The reason for the error
 */
- (void)interstitialDidFailToShowWithError:(NSError *)error{
    std::string strRet = [error.userInfo.description UTF8String];
    std::string jsCallStr = cocos2d::StringUtils::format("GGSDK.DidFailed(\"%s\");", strRet.c_str());
    se::Value *ret = new se::Value();
    se::ScriptEngine::getInstance()->evalString(jsCallStr.c_str() , -1 , ret);
}

@end
