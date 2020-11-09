//
//  ViewController.m
//  GCDTimer
//
//  Created by MacW on 2020/11/9.
//

#import "ViewController.h"
#import "GCDTimer.h"

@interface ViewController ()

@property (nonatomic, strong) GCDTimer *timer;

@property (nonatomic, strong) GCDTimer *secondTimer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __block int count;
    self.timer = [GCDTimer timerWithFireInterval:5 interval:2 block:^{
        count++;
        NSLog(@"%d",count);
//        if (count >5) {
//            [self.timer invalidate];
//        }
    }];
    [self.timer fireTimer];

    [self secondTimer2];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static int testInt = 0;
    testInt++;
    if (testInt%2 == 1) {
        [self.timer supendTimer];

    } else {
        [self.timer fireTimer];
    }
}
-(void)secondTimer2 {
    __block int secondCount = 0;
    self.secondTimer = [GCDTimer scheduledTimerWithFireInterval:0 timeInterval:1 blcok:^{
        
            secondCount++;
            NSLog(@"第二个%d",secondCount);
            if (secondCount > 5) {
                [self.secondTimer invalidate];
            }
        
    }];
    
}
@end
