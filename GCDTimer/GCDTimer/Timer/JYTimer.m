//
//  JYTimer.m
//  Test03
//
//  Created by IMO on 2021/5/13.
//

#import "JYTimer.h"

@interface JYTimer ()

// GCDTimer 需要强持有，否则出了作用域立即释放，也就没有了事件回调
@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, assign) BOOL isRuning;

@end

@implementation JYTimer

+ (JYTimer *)timerWithInterval:(NSTimeInterval)interval repeat:(BOOL)repeat completion:(JYTimerBlock)completion {
    JYTimer *timer = [[JYTimer alloc] initWithInterval:interval repeat:repeat completion:completion];
    return timer;
}

- (instancetype)initWithInterval:(NSTimeInterval)interval repeat:(BOOL)repeat completion:(JYTimerBlock)completion {
    if (self = [super init]) {
        self.isRuning = NO;
        
        // 初始化 timer
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
        
        // 设置 timer 的首次执行时间，间隔，精确度
        dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, interval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        
        // 设置 timer 事件回调
        __weak typeof(self) weakSelf = self;
        dispatch_source_set_event_handler(self.timer, ^{
            if (completion) {
                completion();
            }
            
            if (!repeat) {
                dispatch_source_cancel(weakSelf.timer);
                weakSelf.isRuning = NO;
                weakSelf.timer = nil;
            }
        });
    }
    return self;
}

- (void)resumeTimer {
    if (self.timer && !self.isRuning) {
        dispatch_resume(self.timer);
        self.isRuning = YES;
    }
}

- (void)invalidTimer {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.isRuning = NO;
        self.timer = nil;
    }
}

- (void)pauseTimer {
    if (self.timer && self.isRuning) {
        dispatch_suspend(self.timer);
        self.isRuning = NO;
    }
}

@end
