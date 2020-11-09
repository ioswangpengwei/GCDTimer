//
//  GCGTimer.h
//  GCDTimer
//
//  Created by MacW on 2020/11/9.
//

#import <Foundation/Foundation.h>

typedef void(^CGDBlcok)(void);

NS_ASSUME_NONNULL_BEGIN

@interface GCDTimer : NSObject


+(GCDTimer *)scheduledTimerWithFireInterval:(NSTimeInterval)fireInterval timeInterval:(NSTimeInterval)timerInterval blcok:(CGDBlcok)blcok;

+ (GCDTimer *)timerWithFireInterval:(NSTimeInterval)fireInterval interval:(NSTimeInterval)interval block:(CGDBlcok)block;

-(void)fireTimer;

-(void)supendTimer;

-(void)invalidate;

@end

NS_ASSUME_NONNULL_END
