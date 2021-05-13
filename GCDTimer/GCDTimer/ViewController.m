//
//  ViewController.m
//  GCDTimer
//
//  Created by IMO on 2021/5/13.
//

#import "ViewController.h"
#import "JYTimer.h"

@interface ViewController ()

@property (nonatomic, strong) JYTimer *timer;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    __block int a = 0;
    JYTimer *timer = [JYTimer timerWithInterval:1.0 repeat:YES completion:^{
        a++;
        NSLog(@"%d", a);
    }];
    
    self.timer = timer;
    
    [self setupUI];
}

- (void)setupUI {
    UIButton *btn = [UIButton new];
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 90, 100, 80);
    btn.backgroundColor = [UIColor systemBlueColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [UIButton new];
    [btn1 setTitle:@"终止" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(10, 190, 100, 80);
    btn1.backgroundColor = [UIColor systemBlueColor];
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(invalid:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton new];
    [btn2 setTitle:@"暂停" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(10, 290, 100, 80);
    btn2.backgroundColor = [UIColor systemBlueColor];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(pause:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Event
- (void)start:(UIButton *)btn {
    [self.timer resumeTimer];
}

- (void)invalid:(UIButton *)btn {
    [self.timer invalidTimer];
}

- (void)pause:(UIButton *)btn {
    [self.timer pauseTimer];
}

@end
