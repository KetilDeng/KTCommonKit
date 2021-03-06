//
//  KTNavigationController.h
//  myDemo
//
//  Created by Ketao Deng on 2019/7/25.
//  Copyright © 2019 Ketil. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface KTNavigationController : UINavigationController

@property (nonatomic, strong) UIImage *backButtonImage;
/** 是否开启全屏滑动返回功能（开启之后，则禁用系统边缘滑动返回） */
@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;
/** 是否取消滑动返回功能（取消之后，全屏滑动返回、系统边缘滑动返回 都将禁用） */
@property (nonatomic, assign) BOOL interactivePopDisabled;
//The current view controller stack.
//self.navigationController.viewControllers -> self.navigationController.kt_viewControllers
@property (nonatomic, copy, readonly) NSArray *kt_viewControllers;

@end




@interface KTWrapNavigationController : UINavigationController

@end




@interface KTWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (KTWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end




@interface UIViewController (KTNavigationExtension)

@property (nonatomic, assign) BOOL kt_fullScreenPopGestureEnabled;

@property (nonatomic, assign) BOOL kt_interactivePopDisabled;

@property (nonatomic, weak) KTNavigationController *kt_navigationController;

@end



NS_ASSUME_NONNULL_END
