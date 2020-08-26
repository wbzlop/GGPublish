//
//  GGRewardedVideo.h
//  GG
//
//  Created by wbz on 2020/6/15.
//  Copyright © 2020 GameGoing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GGRewardedVideoDelegate <NSObject>
@required
/**
 Called after a rewarded video has been viewed completely and the user is eligible for reward.
*/
- (void)didReceiveReward;

/**
Called after a rewarded video has attempted to show but failed.

@param error The reason for the error
*/
- (void)rewardedVideoDidFailToShowWithError:(NSError *)error;

/**
 Called after a rewarded video has been opened.
 */
- (void)rewardedVideoDidOpen;

/**
 Called after a rewarded video has been dismissed.
 */
- (void)rewardedVideoDidClose;


@end

@interface GGRewardedVideo : NSObject


/// 展示广告
+(void)show:(NSString *)placementId;

+(void)setDelegate:(id<GGRewardedVideoDelegate>)delegate;

///是否有广告
+(BOOL)hasRewardedVideo;

+(void)trackTriggleredFail:(NSString *)placementId errorMsg:(NSString *)errorMsg;

@end

NS_ASSUME_NONNULL_END
