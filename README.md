# 前言
首先, push/pop 动效在iOS7.0以后系统就已经提供了相关的代理方法, 在代理方法中我们可以自定义切换动画. 
自定义push,pop动画是由UINavigationController的代理方法中提供的.
用于实现自定义动画的代理(UINavigationControllerDelegate)方法如下:

```
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0);

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);
```

# 1. 实现自定义push,pop动画
一般的自定义动画通过`navigationController:animationControllerForOperation:fromViewController:toViewController:`这个代理方法实现, 这个代理方法返回`id<UIViewControllerAnimatedTransitioning>`类型的对象, 也就是说, 只需要定义好实现`UIViewControllerAnimatedTransitioning `协议的一个类即可.

### 1. UIViewControllerAnimatedTransitioning协议

UIViewControllerAnimatedTransitioning协议定义如下所示, 不解释:

```
@protocol UIViewControllerAnimatedTransitioning <NSObject>

// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation. 
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext;
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext;

@optional

// This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
- (void)animationEnded:(BOOL) transitionCompleted;

@end
```

代码中实现这个协议时候思路是这样的, 整体上是继承的结构, 因为动画具体的动效效果可能有n种, 但是基本方法和判断都是相同的. 父类遵循协议并实现如上的几个代理, 父类实现几个类方法来快速创建对象, 并提供其它初始化方法; 父类完成基本的逻辑判断和方法调用, 子类继承父类, 具体实现动效效果. 由于Objective-C中没有抽象方法, 例子在父类中声明方法, 空实现, 子类重写父类相关的方法. 父类如下所示:

**WHBaseAnimationTransitioning.h**

```
#import <UIKit/UIKit.h>
#import "UIViewController+WHAnimationTransitioningSnapshot.h"

@interface WHBaseAnimationTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong, readwrite) UIPercentDrivenInteractiveTransition *interactivePopTransition;

/// 创建动画效果的实例对象并设置动画类型, push or pop
+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType;

/// 创建动画效果的实例对象并设置动画类型和间隔时间
+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType duration:(NSTimeInterval)duration;

/// 创建动画效果实例对象并设置动画类型/间隔时间/可交互属性
+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType duration:(NSTimeInterval)duration interactivePopTransition:(UIPercentDrivenInteractiveTransition *)interactivePopTransition;

- (instancetype)initWithType:(UINavigationControllerOperation)transitionType duration:(NSTimeInterval)duration;

#pragma mark - 真正实现 push, pop 动画的方法, 具体实现交给子类
- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext;

- (void)pushEnded;
- (void)popEnded;

@end
```

**WHBaseAnimationTransitioning.m**

```
#import "WHBaseAnimationTransitioning.h"

/// 默认动画执行时间间隔
const static NSTimeInterval WHAnimationTransitioningDuration = 0.6;

@interface WHBaseAnimationTransitioning ()

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) UINavigationControllerOperation transitionType;

@end

@implementation WHBaseAnimationTransitioning

- (instancetype)init {

    if (self = [self initWithType:UINavigationControllerOperationPush duration:WHAnimationTransitioningDuration]) {
    }
    return self;
}

// 主要的构造方法
- (instancetype)initWithType:(UINavigationControllerOperation)transitionType duration:(NSTimeInterval)duration {

    if (self = [super init]) {
        self.duration = duration;
        self.transitionType = transitionType;
    }
    return self;
}

+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType {

    return [self transitionWithType:transitionType duration:WHAnimationTransitioningDuration];
}

+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType
                          duration:(NSTimeInterval)duration {

    return [self transitionWithType:transitionType duration:duration interactivePopTransition:nil];
}

+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType duration:(NSTimeInterval)duration interactivePopTransition:(UIPercentDrivenInteractiveTransition *)interactivePopTransition {

    WHBaseAnimationTransitioning *animationTransitioning = [[self alloc] initWithType:transitionType duration:duration];
    animationTransitioning.interactivePopTransition = interactivePopTransition;
    return animationTransitioning;
}

- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext {}
- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {}
- (void)pushEnded {}
- (void)popEnded {}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {

    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    if (self.transitionType == UINavigationControllerOperationPush) {
        [self push:transitionContext];
    }
    else if (self.transitionType == UINavigationControllerOperationPop) {
        [self pop:transitionContext];
    }
}

- (void)animationEnded:(BOOL) transitionCompleted {

    if (!transitionCompleted) return;

    if (self.transitionType == UINavigationControllerOperationPush) {
        [self pushEnded];
    }
    else if (self.transitionType == UINavigationControllerOperationPop) {
        [self popEnded];
    }
}

@end
```

### 2. 具体实现动画
动画效果如下:

