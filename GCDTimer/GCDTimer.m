//
//  GCGTimer.m
//  GCDTimer
//
//  Created by MacW on 2020/11/9.
//

#import "GCDTimer.h"

@interface GCDTimer ()

@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, assign) NSTimeInterval fireInterval;

@property (nonatomic, assign) NSTimeInterval interval;

@property (nonatomic, copy) CGDBlcok myBlcok;

@end

@implementation GCDTimer

+(GCDTimer *)scheduledTimerWithFireInterval:(NSTimeInterval)fireInterval timeInterval:(NSTimeInterval)timerInterval blcok:(CGDBlcok)blcok {
    
    GCDTimer *gcdTimer =  [[GCDTimer alloc] initWithFireInterval:fireInterval interval:timerInterval block:blcok];;
    [gcdTimer fireTimer];
    return  gcdTimer;;

}

+ (GCDTimer *)timerWithFireInterval:(NSTimeInterval)fireInterval interval:(NSTimeInterval)interval block:(CGDBlcok)block {
    return  [[GCDTimer alloc] initWithFireInterval:fireInterval interval:interval block:block];;
}

-(instancetype)initWithFireInterval:(NSTimeInterval)fireInterval interval:(NSTimeInterval)interval block:(CGDBlcok)block {
    if (self = [super init]) {
        self.fireInterval = fireInterval;
        self.interval = interval;
        self.myBlcok = block;
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0    ));
        [self initTimer];
        
    }
    return self;
}
-(void)initTimer {
    double  delta = self.fireInterval > 1.0?self.fireInterval  :1.0;
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delta * NSEC_PER_SEC));
    
    dispatch_source_set_timer(self.timer, start,  (uint64_t)(self.interval * NSEC_PER_SEC), 0);
    dispatch_source_set_event_handler(self.timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.myBlcok) {
                self.myBlcok();
            }
        });
        
    });
    
}
-(void)fireTimer {
    
    dispatch_resume(self.timer);
}

-(void)supendTimer {
    dispatch_suspend(self.timer);
}

-(void)invalidate {
    
    dispatch_cancel(self.timer);
    self.timer = nil;
}
@end
