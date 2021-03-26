//
//  KVCController.m
//  QYInterview
//
//  Created by cyd on 2021/3/26.
//

#import "KVCController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface KVCPersion : NSObject{
    @public
    NSString *_name;
}
@property (nonatomic, copy) NSString *name;
@end

@implementation KVCPersion
+ (BOOL)accessInstanceVariablesDirectly {
    return  YES;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"未找到%@",key);
}

//- (void)set_name:(NSString *)name {
//    _name = name;
//}
@end

@interface KVCController ()
@property (nonatomic, strong) KVCPersion *persion;
@property (nonatomic, copy) NSString *name;

@end

@implementation KVCController
// xcrun -sdk iphonesimulator clang -arch x86_64 -rewrite-objc KVCController.m 查看 _persion->_name
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _persion = [[KVCPersion alloc] init];
    [self addObserver:self forKeyPath:@"_name" options:NSKeyValueObservingOptionNew context:NULL];
    _name = @"456";
//    [self log:"KVCController"];
//    [self log:"NSKVONotifying_KVCController"];
    
    NSLog(@"%lu",sizeof(BOOL));
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@ == %@",keyPath, change);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    //
    [self setValue:@"123" forKey:@"_name"];
 
//    _persion->_name = @"123";
    // 查找setter 方法
//    [_persion setValue:@"xiaoming1" forKey:@"name"];
    // 查找成员变量
//    [_persion setValue:@"xiaoming2" forKey:@"_name"];
//    [_persion setValue:@"xiaoming3" forKey:@"_isName"];
//    [_persion setValue:@"xiaoming4" forKey:@"isName"];
//    [self log:"KVCController"];
//    [self log:"NSKVONotifying_KVCPersion"];

//    NSLog(@"%@",_persion->_name);
}
- (void)log:(const char *)className {
    Class logClass = objc_getClass(className);
    unsigned int methodCount =0;
    Method* methodList = class_copyMethodList(logClass,&methodCount);
    NSMutableArray *methodsArray = [NSMutableArray arrayWithCapacity:methodCount];
    for(int i=0;i<methodCount;i++) {
        Method temp = methodList[i];
        const char* name_s =sel_getName(method_getName(temp));
        [methodsArray addObject:[NSString stringWithUTF8String:name_s]];
    }
    NSLog(@"%@",methodsArray);
}
@end
