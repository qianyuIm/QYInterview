//
//  TaggedPointerController.m
//  QYInterview
//
//  Created by cyd on 2021/4/6.
//

#import "TaggedPointerController.h"

@interface TaggedPointerController ()
@property (nonatomic, strong) NSString *name;
@end

@implementation TaggedPointerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self testStringMax];
}
- (void)testString {
    NSString *str1 = [NSString stringWithFormat:@"abcd"];
    NSString *str2 = [NSString stringWithFormat:@"abcdabcdabcdabcdabcdabcd"];
    NSString *str3 = [NSString stringWithFormat:@"1234"];

    NSLog(@"%@ - %@ - %@",[str1 class], [str2 class], [str3 class]);

    NSLog(@"%p - %p - %p",str1, str2, str3);
    
}
- (void)testString1 {
    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);
    for (int index = 0; index < 100; index++) {
        dispatch_async(queue1, ^{
            self.name = [NSString stringWithFormat:@"123123123123123123123123123123123123"];
            NSLog(@"我来了1");
        });
    }
    dispatch_queue_t queue2 = dispatch_get_global_queue(0, 0);
    for (int index = 0; index < 100; index++) {
        dispatch_async(queue2, ^{
            self.name = [NSString stringWithFormat:@"abcd"];
            NSLog(@"我来了2");
        });
    }
    dispatch_queue_t queue3 = dispatch_queue_create("com", DISPATCH_QUEUE_CONCURRENT);

    dispatch_barrier_async(queue3, ^{
        NSLog(@"%@",self.name);
    });
}
- (void)testStringMax {
//    NSMutableString *string2 = [NSMutableString stringWithString:@"1"];
//    for( int i = 0; i < 14; i++){
//        NSString *strFor = [[string2 mutableCopy] copy];
//        NSLog(@"%@: %p---%p==%@", [strFor class], strFor, &strFor, strFor);
//        [string2 appendString:@"1"];
//    }
    for( int i = 0; i < 14; i++){
        NSNumber *number = [NSNumber numberWithInt:i];
        NSLog(@"%@: %p---%p==%@", [number class], number, &number, number);
        
    }
    
}
@end
