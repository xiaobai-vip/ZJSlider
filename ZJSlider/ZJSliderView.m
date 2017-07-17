//
//  ZJSliderView.m
//  MobileApplicationPlatform
//
//  Created by 张俊 on 16-1-11.
//  Copyright (c) 2016年 HCMAP. All rights reserved.
//

#import "ZJSliderView.h"
#import "UIColor+Extension.h"

@implementation ZJSliderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        leftOff = 15;
        rightOff = 15;
        isFirst = YES;
        [self setNeedsDisplay];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    scoreArr = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    if (isFirst) {
        //第一次进来默认显示当前星数
        touchindex = [_currentScore intValue] -1;
        self.returnScoreBlock([scoreArr objectAtIndex:touchindex]);
    }
    else{
        touchindex = [self getCompareNumber:curTouch];
        if (touchindex == -1) {
            touchindex = 0;
        }
        else if (touchindex == -2){
            touchindex = scoreArr.count -1;
        }
        self.returnScoreBlock([scoreArr objectAtIndex:touchindex]);
    }

    linespointarray = [[NSMutableArray alloc] init];
    context = UIGraphicsGetCurrentContext();
    sizeRect = rect;
    
    leftOff = 15;
    rightOff = 15;
    groupAreaWidth = rect.size.width - leftOff - rightOff;
    [[UIColor colorWithHexString:@"#51afe6"] set];
    float x = 0;
    float y = 0;
    isFirst = YES;
    x = leftOff;
    y = rect.size.height/2;
    xoffet = (rect.size.width - leftOff - rightOff) / (scoreArr.count - 1);
    [linespointarray addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
    CGContextMoveToPoint(context, x, y);
    for (int i = 1; i < touchindex + 1; i++) {
        x = leftOff + xoffet*i;
        CGContextSetLineWidth(context, 2.0);
        CGContextAddLineToPoint(context, x, y);
        [linespointarray addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
    }
    CGContextStrokePath(context);
    
    [[UIColor colorWithHexString:@"#d9d9d9"] set];
    CGContextMoveToPoint(context, x, y);
    for (int j =touchindex + 1; j <= scoreArr.count; j++) {
        x = leftOff + xoffet*(j-1);
        CGContextSetLineWidth(context, 2.0);
        CGContextAddLineToPoint(context, x, y);
        [linespointarray addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
    }
    CGContextStrokePath(context);
    [self drawDisplay:context];
    isFirst = NO;
}

- (void)drawDisplay:(CGContextRef)contextref{
    for (int i = 0; i < touchindex; i++) {
        CGPoint point = [[linespointarray objectAtIndex:i] CGPointValue];
        CGRect rect = CGRectMake(point.x-4, point.y-4, 8, 8);
        CGContextAddEllipseInRect(contextref, rect);
        CGContextSetFillColorWithColor(contextref, ([UIColor colorWithHexString:@"#51afe6"]).CGColor);
        CGContextFillPath(contextref);
    }
    for (int j = touchindex; j < linespointarray.count; j++) {
        CGPoint point = [[linespointarray objectAtIndex:j] CGPointValue];
        CGRect rect = CGRectMake(point.x-4, point.y-4, 8, 8);
        CGContextAddEllipseInRect(contextref, rect);
        CGContextSetFillColorWithColor(contextref, ([UIColor colorWithHexString:@"#d9d9d9"]).CGColor);
        CGContextFillPath(contextref);
    }
    UIImage *starImage = [UIImage imageNamed:@"Party_star"];
    CGSize size = CGSizeMake(24, 25);
    CGPoint touchPoint = [[linespointarray objectAtIndex:touchindex] CGPointValue];
    [starImage drawInRect:CGRectMake(touchPoint.x-size.width/2.0, touchPoint.y-size.height/2.0, size.width, size.height)];
}

-(int)getCompareNumber:(UITouch *)touch{
    int result;
    if (([touch locationInView:self].x-leftOff)>groupAreaWidth) {
        result=-2;
    }else if ([touch locationInView:self].x<=leftOff) {
        result=-1;
    }else {
        if (scoreArr.count == 0) {
            return 0;
        }
        
        int xlas=([touch locationInView:self].x-leftOff)/xoffet;
        xlas=([touch locationInView:self].x-leftOff)-xoffet*xlas>xoffet/2.0?xlas+1.0:xlas;
        result=xlas;
    }
    return result;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    isTouchEnded = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TableViewScrollEnable" object:[NSNumber numberWithBool:NO]];
    curTouch = [touches anyObject];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    curTouch = [touches anyObject];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    isTouchEnded = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TableViewScrollEnable" object:[NSNumber numberWithBool:YES]];
}

@end
