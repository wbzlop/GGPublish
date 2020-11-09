# GameGoing Publish SDK Integrated[Cocos]

![icon](pic/icon.png)

Version:2.7.0

Cocos Creator Version:2.4.2

## SDK接入

### Cocos 配置

1、集成

将 GGPublish-Cocos 文件夹下文件导入cocos 工程；

2、SDK配置

在GGConfig.js 文件中完成配置，具体信息由运营同学提供；

![setting](pic/setting.png)

###Xcode 配置

1. 先安装[Cocoapods](https://guides.cocoapods.org/using/getting-started.html)；
2. 通过 `pod repo update` 更新仓库；
3. cocos creator构建工程完成后，在  `项目根目录/build/jsb-link/frameworks/runtime-src/proj.ios_mac`创建podfile文件，并添加:

```objective-c
target 'xxxxxxx-mobile' do
platform :ios, '9.0'

pod 'GGPublish'
 
end
```

4. 点击 XXXXX.xcodeproj 文件打开工程

![configurationsSetting](/Users/wubaozeng/Documents/work/GGPublish/Document/pic/configurationsSetting.png)

在对应位置添加 **$(inherited)**

![searchSetting](/Users/wubaozeng/Documents/work/GGPublish/Document/pic/searchSetting.png)

5. 新建位于当前目录下的终端窗口，执行：

   ```
   pod install
   ```

6. 将 `CocosAdapter`文件夹下的文件导入Xcode工程：

![importAdapter](/Users/wubaozeng/Documents/work/GGPublish/Document/pic/importAdapter.png)

至此完成iOS端的接入。

### 添加广告源

在podfile 文件中，添加对应适配器依赖后，执行`pod install` 即可

```js
#必须
pod 'IronSourceSDK','7.0.0.0'

#可选
pod 'IronSourceAdColonyAdapter','4.3.2.5'
pod 'IronSourceAdMobAdapter','4.3.15.0'
pod 'IronSourceAmazonAdapter','4.3.4.5'
pod 'IronSourceAppLovinAdapter','4.3.15.4'
pod 'IronSourceChartboostAdapter','4.3.3.0'
pod 'IronSourceFacebookAdapter','4.3.18.4'
pod 'IronSourceFyberAdapter','4.3.6.0'
pod 'IronSourceHyprMXAdapter','4.1.6.4'
pod 'IronSourceInMobiAdapter','4.3.7.5'
pod 'IronSourceMaioAdapter','4.1.6.5'
pod 'IronSourcePangleAdapter','4.1.5.3'
pod 'IronSourceTapjoyAdapter','4.1.13.0'
pod 'IronSourceUnityAdsAdapter','4.3.4.1'
pod 'IronSourceVungleAdapter','4.3.3.1'
```

##初始化

所有网络接口都已Promise化。

```js
GG.init().then((userInfo)=>{
    console.log("初始化成功");
})
.catch((msg)=>{
    console.log("初始化失败："+msg);
});
```

初始化完成后，返回用户信息[UserInfo](#UserInfo)

###账户余额

直接获取

```js
//金币数量
GGData.coin
//现金数量
GGData.money
```

侦听账户变化

```js
cc.game.on(EventConst.GGSDK_COIN_UPDATE,function (amount) {

   //金币发生变化
})

cc.game.on(EventConst.GGSDK_MONEY_UPDATE,function (amount) {

    //现金发生变化
})
```

## 激励场景使用

###导入模版

将GGPublish/Prefabs/GameGoing.prefab 拖入场景。

### 激励入口判断

开发者可通过以下方法，判断自定义入口是否显示。  

```js
GG.entranceAvailable(EntranceType=>{
    
    if(EntranceType.Withdraw)
    {
        //提现界面可展示
    }
    
    if(EntranceType.Bubble)
   {
		//气泡宝箱不可展示
   }
   
    //……其他入口判断
    
});
```

其中[EntranceType](#EntranceType) 是入口类型。

### 气泡宝箱模板

一、在适当时机，触发激励场景，比如：过关的时候、成就达成、分数增加等，具体和运营沟通。

```js
/**
 * 触发
 * @param {cc.Vec2} position 坐标
 * @param {GG.ViewDelegate} delegate 监听界面的界面生命周期,可传null
 */
GG.Bubble.show(position,new ViewDelegateImp());
```

其中[ViewDelegateImp](#ViewDelegateImp) 可以监听界面的界面生命周期。

二、其他接口

```js
/**
 *移动气泡
 * @param {cc.Vec2} position 目标位置
 * @param {number} duration 持续时长
 */
GG.Bubble.move(position,duration)

/**
 * 销毁气泡
 */
GG.Bubble.remove()
```

### 多样化模板

一、在GGConfig.js的 `MULTIPLE_IDS` 中添加运营提供自定义ID，如果没有要求，则忽略。

二、在适当时机，触发激励场景，比如：过关的时候、成就达成、分数增加等，具体和运营沟通。

```js
/**
 * 触发
 * @param {GG.ViewDelegate} delegate 监听界面的界面生命周期,可传null
 */
GG.Multiple.show(new ViewDelegateImp())


//或者


/**
 * 触发
 * @param {GG.ViewDelegate} delegate 监听界面的界面生命周期,可传null
 * @param {String} multipleId  运营提供的自定义ID
*/
GG.Multiple.show(new ViewDelegateImp(),"XXX运营提供的自定义IDXXX");
```

其中[ViewDelegateImp](#ViewDelegateImp) 可以监听界面的界面生命周期。

### 提现界面

一、点击合适的入口，显示提现界面。

```js
/**
 * 展示提现界面
 * @param {GG.ViewDelegate} delegate 监听界面的界面生命周期,可传null
*/
GG.Withdraw.show(new ViewDelegateImp())
```

其中[ViewDelegateImp](#ViewDelegateImp) 可以监听界面的界面生命周期。

二、开发者可自行设计提现界面入口，也可直接使用 `GGPublish/Prefabs/GGBalanceView.prefab` 作为入口。

将prefab拖入场景，调整合适位置即可。

SDK提供的用户资产包括现金和金币，开发者可以联系我们的运营人员，确认使用哪一种资产或者两种都用，从而设计对应的提现界面入口。

注意：非激励用户不能显示入口。务必查看[激励入口判断](#激励入口判断) 

## 激励进阶

### 自动弹窗界面侦听

（可选）`SDK`初始化或者切换到前台时，可能会弹出奖励和活动的界面，开发者可以在**`SDK`初始化之前**设置界面的生命周期监听。

```js
GG.AutoPop.addViewDelegate(new ViewDelegateImp())
```

其中[ViewDelegateImp](#ViewDelegateImp) 可以监听界面的界面生命周期。

### 配置道具

如果开发者工程有道具需要激励模块支持，可以在GGPublish/Prefabs/GameGoing.prefab的子层级 PropAssets 中配置：

![propLocal](/Users/wubaozeng/Documents/work/lf-publish-sdk-cocos/Document/pic/propLocal.png)

配置示例如下：

![prop](/Users/wubaozeng/Documents/work/lf-publish-sdk-cocos/Document/pic/prop.png)

## 广告接口使用

###展示激励视频广告

```js
GG.Ad.showRewardedVideo("xxx场景ID，运营提供xxxx",()=>{
            //激励展示
            console.log("激励广告展示");
        },(errMsg)=>{
            //激励展示失败
            console.log("激励广告失败："+errMsg);
        },()=>{
            //奖励用户
            console.log("给用户发放奖励");
        },()=>{
            //奖励用户    
            console.log("激励广告关闭");     
        });
```

###是否有激励视频缓存

```js
GG.Ad.hasRewardedVideo();
```

###展示插屏广告

```js
GG.Ad.showInterstitial("xxx场景ID，运营提供xxxx",()=>{
            
            console.log("插屏广告展示");
        },(errMsg)=>{
           
            console.log("插屏广告失败："+errMsg);
        },()=>{
               
            console.log("插屏广告关闭");     
        });
```

## 其他功能

###事件打点

```js
 GG.EventTrack.track("eventName");

//或者

let info = {
            key_1: "value_1",
            key_2: "value_2",
        }
 GG.EventTrack.track("eventName",info);
```



## 类说明

### UserInfo

```js
//用户唯一标志
userId,
//当前服务器时间
serverTime,
//国家
country,
//货币代码
currency,
```

### ViewDelegateImp

```js

class ViewDelegateImp extends GG.ViewDelegate{

    /**
     * 界面展示失败
     * @type {GG.FailureReason} failureReason
     */
    OnFailed(failureReason){
        console.log( "展示失败：" + failureReason)
    }

    /**
     *界面展示成功
     */
    OnShow(){
        console.log( "展示成功")
    }

    /**
     * 触发激励
     */
    OnOpen(){
      
    }

    /**
     *
     * 结算完成
     */
    OnSettleCompleted(){
        console.log( "结算成功")
    }

    /**
     * 界面关闭销毁
     * @type {GG.DismissReason} dismissReason
     */
    OnDestory( dismissReason){
        console.log("销毁")
    }

    /**
     * OnDestory之后，可能会播放插屏，插屏关闭回调
     */
    OnInsFinish(){
        console.log("插屏关闭")
    }
}
```

###EntranceType

```js
EntranceType
{
    None,
    //大转盘
    Turntable,
    //刮刮卡
    Scratcher,
    //老虎机
    Slot,
    //提现
    Withdraw,
    //每日任务
    DailyTask,
    //签到
    SignIn,
    //气泡宝箱
    Bubble,
    //过关宝箱
    Pass,
    //漂浮宝箱
    Float,
    //多样化宝箱
    Multiple,
    //弹出宝箱
    Auto,
}
```

