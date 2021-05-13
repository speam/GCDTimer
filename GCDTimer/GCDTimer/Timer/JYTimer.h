//
//  JYTimer.h
//  Test03
//
//  Created by IMO on 2021/5/13.
//
// NSTimer 由于依赖 Runloop，所以在计时上会有误差，并不是特别精确；
// GCD 定时器不依赖 Runloop，计时精度要高很多

#import <Foundation/Foundation.h>

typedef void(^JYTimerBlock)(void);

@interface JYTimer : NSObject

/// 创建一个基于 GCD 的定时器，默认挂起，需要手动开启
/// @param interval 重复时间间隔
/// @param repeat 是否重复
/// @param completion 事件回调
+ (instancetype)timerWithInterval:(NSTimeInterval)interval
                           repeat:(BOOL)repeat
                       completion:(JYTimerBlock)completion;

/// 开始和继续定时器
- (void)resumeTimer;

/// 终止定时器
- (void)invalidTimer;

/// 暂停定时器
- (void)pauseTimer;

@end
