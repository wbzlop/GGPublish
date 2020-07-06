//
//  GGInterstitialAd.h
//  GG
//
//  Created by wbz on 2020/6/15.
//  Copyright © 2020 GameGoing. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@protocol GGInterstitialAdDelegate<NSObject>

/**
 Called after an interstitial has been loaded
 */
- (void)interstitialDidLoad;

/**
 Called after an interstitial has attempted to load but failed.

 @param error The reason for the error
 */
- (void)interstitialDidFailToLoadWithError:(NSError *)error;

/**
  Called after an interstitial has been dismissed.
 */
- (void)interstitialDidClose;

/**
 Called after an interstitial has been displayed on the screen.
 */
- (void)interstitialDidShow;

/**
 Called after an interstitial has attempted to show but failed.

 @param error The reason for the error
 */
- (void)interstitialDidFailToShowWithError:(NSError *)error;



@end

@interface GGInterstitialAd : NSObject

+(void)show:(NSString *)placementId;

+(void)setDelegate:(id<GGInterstitialAdDelegate>)delegate;



@end

NS_ASSUME_NONNULL_END
