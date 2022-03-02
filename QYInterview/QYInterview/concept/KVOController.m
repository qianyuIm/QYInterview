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
NSString *const kSonKVOKey = @"SonKVOKey";

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

@interface KVOPersion : NSObject
@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *sex;
@property (nonatomic, readonly,copy) NSString *sex;

@end

@implementation KVOPersion
- (void)setNilValueForKey:(NSString *)key {
    NSLog(@"key ======== %@",key);
}
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:@"name"]) {
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}
// 使用 readonly 修饰的话 需要手动设置setter方法，才能使用.语法赋值
//- (void)setSex:(NSString *)sex {
//    _sex = sex;
//}

- (void)setName:(NSString *)name {
    [self willChangeValueForKey:@"name"];
    _name = name;
    [self didChangeValueForKey:@"name"];
}

@end
struct ThreeFloats {
    CGFloat one;
    CGFloat two;
    CGFloat three;
};



@interface KVOSon : KVOPersion
@property (nonatomic, assign) struct ThreeFloats floats;
@property (nonatomic, copy) NSString *hahaah;
@end

@implementation KVOSon
+ (BOOL)accessInstanceVariablesDirectly {
    return  YES;
}
@end

@interface KVOSon (KVO)
@property (nonatomic, copy) NSString *kvoString;

@end

@implementation KVOSon (KVO)
- (void)setKvoString:(NSString *)kvoString {
    objc_setAssociatedObject(self, (__bridge const void *)(kSonKVOKey), kvoString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)kvoString {
    return objc_getAssociatedObject(self, (__bridge const void *)(kSonKVOKey));
}

@end
@interface KVOController ()
@property (nonatomic, strong) KVOPersion *persion;
@property (nonatomic, strong) KVOSon *son;

@property (nonatomic, strong) NSMutableArray *propertyArray;
@end

@implementation KVOController
/* 实现原理:
 * 当你观察一个对象时，一个新的类会动态被创建。这个类继承自该对象的原本的类，并重写了被观察属性的 setter 方法。自然，重写的 setter 方法会负责在调用原 setter方法之前和之后，通知所有观察对象值的更改。最后把这个对象的 isa 指针 ( isa 指针告诉 Runtime 系统这个对象的类是什么 ) 指向这个新创建的子类，对象就神奇的变成了新创建的子类的实例。
 *  KVO 动态生成的类，重写Setter方法的前提是：原来的类中，要有对应的setter方法,即使readonly修饰，
 * 只要在.m中手写对应的setter方法，都是可以的，
 * 但是如果readonly修饰且没有手写对应Setter方法，KVO不起作用
 虽然ios 9.0 之后可以不移除观察者了，
 但不移除观察者，存在隐患，如果观察者已经销毁了，被观察的对象没有销毁，
 然后又产生了KVO message，这时候就抛异常了，EXC_BAD_ACCESS
 
 比如一个单例对象在首页和二级页面同时对一个属性添加观察者，在二级页面返回时不移除观察者，导致了二级页面释放，但是被观察的单例对象没有被释放，这时候在首页再次触发KVO，就会导致EXC_BAD_ACCESS 坏内存访问
 所以还是应该有添加就有移除,但也不能过渡移除，否则爆错
 Cannot remove an observer <xxx> for the key path \"xxx\" from <TCJStudent 0x6000018e8140> because it is not registered as an observer
 
 移除观察者后动态子类会被销毁吗？不会。
 那在什么时候移除呢？
 *
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"自己实现KVO");
    self.view.backgroundColor = [UIColor whiteColor];
    _persion = [[KVOPersion alloc] init];
    _son = [[KVOSon alloc] init];
//    [self testReadonly];
//    struct ThreeFloats flo = {1,2,3};
//    NSValue *value = [NSValue valueWithBytes:&flo objCType:@encode(struct ThreeFloats)];
//    KVOSon *son = [[KVOSon alloc] init];
//    [son setValue:value forKey:@"floats"];
//    NSLog(@"%@-%@", [son valueForKey:@"floats"], [[son valueForKey:@"floats"] class]);
//    [self testSuper];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"keyPath = %@, change = %@ ",keyPath, change);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
//    _persion.sex = @"xiao ming";
//    _son.sex = @"xiao ming";

//    [_son setValue:@"xiaoming" forKey:@"isSex"];
//    NSLog(@"%@",_son.sex);
    [_son addObserver:self forKeyPath:@"kvoString" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:NULL];
    // 没有实现的setter的话，只能通过kvc方式获取
    [_son setValue:@"kvc设值" forKey:@"kvoString"];

    _son.kvoString = @"属性设值";
    NSLog(@"%@",_son.kvoString);
    
    
}
- (void)testSuper {
    _son = [[KVOSon alloc] init];
//    [_son addObserver:self forKeyPath:@"isSex" options:(NSKeyValueObservingOptionNew) context:NULL];
//    [_son addObserver:_persion forKeyPath:@"isSex" options:(NSKeyValueObservingOptionNew) context:NULL];

    
}
- (void)testCustom {
    _persion = [[KVOPersion alloc] init];
    [_persion qy_addObserver:self forKey:@"sex" callBack:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
        NSLog(@"observedObject = %@, observedKey = %@ ,oldValue = %@ ,newValue = %@",observedObject, observedKey, oldValue,newValue );
    }];
    [self log:"KVOPersion"];
    [self log:"QYKVOClassPrefix_KVOPersion"];
}
- (void)testReadonly {
    _persion = [[KVOPersion alloc] init];
    [_persion addObserver:self forKeyPath:@"sex" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self log:"KVOPersion"];
    [self log:"NSKVONotifying_KVOPersion"];
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
