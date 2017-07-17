//
//  ZJSliderView.h
//  MobileApplicationPlatform
//
//  Created by 张俊 on 16-1-11.
//  Copyright (c) 2016年 HCMAP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
typedef void (^ReturnScoreBlock)(NSString *score);

@interface ZJSliderView : UIView
{
    CGContextRef context;
    float leftOff;
    float rightOff;
    float groupAreaWidth;
    NSArray *scoreArr;
    CGRect sizeRect;
    float touchindex;
    NSMutableArray *linespointarray;
    BOOL isFirst;
    UITouch *curTouch;
    float xoffet;
}

@property (strong,nonatomic) NSString *currentScore;
@property (nonatomic, copy) ReturnScoreBlock returnScoreBlock;
@end
