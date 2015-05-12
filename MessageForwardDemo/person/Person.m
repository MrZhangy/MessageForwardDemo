//
//  Person.m
//  消息转发Demo
//
//  Created by zhangyafeng on 15/5/12.
//  Copyright (c) 2015年 think. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "Car.h"

@implementation Person

#pragma mark 消息转发方式1
void run(id self,SEL _cmd) {
    NSLog(@"%@ %s", self, sel_getName(_cmd));
}
+(BOOL)resolveInstanceMethod:(SEL)sel
{
    /*
    if(sel == @selector(run)) {
        class_addMethod(self, sel, (IMP)run, "v@:");
        return YES;
    }
    */
    return [super resolveInstanceMethod:sel];
}

+(BOOL)resolveClassMethod:(SEL)sel
{
    return [super resolveClassMethod:sel];
}

#pragma mark 消息转发方式2
//-(id)forwardingTargetForSelector:(SEL)aSelector
//{
//    return [[Car alloc] init];
//}

#pragma mark 消息转发方式3
-(NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector
{
    NSString *sel = NSStringFromSelector(aSelector);
    //判断你要转发的SEL
    if([sel isEqualToString:@"run"]) {
        //为你的转发方法手动生成签名
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}
-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL selector = [anInvocation selector];
    //新建需要转发消息的对象
    Car *car = [[Car alloc] init];
    if ([car respondsToSelector:selector]) {
        //唤醒这个方法
        [anInvocation invokeWithTarget:car];
    }
}




@end
