//
//  UICollectionView+MyHook.m
//  TabAnimationDemo
//
//  Created by wv on 2022/8/10.
//

#import "UICollectionView+MyHook.h"

@implementation UICollectionView (MyHook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(setDelegate:);
        SEL swizzledSelector = @selector(myhook_setDelegate:);

        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);

        BOOL didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)myhook_setDelegate:(id<UITableViewDelegate>)delegate {
    SEL originalSelector = @selector(collectionView:willDisplayCell:forItemAtIndexPath:);
    SEL swizzledSelector = @selector(myhook_collectionView:willDisplayCell:forItemAtIndexPath:);

    if ([delegate respondsToSelector:originalSelector]) {
        Class clz = [delegate class];

        Method originalMethod = class_getInstanceMethod(clz, originalSelector);
        Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);

        IMP originalImp = method_getImplementation(originalMethod);
        IMP swizzledImp = method_getImplementation(swizzledMethod);

        if (originalImp != swizzledImp) {
            BOOL didAddMethod = class_addMethod(clz, swizzledSelector, originalImp, method_getTypeEncoding(originalMethod));
            if (didAddMethod) {
                class_replaceMethod(clz, originalSelector, swizzledImp, method_getTypeEncoding(swizzledMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
    }

    [self myhook_setDelegate:delegate];
}

- (void)myhook_collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    // add
    NSLog(@"willDisplayCell-myhook: %ld", (long)indexPath.item);
    
    [self myhook_collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
}


@end