![](http://7xrn7f.com1.z0.glb.clouddn.com/16-6-17/46613857.jpg)

代码如下:

```
#import "WHBaseAnimationTransitioning.h"

@interface WHBackPriorViewAnimation : WHBaseAnimationTransitioning

@end

@implementation WHBackPriorViewAnimation

- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    CGRect bounds = [[UIScreen mainScreen] bounds];
    fromVc.view.hidden = YES;
    [[transitionContext containerView] addSubview:fromVc.snapshot];
    [[transitionContext containerView] addSubview:toVc.view];
    [[toVc.navigationController.view superview] insertSubview:fromVc.snapshot belowSubview:toVc.navigationController.view];
    toVc.navigationController.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(bounds), 0.0);

    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromVc.snapshot.alpha = 0.3;
                         fromVc.snapshot.transform = CGAffineTransformMakeScale(0.965, 0.965);
                         toVc.navigationController.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
                     }
                     completion:^(BOOL finished) {
                         fromVc.view.hidden = NO;
                         [fromVc.snapshot removeFromSuperview];
                         [toVc.snapshot removeFromSuperview];
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    CGRect bounds = [[UIScreen mainScreen] bounds];

    [fromVc.view addSubview:fromVc.snapshot];
    fromVc.navigationController.navigationBar.hidden = YES;
    fromVc.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);

    toVc.view.hidden = YES;
    toVc.snapshot.alpha = 0.3;
    toVc.snapshot.transform = CGAffineTransformMakeScale(0.965, 0.965);

    [[transitionContext containerView] addSubview:toVc.view];
    [[transitionContext containerView] addSubview:toVc.snapshot];
    [[transitionContext containerView] sendSubviewToBack:toVc.snapshot];

    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.1f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromVc.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(bounds), 0.0);
                         toVc.snapshot.alpha = 1.0;
                         toVc.snapshot.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {

                         toVc.navigationController.navigationBar.hidden = NO;
                         toVc.view.hidden = NO;

                         [fromVc.snapshot removeFromSuperview];
                         [toVc.snapshot removeFromSuperview];
                         fromVc.snapshot = nil;

                         // Reset toViewController's `snapshot` to nil
                         if (![transitionContext transitionWasCancelled]) {
                             toVc.snapshot = nil;
                         }

                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
```

到此为止, 已经成功实现自定义push, pop动画.

# 2. 实现可交互的pop动画
交互式的动画, 这个概念太大, 这里介绍的是使用手势pop动画的实现过程.

### 1. 动画效果
动画效果如下所示:

![](http://7xrn7f.com1.z0.glb.clouddn.com/16-6-17/50577509.jpg)

### 2. 实现过程
手势pop动画, 主要是要监听手势变化, 然后根据手势变化更新动画. 我的实现思路是, 在BaseViewController中给控制器添加手势并监听, 如果是右滑则开始执行pop动画, 具体代码如下所示:

```
// 判断是否是根控制器 并添加手势
if (self.navigationController != nil && self != self.navigationController.viewControllers.firstObject) {
        UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
        [self.view addGestureRecognizer:popRecognizer];
        popRecognizer.delegate = self;
    }

#pragma mark - UIPanGestureRecognizer handlers
// 实现监听手势变化的代理方法
- (void)handlePopRecognizer:(UIPanGestureRecognizer *)recognizer {

    CGFloat progress = [recognizer translationInView:self.view].x / CGRectGetWidth(self.view.frame);
    progress = MIN(1.0, MAX(0.0, progress));

    if (recognizer.state == UIGestureRecognizerStateBegan) {

        // Create a interactive transition and pop the view controller
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];

        [self.navigationController popViewControllerAnimated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {

        // Update the interactive transition's progress
        [self.interactivePopTransition updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {

        // Finish or cancel the interactive transition
        if (progress > 0.25) {
            [self.interactivePopTransition finishInteractiveTransition];
        } else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }

        self.interactivePopTransition = nil;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)recognizer {
    return [recognizer velocityInView:self.view].x > 0;
}
```

BaseViewController中实现以上方法即可, 要想实现侧滑功能, 还需要实现NAVi的一个代理方法:`navigationController:interactionControllerForAnimationController:`, 在这个代理方法中返回遵循`UIViewControllerInteractiveTransitioning`协议的对象即可. 

```
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(WHBaseAnimationTransitioning *) animationController  {

    return animationController.interactivePopTransition;
}
```

至此, 手势实现pop效果已经实现完毕, 如有任何疑问, 欢迎交流. 

另有其它几种动效效果, 详见github源码.

如果您觉得本文有用, 欢迎star支持一下 😃 . 

**源码地址:** https://github.com/hell03W/SwitchControllerAnimation

# 后记

博文作者：hell03W

博文出处: http://my.oschina.net/whforever

github: https://github.com/hell03W

oschina: http://my.oschina.net/whforever

jianshu: http://www.jianshu.com/users/ea059360a6f6

本文版权归作者，欢迎转载，但须保留此段声明，并给出原文链接，谢谢合作！