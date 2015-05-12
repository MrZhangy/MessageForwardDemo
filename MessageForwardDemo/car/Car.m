//
//  Car.m
//  消息转发Demo
//
//  Created by zhangyafeng on 15/5/12.
//  Copyright (c) 2015年 think. All rights reserved.
//

#import "Car.h"
#import <objc/runtime.h>

@interface Car()

@end

@implementation Car

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
  return   [super resolveInstanceMethod:sel];
}
+ (BOOL)resolveClassMethod:(SEL)sel
{
    return  [super resolveInstanceMethod:sel];
}
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return [[Car alloc] init];
}

-(void)run
{
    NSLog(@"car run");
}
@end
