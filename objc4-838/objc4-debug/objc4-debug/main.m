//
//  main.m
//  objc4-debug
//
//  Created by anyhong on 2022/2/9.
//

#import <Foundation/Foundation.h>
#import "DSPersion.h"
#import <objc/runtime.h>

extern void _objc_autoreleasePoolPrint(void);
void testAutoreleasePool(void);
void testClass(void);
void testKindAndMember(void) ;
int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        testAutoreleasePool();
//        testClass();
        testKindAndMember();
    }
    return 0;
}
void testKindAndMember(void) {
    BOOL res1 = [[NSObject class] isKindOfClass:[NSObject class]];
    BOOL res2 = [[NSObject class] isMemberOfClass:[NSObject class]];
    BOOL res3 = [[DSPersion class] isKindOfClass:[DSPersion class]];
    BOOL res4 = [[DSPersion class] isMemberOfClass:[DSPersion class]];
    NSLog(@"%d -- %d -- %d -- %d",res1,res2,res3,res4);
}
void testAutoreleasePool(void) {
    for (int i = 0; i < 4; i++) {
//            DSPersion *objc = [DSPersion persion];
        NSString *str = @"212121212121212";
        [str stringByAppendingString:@"34"];
    }
    _objc_autoreleasePoolPrint();
}
void testClass(void) {
    DSPersion *persion = [[DSPersion alloc] init];
    NSLog(@"类对象%p",[persion class]);
    NSLog(@"类对象%p",object_getClass(persion));
    NSLog(@"类对象%p",[DSPersion class]);
    NSLog(@"元类对象%p",object_getClass([DSPersion class]));

}
