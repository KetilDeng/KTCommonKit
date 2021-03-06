//
//  KTNavigationController.m
//  myDemo
//
//  Created by Ketao Deng on 2019/7/25.
//  Copyright © 2019 Ketil. All rights reserved.
//

#import "KTNavigationController.h"

#import <objc/runtime.h>

//图片请自行修改，此处一般使用自己项目的默认返回图片
NSString *const DefaultBackImageName = @"common_back_margin";

#pragma mark - UIViewController (KTNavigationExtension)

@implementation UIViewController (KTNavigationExtension)

- (void)setKt_fullScreenPopGestureEnabled:(BOOL)kt_fullScreenPopGestureEnabled
{
    objc_setAssociatedObject(self, @selector(kt_fullScreenPopGestureEnabled), @(kt_fullScreenPopGestureEnabled), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)kt_fullScreenPopGestureEnabled
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setKt_navigationController:(KTNavigationController *)kt_navigationController
{
    objc_setAssociatedObject(self, @selector(kt_navigationController), kt_navigationController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setKt_interactivePopDisabled:(BOOL)kt_interactivePopDisabled
{
    objc_setAssociatedObject(self, @selector(kt_interactivePopDisabled), @(kt_interactivePopDisabled), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)kt_interactivePopDisabled
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (KTNavigationController *)kt_navigationController
{
    return objc_getAssociatedObject(self, _cmd);
}

@end



#pragma mark - KTWrapNavigationController

@implementation KTWrapNavigationController

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    KTNavigationController *kt_navigationController = viewController.kt_navigationController;
    NSInteger index = [kt_navigationController.kt_viewControllers indexOfObject:viewController];
    return [self.navigationController popToViewController:kt_navigationController.viewControllers[index] animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    viewController.kt_navigationController = (KTNavigationController *)self.navigationController;
    viewController.kt_fullScreenPopGestureEnabled = viewController.kt_navigationController.fullScreenPopGestureEnabled;
    viewController.kt_interactivePopDisabled = viewController.kt_navigationController.interactivePopDisabled;
    UIImage *backButtonImage = viewController.kt_navigationController.backButtonImage;
    if (!backButtonImage) {
        backButtonImage = [UIImage imageNamed:DefaultBackImageName];
    }
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[backButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(didTapBackButton)];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[KTWrapViewController wrapViewControllerWithViewController:viewController] animated:animated];
}

- (void)didTapBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.kt_navigationController=nil;
}

@end





#pragma mark - KTWrapViewController

static NSValue *kt_tabBarRectValue;

@implementation KTWrapViewController

+ (KTWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController {
    
    KTWrapNavigationController *wrapNavController = [[KTWrapNavigationController alloc] init];
    wrapNavController.viewControllers = @[viewController];
    
    KTWrapViewController *wrapViewController = [[KTWrapViewController alloc] init];
    wrapViewController.view.backgroundColor = [UIColor whiteColor];
    [wrapViewController.view addSubview:wrapNavController.view];
    [wrapViewController addChildViewController:wrapNavController];
    
    return wrapViewController;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //    if (self.tabBarController && !kt_tabBarRectValue) {
    //        kt_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    //    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
    //        self.tabBarController.tabBar.frame = CGRectZero;
    //    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = YES;
    //    if (self.tabBarController && !self.tabBarController.tabBar.hidden && kt_tabBarRectValue) {
    //        self.tabBarController.tabBar.frame = kt_tabBarRectValue.CGRectValue;
    //    }
}

- (BOOL)kt_fullScreenPopGestureEnabled {
    return [self rootViewController].kt_fullScreenPopGestureEnabled;
}

- (BOOL)kt_interactivePopDisabled
{
    return [self rootViewController].kt_interactivePopDisabled;
}

- (BOOL)hidesBottomBarWhenPushed {
    return [self rootViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return [self rootViewController].tabBarItem;
}

- (NSString *)title {
    return [self rootViewController].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return [self rootViewController];
}

- (UIViewController *)rootViewController {
    KTWrapNavigationController *wrapNavController = self.childViewControllers.firstObject;
    return wrapNavController.viewControllers.firstObject;
}

@end









#pragma mark KTNavigationController
@interface KTNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;

@property (nonatomic, strong) id popGestureDelegate;

@end

@implementation KTNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        rootViewController.kt_navigationController = self;
        self.viewControllers = @[[KTWrapViewController wrapViewControllerWithViewController:rootViewController]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.viewControllers.firstObject.kt_navigationController = self;
        self.viewControllers = @[[KTWrapViewController wrapViewControllerWithViewController:self.viewControllers.firstObject]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationBarHidden:YES];
    self.delegate = self;
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.popGestureDelegate action:action];
    self.popPanGesture.maximumNumberOfTouches = 1;
    self.popPanGesture.delegate = self;
}


#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    
    if (viewController.kt_interactivePopDisabled)
    {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    else
    {
        if (viewController.kt_fullScreenPopGestureEnabled)
        {
            if (isRootVC) {
                [self.view removeGestureRecognizer:self.popPanGesture];
            } else {
                [self.view addGestureRecognizer:self.popPanGesture];
            }
            self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
            self.interactivePopGestureRecognizer.enabled = NO;
        }
        else
        {
            [self.view removeGestureRecognizer:self.popPanGesture];
            self.interactivePopGestureRecognizer.delegate = self;
            self.interactivePopGestureRecognizer.enabled = !isRootVC;
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [self.popPanGesture translationInView:self.view];
    if (point.x <= 0) { //当滑动是向右滑的时候，不可滑动
        return NO;
    }
    return YES;
}

/** return YES 修复有水平方向滚动的ScrollView时边缘返回手势失效的问题 */
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - Getter
- (NSArray *)kt_viewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (KTWrapViewController *wrapViewController in self.viewControllers) {
        [viewControllers addObject:wrapViewController.rootViewController];
    }
    return viewControllers.copy;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
