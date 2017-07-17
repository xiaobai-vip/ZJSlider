//
//  ViewController.m
//  ZJSlider
//
//  Created by 张俊 on 17/7/17.
//  Copyright © 2017年 zjhcsoftios. All rights reserved.
//

#import "ViewController.h"
#import "ZJSliderView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ZJSliderView *slider = [[ZJSliderView alloc] initWithFrame:CGRectMake(20, 80, 200, 33)];
    slider.currentScore = @"3";
//    __weak typeof(self) weakself = self;
    slider.returnScoreBlock = ^(NSString *score){
        NSLog(@"%@星",score);
    };
    [self.view addSubview:slider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
