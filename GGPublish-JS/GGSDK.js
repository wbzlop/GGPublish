class GGSDK {
    constructor() {

    }

    config = require("./GGConfig")

    DidReward = function(){}
    DidShow = function(){}
    DidClose = function(){}
    DidFailed = function(errMsg){}

    /**
    * 
    * @api {none} GGSDK.init()
    * @apiDescription 初始化 SDK(仅iOS使用)
    * @apiGroup GGSDK
     * @apiVersion 1.0.0
    * @apiExample {js} 使用示例:
               GGSDK.init();
    */
    init() {
        if (cc.sys.isNative && cc.sys.os == cc.sys.OS_IOS) {
            jsb.reflection.callStaticMethod("GGCocosAdapter", "initWithAppKey:adKey:buglyAppId:appleAppId:debug:", this.config.APP_KEY,this.config.AD_KEY,this.config.BUGLY_APP_ID,this.config.APPLE_APP_ID,this.config.DEBUG);
        }
    }

    track(eventName)
    {
        if (cc.sys.isNative && cc.sys.os == cc.sys.OS_IOS) {
            jsb.reflection.callStaticMethod("GGCocosAdapter", "trackWithName:eventValue:eventConfigVersion:eventInfoStr:", eventName,"","","");
        }
    }

    track(eventName,eventMap)
    {
        if (cc.sys.isNative && cc.sys.os == cc.sys.OS_IOS) {
            jsb.reflection.callStaticMethod("GGCocosAdapter", "trackWithName:eventValue:eventConfigVersion:eventInfoStr:", eventName,"","",JSON.stringify(eventMap));
        }
    }

    track(eventName,eventValue,eventConfigVersion,eventMap){
        if (cc.sys.isNative && cc.sys.os == cc.sys.OS_IOS) {
            jsb.reflection.callStaticMethod("GGCocosAdapter", "trackWithName:eventValue:eventConfigVersion:eventInfoStr:", eventName,eventValue,eventConfigVersion,JSON.stringify(eventMap));
        }
    }

    showRewardedVideo(placementId,didShowFunc,didFailedFunc,didRewardFunc,didCloseFunc)
    {
        this.DidReward = function(){}
        this.DidShow = function(){}
        this.DidClose = function(){}
        this.DidFailed = function(errMsg){}
        if(didRewardFunc)this.DidReward = didRewardFunc;
        if(didShowFunc)this.DidShow = didShowFunc;
        if(didFailedFunc)this.DidFailed = didFailedFunc;
        if(didCloseFunc)this.DidClose = didCloseFunc;

        if (cc.sys.isNative && cc.sys.os == cc.sys.OS_IOS) {
            return jsb.reflection.callStaticMethod("GGCocosAdapter", "showRewardedVideo:",placementId);
        }
        else
        {
            this.DidShow();
            this.DidReward();
            this.DidClose();
        }
    }

    
    hasRewardedVideo()
    {
        if (cc.sys.isNative && cc.sys.os == cc.sys.OS_IOS) {
            return jsb.reflection.callStaticMethod("GGCocosAdapter", "hasRewardedVideo");
        }
        else
        {
            return true;
        }
    }

    showInterstitial(placementId,didShowFunc,didFailedFunc,didCloseFunc)
    {
    
        this.DidShow = function(){}
        this.DidClose = function(){}
        this.DidFailed = function(errMsg){}
        if(didShowFunc)this.DidShow = didShowFunc;
        if(didFailedFunc)this.DidFailed = didFailedFunc;
        if(didCloseFunc)this.DidClose = didCloseFunc;
        if (cc.sys.isNative && cc.sys.os == cc.sys.OS_IOS) {
            return jsb.reflection.callStaticMethod("GGCocosAdapter", "showInterstitial:",placementId);
        }
        else
        {
            this.DidShow();
            this.DidClose();
        }
    }

}

window.GGSDK = new GGSDK();

