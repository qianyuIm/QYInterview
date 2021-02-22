//
//  KVOController.m
//  QYInterview
//
//  Created by cyd on 2021/1/15.
//

#import "KVOController.h"
#import <objc/runtime.h>
#import <objc/message.h>

typedef void (^QYKVOObserverBlock) (id observedObject, NSString *observedKey, id oldValue, id newValue);
NSString *const kQYKVOClassPrefix = @"QYKVOClassPrefix_";
NSString *const kQYKVOAssociatedObservers = @"QYKVOAssociatedObservers";

@interface QYKVOInfo : NSObject
@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) QYKVOObserverBlock block;
@end

@implementation QYKVOInfo

- (instancetype)initWithObserver:(NSObject *)observer
                             Key:(NSString *)key
                           block:(QYKVOObserverBlock)block
{
    self = [super init];
    if (self) {
        _observer = observer;
        _key = key;
        _block = block;
    }
    return self;
}

@end
@interface NSObject (KVOBlock)
- (void)qy_addObserver:(NSObject *)observer
                forKey:(NSString *)key
              callBack:(QYKVOObserverBlock)callBack;
- (void)qy_removeObserver:(NSObject *)observer forKey:(NSString *)key;
@end
static NSString * getterForSetter(NSString *setter) {
    if (setter.length <=0 || ![setter hasPrefix:@"set"] || ![setter hasSuffix:@":"]) {
        return nil;
    }
    // remove 'set' at the begining and ':' at the end
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *key = [setter substringWithRange:range];
    
    // lower case the first letter
    NSString *firstLetter = [[key substringToIndex:1] lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                       withString:firstLetter];
    
    return key;
}
/// 通过get字符串获取set字符串
/// @param getter 字符串
static NSString* setterForGetter(NSString* getter) {
    if (getter.length <= 0) {
        return  nil;
    }
    // 将首字母大写
    NSString *firstLetter = [[getter substringToIndex:1] uppercaseString];
    NSString *remainingLetters = [getter substringFromIndex:1];
    // 获取set字符串
    NSString *setter = [NSString stringWithFormat:@"set%@%@:", firstLetter, remainingLetters];
    return  setter;
}
static Class kvo_class(id self, SEL _cmd) {
    return  class_getSuperclass(object_getClass(self));
}
static void kvo_setter(id self, SEL _cmd, id newValue)
{
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = getterForSetter(setterName);
    if (!getterName) {
        NSString *reason = [NSString stringWithFormat:@"Object %@ does not have setter %@", self, setterName];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
        return;
    }
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superclazz = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    // cast our pointer so the compiler won't complain
    void (*objc_msgSendSuperCasted)(void *, SEL, id) = (void *)objc_msgSendSuper;
    
    // call super's setter, which is original class's setter method
    objc_msgSendSuperCasted(&superclazz, _cmd, newValue);
    
    // look up observers and call the blocks
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(kQYKVOAssociatedObservers));
    for (QYKVOInfo *each in observers) {
        if ([each.key isEqualToString:getterName]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                each.block(self, getterName, oldValue, newValue);
            });
        }
    }
}


@implementation NSObject (KVOBlock)
- (void)qy_addObserver:(NSObject *)observer
            forKey:(NSString *)key
              callBack:(QYKVOObserverBlock)callBack {
    // 首先获取对应的set方法
    SEL setterSelector = NSSelectorFromString(setterForGetter(key));
    Method setterMethod = class_getInstanceMethod([self class], setterSelector);
    if (!setterMethod) {
        NSString *reason = [NSString stringWithFormat:@"Object %@ does not have a setter for key %@", self, key];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
        
        return;
    }
    // 获取当前的class
    Class clas = object_getClass(self);
    NSString *clasName = NSStringFromClass(clas);
    // 判断当前clas是否已经被KVO
    if (![clasName hasPrefix:kQYKVOClassPrefix]) {
        clas = [self makeKVOClassWithOriginalClassName:clasName];
        // 将一个对象设置为别的类类型，返回原来的Class
        object_setClass(self, clas);
    }
    // 如果这个类(不是超类)没有实现setter，添加我们的kvo setter?
    if (![self hasSelector:setterSelector]) {
        const char *types = method_getTypeEncoding(setterMethod);
        class_addMethod(clas, setterSelector, (IMP)kvo_setter, types);
    }
    QYKVOInfo *info = [[QYKVOInfo alloc] initWithObserver:observer Key:key block:callBack];
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(kQYKVOAssociatedObservers));
    if (!observers) {
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge const void *)(kQYKVOAssociatedObservers), observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [observers addObject:info];
}
- (void)qy_removeObserver:(NSObject *)observer
                   forKey:(NSString *)key {
    NSMutableArray* observers = objc_getAssociatedObject(self, (__bridge const void *)(kQYKVOAssociatedObservers));
    
    QYKVOInfo *infoToRemove;
    for (QYKVOInfo* info in observers) {
        if (info.observer == observer && [info.key isEqual:key]) {
            infoToRemove = info;
            break;
        }
    }
    [observers removeObject:infoToRemove];
}
///将原来的类名转换成KVO类名
- (Class)makeKVOClassWithOriginalClassName:(NSString *)originalClazzName {
    NSString *kvoClazzName = [kQYKVOClassPrefix stringByAppendingString:originalClazzName];
    Class isKvoClas = NSClassFromString(kvoClazzName);
    if (isKvoClas) {
        return isKvoClas;
    }
    // kvoClas不存在，创建它
    Class originalClas = object_getClass(self);
    Class kvoClas = objc_allocateClassPair(originalClas, kvoClazzName.UTF8String, 0);
    // 获取类方法的签名，这样我们可以借用它
    Method clasMethod = class_getInstanceMethod(originalClas, @selector(class));
    const char *types = method_getTypeEncoding(clasMethod);
    class_addMethod(kvoClas, @selector(class), (IMP)kvo_class, types);
    
    objc_registerClassPair(kvoClas);
    return kvoClas;
}
- (BOOL)hasSelector:(SEL)selector
{
    Class clazz = object_getClass(self);
    unsigned int methodCount = 0;
    Method* methodList = class_copyMethodList(clazz, &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        SEL thisSelector = method_getName(methodList[i]);
        if (thisSelector == selector) {
            free(methodList);
            return YES;
        }
    }
    free(methodList);
    return NO;
}

@end

@interface KVOPersion : NSObject {
    @public NSString *_sex;
}
@property (nonatomic, copy) NSString *name;
@end

@implementation KVOPersion
- (void)setName:(NSString *)name {
    _name = @"heheda";
    NSLog(@"name = %@",name);
}
@end

@interface KVOController ()
@property (nonatomic, strong) KVOPersion *persion;

@end

@implementation KVOController
/* 实现原理:
 *
 *
 *
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"自己实现KVO");
    self.view.backgroundColor = [UIColor whiteColor];
    _persion = [[KVOPersion alloc] init];
    [_persion qy_addObserver:self forKey:@"name" callBack:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
        NSLog(@"observedObject = %@, observedKey = %@ ,oldValue = %@ ,newValue = %@",observedObject, observedKey, oldValue,newValue );
    }];
    _persion.name = @"123";
    
//    [_persion addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"keyPath = %@, change = %@ ",keyPath, change);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    _persion.name = @"xiao ming";
}

@end
